# La recherche avancée FOCUS ? comment l'implémenter ?

La recherche est un concept au centre des applications métiers, et donc au centre des concepts FOCUS.

Dans ce tutoriel, nous allons détailler pas à pas l'ensemble des étapes et des componsants FOCUS à utiliser, permettant d'accélérer les développements d'une page de recherche avancée.

## Anatomie d'une page de recherche

La recherche FOCUS reprend les grands principes de recherches issus du e-Commerce :
* Un champ unique de recherche "à la Google" (en haut, toujours visible et accesible en 1 clic)
* Une liste de résultats (triable, groupable) sur laquelle il est possible d'agir en masse (a droite)
* Des filtres prédéfénis sur forme de facettes (à gauche)

![Zonage d'un écran de recherche](images/recherche-avancee-zonage.png)

## Avant de commencer

> Un exemple concret d'implémentation de la recherche avancée a été rédigée par nos petites mimines : https://github.com/KleeGroup/focus-demo-app
>
> Si vous êtes sur le réseau interne, une démo online de la recherche avancée est disponible ici : http://focus-demo.dev.klee.lan.net/

## Que gère le composant FOCUS de recherche avancée ?

Le composant de recherche avancée gère automatiquement:
* La présentation graphique de tous les composants de la recherche avancée, selon la mise en page affichée au dessus
* L'affichage automatique
    * des facettes et valeurs (à gauche), fourni en réponse de l'appel du WS de recherche
    * de la liste de résultats au centre de l'écran
    * du nombre de résultats total pour la requête dans résumé (en haut de la liste)
* Les appels au service de recherche lors
    * de la modification d'un critère de recherche (scope ou input de recherche)
    * d'un clic sur une valeur de facette (à gauche)
    * d'un critère de filtre (dans la barre d'action)
    * d'un critère de grouping (dans la barre d'action)
* La (dé/)selection de toutes les valeurs de la liste de résultat
* Le store des données de recherche
* Les actions liés à la recherche

## Qu'est-ce que le composant FOCUS de recherche avancée ne gère pas ?

* L'appel aux WS de recherche côté serveur backend
* L'affichage des lignes et des actions possibles sur une ligne
* Les actions en masse sur la liste
* L'export des résutlats au format EXCEL / PDF / ...
* La définition des axes de tri et grouping

## 1. Création du service de recherche

Le service de recherche définit dans votre SPA vous permettra de faire le lien avec les services de recherche que vous aurez définis côté Backend.

### Première étape : la configuration des URL

Vous devez normalement avoir défini côté serveur :
* 1 WS par entité recherché (par scope)
* 1 WS pour une recherche gobable (sur tous les scopes)

Cela signifie par exemple, que pour un écran de recherche avancée concernant 2 scopes (dans le cas de la démo : Les films et les personnes), vous devez écrire côté serveur les 3 webservices suivants :
* 1 WS pour le scope FILM
* 1 WS pour le scope PERSONNE
* 1 WS pour le scope TOUT

3 URL de recherche sont donc à prévoir dans la configuration : 1 URL par WS de recherche. Par exemple:
* `http://server/api/movies/search`
* `http://server/api/person/search`
* `http://server/api/common/search`

Définissons ensemble l'URL de recherche d'un film. Rendez-vous dans le répertoire `config/server/movies`. Ce fichier contient la configuration de toutes les WS utiles à la SPA, et qui concerne les films.

Dans le cas présent, les services suivants :
* `create` pour la création d'un fim,
* `load` pour le chargement des données d'un film,
* `update` pour la mise à jour des données d'un film.

Définissez-y une nouvelle entrée `search` de la manière suivante :

```javascript
import builder from 'focus-core/util/url/builder';
import {apiRoot} from './index';

const movieRoot = `${apiRoot}movies/`;

export default {
    create: builder(movieRoot, 'POST'),
    load: builder(movieRoot + '${id}', 'GET'),
    search: builder(movieRoot + 'search?listState.skip=${skip}&listState.sortDesc=${sortDesc}&listState.top=${top}', 'POST'),
    update: builder(movieRoot + '${id}', 'PUT')
};
```

> La fonction `builder` est fournie par la librairie `focus-core`. Elle facilite la déclaration d'URL. Elle prend 2 paramètres:
> * `url` : url d'appel du service http
> * `method` : le mode d'appel parmi les valeurs suivantes (principles)
>    * `GET` utilisé pour récupérer les informations d'une entité. Les paramètres d'appels sont fournis dans l'URL
>    * `POST` utilisé pour créer une entité. Les paramètres d'appel sont postés dans le corps de la requête. Ils peuvent être complétés par des paramètres d'URL
>    * `PUT` utilisé pour mettre à jour une entité. Les paramètres à mettre à jour sont postés dans le corps de la requête. Les paramètres contextuels (par exemple l'id de l'entité à mettre à jour) sont passés en paramètre d'URL

L'URL `search` que vous déclarez doit être en mode `POST` car les informations recherchées et saisies par l'utilisateur seront transmises dans le corps de la requête. Les paramètres contextuels de la recherche, sont passés déclarés dans l'URL:
* `skip` indique le nombre de résultats de recherche déjà connus par l'application, et donc que le serveur ne doit pas renvoyer
* `sortDesc` indique si le tri des résultats doit être descendant (ou non)
* `top` indique le nombre de résultats de recherche que le serveur doit renvoyer

C'est grâce à la combinaison des paramtères `skip` et `top` que la pagination des résultats est gérée.

Pour plus d'exemples : https://github.com/KleeGroup/focus-demo-app/tree/develop/app/config/server

### Seconde étape : la définition du service

Commençons par créer un ficher `search.js` qui contiendra toute la logique d'appel des WS de rechercher sur le serveur.

Le fichier peut contenir la structure suivante:

```javascript
export default {

    /**
     * Target search service call.
     * (This should the target : search service should be written this way.)
     *
     * @param  {object} config search call configuration.
     * @param  {string} scope  scope search
     * @return {object}        search response
     */
    _search(config, scope) {
        switch (scope) {
            case 'movie':
                //appelez ici le service de recherche de movie
            case 'person':
                //appelez ici le service de recherche d'une personne
            default:
                //appelez ici le service de recherche portant sur tous les scopes
        }
    },

    /**
    * Search with scope.
    * @param  {Object} AdvancedSearch config that launches the call of this service
    * @return {Promise}
    */
    scoped(config) {
        const {data} = config;
        const {scope} = data;
        return this._search(config, scope);
    },

    /**
    * Search without scope.
    * @param  {Object} AdvancedSearch config that launches the call of this service
    * @return {Promise}
    */
    unscoped(config) {
        return this._search(config);
    }

};
```

Votre fichier doit contenir impérativement les services suivants:
* `scoped` qui sera appelé par le composant de recherche avancée pour toute requête au serveur concernant un scope en particulier : par exemple le scope FILM
* `unscoped` qui sera appelé par le composant de recherche avancée pour toute requête au serveur dont aucun scope n'est pas précisé (scope ALL)

L'important dans tout cela, c'est la méthode `search` qui exécutera les appels aux bons WS en fonction du scope.

Exemple d'implémentation d'un appel :
```javascript
import fetch from 'focus-core/network/fetch';

import moviesUrl from '../config/server/movies';

export default {


    /**
     * Target search service call.
     * (This should the target : search service should be written this way.)
     *
     * @param  {object} config search call configuration.
     * @param  {string} scope  scope search
     * @return {object}        search response
     */
    _search(config, scope) {
        switch (scope) {
            case 'movie':
                return fetch(moviesUrl.search(config));
            case 'person':
                return ...; //appelez ici le service de recherche d'une personne
            default:
                return ...; //appelez ici le service de recherche portant sur tous les scopes
        }
    },

    /**
    * Search with scope.
    * @param  {Object} AdvancedSearch config that launches the call of this service
    * @return {Promise}
    */
    scoped(config) {
        const {scope} = criteria;
        return this._search(config, scope);
    },
    /**
    * Search without scope.
    * @param  {Object} AdvancedSearch config that launches the call of this service
    * @return {Promise}
    */
    unscoped(config) {
        return this._search(config);
    }
};
```

Pour un exemple complet, tout est ici : https://github.com/KleeGroup/focus-demo-app/blob/develop/app/services/search.js

### Format des données échangées

En entrée, le service de recherche entrant s'attend à recevoir des données sous ce format:
```json
{
    criteria: "*",
    facets: {FCT_MOVIE_TYPE: "Court-métrage"} // aucune facette n'est envoyée dans le cas où le scope est 'ALL'
}
```

En sortie, le service de recherche sortant va envoyer renvoyer des données sous ce format:

*Pour un scope ALL*
```json
{
  "groups": [
    {
      "movie": [
        {
          "code": 100037,
          "title": "Fight for Your Life",
          "titleSortOnly": "Fight for Your Life",
          "movieType": "Long-métrage",
          "productionYear": 1977
        },
        {
          "code": 10004,
          "title": "Hurler de peur",
          "titleSortOnly": "Hurler de peur",
          "poster": "http://fr.web.img4.acsta.net/medias/nmedia/18/73/37/79/19200311.jpg",
          "movieType": "Long-métrage",
          "productionYear": 1961
        },
        ...
      ]
    },
    {
      "person": [
        {
          "code": 107597,
          "fullName": "David Purvis",
          "fullnameSortOnly": "David Purvis",
          "sex": "M",
          "activity": "Acteur",
          "movies": "[847, 108543, 58293, 43023, 202, 7]"
        },
        {
          "code": 1076,
          "fullName": "Saida Bekkouche",
          "fullnameSortOnly": "Saida Bekkouche",
          "sex": "F",
          "activity": "Actrice",
          "movies": "[209117, 186028, 684, 145101, 182064, 57432, 35519, 42452, 14455, 189283, 13258, 10232, 310]"
        },
        ...
      ]
    }
  ],
  "facets": [
    {
      "FCT_SCOPE": [
        {
          "movie": 12741
        },
        {
          "person": 11685
        }
      ]
    }
  ],
  "totalCount": 24426
}
```

*Pour un scope sélectionné, ici "Movie"*
```json
{
  "list": [
    {
      "code": 100037,
      "title": "Fight for Your Life",
      "titleSortOnly": "Fight for Your Life",
      "movieType": "Long-métrage",
      "productionYear": 1977
    },
    {
      "code": 10004,
      "title": "Hurler de peur",
      "titleSortOnly": "Hurler de peur",
      "poster": "http://fr.web.img4.acsta.net/medias/nmedia/18/73/37/79/19200311.jpg",
      "movieType": "Long-métrage",
      "productionYear": 1961
    },
    ...
  ],
  "facets": [
    {
      "FCT_MOVIE_TYPE": [
        {
          "Long-métrage": 10493
        },
        {
          "Télefilm": 1368
      },
        ...
      ]
    },
    {
      "FCT_MOVIE_TITLE": [
        {
          "#": 132
        },
        {
          "a-f": 3205
      },
        ...
      ]
    },
    {
      "FCT_MOVIE_YEAR": [
        {
          "\u003c années 30": 262
        },
        {
          "années 30": 328
        },
        {
          "années 40": 421
        }
      ]
    }
  ],
  "totalCount": 12741
}
```

> Attention ! Le serveur doit renvoyer une entrée pour chacun des scopes, même s'ils sont vides !

## 2. Création du repértoire de la vue

Commençons par créer un dossier pour regrouper l'ensemble des vues relatives à la recherche dans le projet, dans le répertoire `views`.

La manière dont vous organisez votre dossier vous incombe. Cependant, nous vous conseillons très fortement cette organisation. Regroupez tous vos écrans de recherche dans le répertoire `views/search`, qui contiendra :
* `views/search/advanced` qui contiendra les développements spécifiques à la recherche avancée
* `views/search/lines` qui contiendra l'implémentation du rendu des lignes pour la recherche (avancée et rapide)
* `views/search/quick` qui contiendra les développements spécifiques à la [recherche rapide](recherche-rapide.md)

## 3. Création de la vue

Dans le répertoire `views/search/advanced`, créez un in fichier `index.jsx` qui constituera la vue Recherche Avancée.

Le contenu de ce fichier est assez simple puisqu'il consiste à créer un composant `React` qui intègre:
* Le composant de recherche avancée standard de FOCUS
* La configuration de la recherche avancée (tout cela est décrit dans la section suivante)

```javascript
import React, {PropTypes} from 'react';

// web components
import {component as AdvancedSearch} from 'focus-components/page/search/advanced-search';

//line mapping
import {configuration} from './configuration';

function AdvancedSearchView() {
    return <AdvancedSearch {...configuration} />;
};

AdvancedSearchView.displayName = 'AdvancedSearch';
export default AdvancedSearchView;
```

La configuration définit au final un simple objet Javascript, dont les proriétés correspondent aux "props" du composant React `AdvancedSearch`.
Il est déclaré via l'annotation `{...configuration}` qui a pour effet d'éclater les propriétés de l'objet dans les props du composant `AdvancedSearch`.

Un exemple très concret ? c'est par ici : https://github.com/KleeGroup/focus-demo-app/tree/develop/app/views/search/advanced

## 4. Création de la configuration

La configuration contient tout le paramétrage qui est fourni au composant de recherche avancée. Nous vous conseillons de placer fichier dans le répertoire `views/search/advanced/configuration/index.js`.

Voici la configuration minimale dont vous avez besoin :
```javascript
// seearch services
import service from '../../../../services/search';

//search configurations
import cartridgeConfiguration from './cartridge';
import lineMapper from '../../lines/mapper';
import onLineClick from '../../lines/line-click';
import {scopesConfig} from '../../../../config/scopes';
import actionBuilder from 'focus-core/search/action-builder';

import searchBuiltInStore from 'focus-core/search/built-in-store';
const advancedSearchStore = searchBuiltInStore.advancedSearchStore;

export const configuration = {
    action: actionBuilder({
        service,
        identifier: advancedSearchStore.identifier,
        getSearchOptions: () => advancedSearchStore.getValue.call(advancedSearchStore) // Binding the store in the function call
    }),
    onLineClick,
    isSelection: true,
    cartridgeConfiguration,
    lineComponentMapper: lineMapper,
    groupMaxRows: 5, // ne fonctionne pas, n'est pas renvoyé dans la config du service search.
    scopesConfig: scopesConfig
};
```

* La props `action` définit l'action à utiliser. Si le service est défini, la props action peut rester nulle et l'action est automatiquement créée par le composant
* La props `backToTopComponent` permet de surcharger le composant de retour en haut de la page. Par défaut, [https://github.com/KleeGroup/focus-components/blob/develop/src/components/button-back-to-top/index.js](c'est celui-ci est utilisé).
* La props `cartridgeConfiguration` définit la configuration du cartouche pour la vue recherche avancée, et notamment les composants Scope et Input qui permettent de lancer la recherche
* La props `groupComponent` permet de surcharger le composant de rendu d'une liste de résultats groupées.[https://github.com/KleeGroup/focus-components/blob/develop/src/page/search/advanced-search/group.js](Par défault, c'est lui qui est utilisé).
* La props `groupMaxRows` définit le nombre d'éléments par défaut affichés par groupe.
* La props `hasBackToTop` indique si le bouton de retour en haut de page (affiché en bas à droite) est affiché.
* La props `isSelection` définit le caractère sélectionnable en masse des résultats de la liste (à coupler avec des actions à en masse)
* La props `lineComponentMapper` definit la façon dont les lignes doivent se rendre (en fonction de leur type)
* La props `lineOperationList` définit l'ensemble des actions sur un item de la liste.
* La props `onLineClick` définit le comportement à adopter lors d'un clic sur une ligne de résultat.
* La props `orderableColumnList` définit la liste des entrées par lesquelles le tri peut s'appliquer. Le formation attendu est `[{key:'columnKey', label:'columnLabel'}]`
* La props `openedFacetList` définit la liste des facettes qui doivent s'afficher ouvertes par défaut
* La props `scopesConfig` est un fichier de mapping qui a pour objectif de mapper les valeurs des scopes renvoyées par le serveur avec les valeurs des scopes définies sur dans votre application JS.
* La props `scrollParentSelector` définit le selecteur CSS du conteneur parent sur lequel le scroll va écouter. Par défaut, aucun sélecteur n'est appliqué. Le conteneur est positionné sur la page
* La props `service` définit le service de recherche qui sera lancé lors des différentes actions de recherche sur la vue. Cela correspond bien sur au service que vous avez définit juste avant...
* La props `store` permet de surcharger le store par défaut : `advancedSearchStore` définit dans `focus-core/search/built-in-store`. Vous n'avez normalement pas besoin de le surcharger
* Enfin, la props `lineOperationList` prend un tableau, dont la structure est la suivante :
```javascript
[
    {
        action(data) {
            // l'action à exécuter au clic sur le bouton
        },
        style: {shape: 'fab'}, // le style du bouton Material Design Lite
        label: 'Preview', // le libellé du bouton
        icon: 'remove_red_eye', // l'icône du bouton
    },
    { ... },
    { ... },
    { ... }
]
```

## 5. Définition de la configuration de l'entête

A cette étape, vous aurez forcément envie d'injecter les champs critères de lancement dans votre cartouche, principalement pour tester:
* l'appel des services de recherche implémentés
* la mise à jour des données dans les stores de recherche
* et puis tout simplement qu'il se passe quelque chose !

Focus facilite la mise en place du cartouche contenant ces critères de lancement, sous la forme suivante (en jaune):
![Critères de lancement dans le cartridge](images/recherche-avancee-cartridge.png)

Pour ce faire, il suffit juste de définir la configuration de ce cartouche comme ceci:
```javascript
import CartridgePageSearch from 'focus-components/page/search/search-header/cartridge';
import SummaryPageSearch from 'focus-components/page/search/search-header/summary';
import service from '../../../../services/search';

export default function cartridgeConfiguration() {
    return {
        summary: {
            component: SummaryPageSearch,
            props: { service }
        },
        cartridge: {
            component: CartridgePageSearch,
            props: { service }
        },
        actions: {
            primary: [],
            secondary: []
        }
    };
}
```

Deux composants sont fournis par FOCUS :
* `focus-components/page/search/search-header/cartridge` : affiche le composant pour le mode déplié du cartouche. Il gère également l'affichage du titre.
* `focus-components/page/search/search-header/summary` : affiche le composant pour le mode replié du cartouche

L'avantage d'utiliser ces composants, c'est que toute la logique d'écoute du store de recherche avancée est déjà implémentée. Les composants s'utilisent tels quel.

Le service de recherche est passé en props des 2 composants pour qu'ils consomment ces services lors d'une action de l'utilisateur.

Enfin, comme pour toute configuration d'entête FOCUS, vous avez la possibilité de définir les actions propres à votre écran.

Bien sûr, cette configuration est la configuration standard FOCUS. Vous avez également possibilité de définir vos propres composants / critères de lancement. Mais autant rester dans le standard...

## 6. Création du Line Mapper

Le `lineComponentMapper` est la configuration qui décrit le mapping de rendu d'une ligne de résultat, en fonction de son type et ses données. Grâce à ce mapper, la liste de résultats de recherche saura quel rendu adopter en fonction du type de donnée passé.

Vous pouvez le définir dans le répertoire `views/search/lines`, sous le nom `mapper.js`:

```javascript
import DefaultLine from './line';
import MovieLine from './movie';
import PersonLine from './person';

export default function lineComponentMapper(groupKey) {
    switch (groupKey) {
        case 'movie': return MovieLine;
        case 'person': return PersonLine;
        default: return DefaultLine;
    }
}
```

Décrivez ensuite le composant de rendu de chaque ligne. Par exemple, celui d'un film (`views/search/lines/movie.js`):

```javascript
//libraries
import React, {PropTypes} from 'react';
import {mixin as lineMixin} from 'focus-components/list/selection/line'

export default React.createClass({
    displayName: 'MovieLine',
    mixins: [lineMixin],
    definitionPath: 'movie',
    propTypes: {
        data: PropTypes.object.isRequired
    },
    renderLineContent() {
        const {data} = this.props;
        const {code} = data;
        return (
            <div key={code} data-demo='movie-line'>
                <div className='level1'>{this.textFor('title')}</div>
                <div className='level2'>{this.textFor('movieType')}</div>
                <div className='level3'>{this.textFor('productionYear')}</div>
            </div>
        );
    }
});
```

Le composant que vous venez d'écrire intègre le mixin `focus-components/list/selection/line`, qui va afficher sur la ligne:
* les comportements nécessaires à l'affichage d'actions unitaires
* le mécanisme de sélection de l'objet

Le mixin définit aussi les props d'entrée du composant ligne. Un composant ligne se voit toujours attribué la props `data` qui correspond aux données de la ligne qui pourront être affichées.

Le mixin débraye le rendu du contenu spécifique à la ligne dans la fonction `renderLineContent`. Vous n'avez pas à implémenter la gestion de la selection, ni le mécanisme d'actions sur la ligne, le composant le fait tout seul.

Bien sûr, vous affichez un élément d'une liste et React a besoin d'une clé pour identifier de manière unique l'élément de la ligne. N'oubliez pas définir la clé de la ligne via l'attribut `key`. Vous éviterez quelques warning dans votre console, et de potentiels bugs pour la suite...


## 7. Définition du comportement au clic sur une ligne

Le comportement au click sur une ligne se définit également dans une fichier de mapping, par exemple dans le fichier `views/search/lines/line-click.js`.
Bien sûr, le comportement n'est pas le même en fonction du type de la ligne cliquée. Par exemple, si le type est `person`, bien souvent il est souhaité redirigier l'utilisateur vers la page de détail personne. Si le type est film, vers la page de détail d'un film. Mais vous pouvez aussi ici définir l'ouverture d'un panneau latéral glissant dans la droite.

L'exemple ci-dessous illustre la définition d'un fichier de mapping des comportements au clic sur une ligne:

```javascript
import history from 'focus-core/history';

export default function onLineClick(data) {
    let url = '#';
    const {code, type} = data;
    if('movie' === type) {
        url = `#movies/${code}`;
    }
    if('person' === type) {
        url = `#persons/${code}`;
    }
    history.navigate(url, true);
    window.scrollTo(0, 0);
}
```

`history` est importé de `focus-core` pour gérer la navigation.

Bien souvent, dans l'usage d'un écran de recherche, l'utilisateur scrolle pour accéder à l'entité qu'il recherche. Dans la logique d'une SPA (une seule page), il est donc souvent intéressant de remonter l'ascenseur en haut de la page lors d'une navigation. Dans le cas contraire, la nouvelle page affichée est positionnée au niveau du scroll courant. La position du scroll n'est pas modifiée automatiquement par le système, mais à la demande du développement. C'est pourquoi vous voyez apparaitre un `window.scrollTo(0,0)` à la suite de la navigation.

# Comment changer l'interface de "grouping" des résultats de recherche ?

Par défaut, la recherche FOCUS fournit l'interface pour grouper les résultats de recherche selon une clé. Cela ressemble à ça :

![Composant groups](images/recherche-avancee-groups.png)

Le composant "Group" définit le rendu pour un group. Il est répété dans les résultats de recherche, autant de fois qu'il y a de group à afficher. Et cela dépend bien sûr de la clé de grouping.

Ce composant est intégré par défaut par FOCUS. Par curiosité, vous pouvez allez consulter le code ici : https://github.com/KleeGroup/focus-components/blob/develop/src/page/search/advanced-search/group.js

Dans le cas où votre interface à développer est différente de celle proposée par défaut par FOCUS, vous avez la possibilité de proposer votre propre composant de Grouping. Pour cela, indiquez le dans le fichier de configuration de votre recherche dans `views/search/advanced/configuration/index.js`. Ajoutez dans la configuration en définissant le composant de rendu dans la props `groupComponent`. Par exemple:

```javascript
...
import monComposantGroup from './components/monComposantGroup';
...
export const configuration = {
    ...
    groupComponent: monComposantGroup,
    ...
};
```

Il y a malgré tout un certain contrat à respecter dans les props définies dans votre composant sur mesure. En effet, c'est tout de même le composant `AdvancedSearch` de FOCUS qui va instancier et rendre votre composant. Et donc lui donner les données contextuelles au groupe de données à afficher. Votre composant doit ainsi définir les props suivantes :

```javascript
const propTypes = {
    canShowMore: PropTypes.bool.isRequired, //indique si un bouton showmore doit être rendu pour le group
    count: PropTypes.number.isRequired, // le nombre de resultats total du group, à afficher
    groupKey: PropTypes.string.isRequired, // la clé correspondante au group
    showAllHandler: PropTypes.func.isRequired, // la gestion de l'action à réaliser au clic sur le bouton "Show all"
    showMoreHandler: PropTypes.func.isRequired // la gestion de l'action à réaliser au clic sur le bouton "Show more"
};
```

### Données échangées avec le serveur :

*Requête*
```json
{
    criteria: "*",
    facets: {FCT_MOVIE_TYPE: "Télefilm"},
    group: "FCT_MOVIE_YEAR"
}
```

*Résultats*
```json
{
  "groups": [
    {
      "\u003c années 30": []
    },
    {
      "années 30": []
    },
    {
      "années 40": []
    },
    {
      "années 50": [
        {
          "code": 11108,
          "title": "The Ed Sullivan Show",
          "titleSortOnly": "The Ed Sullivan Show",
          "movieType": "Télefilm",
          "productionYear": 1956
        },
        {
          "code": 176257,
          "title": "Cinderella",
          "titleSortOnly": "Cinderella",
          "movieType": "Télefilm",
          "productionYear": 1957
        }
      ]
    },
    {
      "années 60": [
        {
          "code": 129063,
          "title": "La Mégère apprivoisée",
          "titleSortOnly": "La Mégère apprivoisée",
          "movieType": "Télefilm",
          "productionYear": 1964
        },
        {
          "code": 130008,
          "title": "Laura",
          "titleSortOnly": "Laura",
          "movieType": "Télefilm",
          "productionYear": 1968
        },
        ...
      ]
    },
    {
      "années 70": [
        {
          "code": 109596,
          "title": "Brève rencontre",
          "titleSortOnly": "Brève rencontre",
          "movieType": "Télefilm",
          "productionYear": 1974
        },
        {
          "code": 144826,
          "title": "A Day Out (TV)",
          "titleSortOnly": "A Day Out (TV)",
          "movieType": "Télefilm",
          "productionYear": 1972
        },
        ...
      ]
    },
    {
      "années 80": [
        {
          "code": 10597,
          "title": "Medea",
          "titleSortOnly": "Medea",
          "movieType": "Télefilm",
          "productionYear": 1988
        },
        {
          "code": 105998,
          "title": "In This Corner",
          "titleSortOnly": "In This Corner",
          "movieType": "Télefilm",
          "productionYear": 1985
        },
        ...
      ]
    },
    {
      "années 90": [
        {
          "code": 108505,
          "title": "Futuresport",
          "titleSortOnly": "Futuresport",
          "poster": "http://fr.web.img2.acsta.net/medias/nmedia/18/71/08/98/19122717.jpg",
          "movieType": "Télefilm",
          "productionYear": 1998
        },
        {
          "code": 108555,
          "title": "Fenêtre sur crime (TV)",
          "titleSortOnly": "Fenêtre sur crime (TV)",
          "poster": "http://fr.web.img1.acsta.net/medias/nmedia/18/96/60/43/20478229.jpg",
          "movieType": "Télefilm",
          "productionYear": 1991
        },
        ...
      ]
    },
    {
      "années 2000": [
        {
          "code": 109065,
          "title": "L\u0027Anneau sacré",
          "titleSortOnly": "L\u0027Anneau sacré",
          "poster": "http://fr.web.img3.acsta.net/medias/nmedia/18/36/12/73/18454725.jpg",
          "movieType": "Télefilm",
          "productionYear": 2004
        },
        {
          "code": 109921,
          "title": "Warm Springs",
          "titleSortOnly": "Warm Springs",
          "movieType": "Télefilm",
          "productionYear": 2005
        },
        ...
      ]
    },
    {
      "\u003e années 2010": [
        {
          "code": 177788,
          "title": "Famille décomposée",
          "titleSortOnly": "Famille décomposée",
          "poster": "http://fr.web.img3.acsta.net/medias/nmedia/18/74/30/76/19252837.jpg",
          "movieType": "Télefilm",
          "productionYear": 2010
        },
        {
          "code": 177803,
          "title": "Je, François Villon, Voleur, Assassin, Poète",
          "titleSortOnly": "Je, François Villon, Voleur, Assassin, Poète",
          "movieType": "Télefilm",
          "productionYear": 2010
        },
        ...
      ]
    }
  ],
  "facets": [
    {
      "FCT_MOVIE_TYPE": [
        {
          "Télefilm": 1368
        }
      ]
    },
    {
      "FCT_MOVIE_TITLE": [
        {
          "#": 9
        },
        {
          "a-f": 316
        },
        ...
      ]
    },
    {
      "FCT_MOVIE_YEAR": [
        {
          "\u003c années 30": 0
        },
        {
          "années 30": 0
        },
        ...
      ]
    }
  ],
  "totalCount": 1368
}
```
