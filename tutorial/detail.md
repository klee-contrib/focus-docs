# Implémenter une page de détail

Dans ce tutoriel, nous allons créer une page de détail d'une entité, avec édition de ses caractéristiques propres.
Nous allons créer la page de détail d'un film.

## Anatomie d'une page de détail

Une page de détail ressemble à ça :

![](images/detail.png)

Elle est constituée :
- d'un cartridge
- d'une zone de navigation rapide
- d'un ou plusieurs panneaux (ou blocks) de formulaire

## Création de la page

Commençons par créer un dossier pour l'ensemble des composants de cette page de détail, dans notre dossier de vues, `views`.

La manière dont vous organisez votre dossier de vues vous incombe, cependant une bonne pratique est de regrouper les vues par entité.

Dans notre cas, nous créons le dossier `views/movie/detail`.

Créons notre composant parent, `views/movie/detail/index.jsx`:

```js
/* views/movie/detail/index.jsx */
import React, {PropTypes} from 'react';

const MovieDetail = React.createClass({
    displayName: 'MovieDetail',
    propTypes: {
        id: PropTypes.number.isRequired
    },
    render() {
        const {id} = this.props;
        return (
            <div>
                {`Page de détail du movie ${id}`}
            </div>
        );
    }
});

export default MovieDetail;
```

Notre page de détail est pour l'instant très simple, elle n'a qu'une *prop*, `id`, qui lui est fournie par le routeur lorsque l'on navigue vers l'URI `/#movies/{id}`.


## Ajout du premier panneau de détail

### Mise en place du composant

Les attributs de notre entités vont être présentés à travers des panneaux.

Nous allons créer un premier panneau, pour afficher et éditer les caractéristiques principales de notre *movie*.

```js
/* views/movie/detail/characteristics.jsx */
import React, {PropTypes} from 'react';
import {Panel} from 'focus-components/components'

const MovieCharacteristics = React.createClass({
    render() {
        const {id} = this.props;
        return (
            <Panel title='view.movie.detail.characteristics'>
                {`Panneau de caractéristiques du movie${id}`}
            </Panel>
        );
    }
});

export default MovieCharacteristics;
```

Ici, pas besoin de valider à nouveau la *prop* **id**, elle est déjà validée dans le parent.

```js
/* views/movie/detail/index.jsx */
// [...]
import MovieCharacteristics from './characteristics';
// [...]
render() {
    const {id} = this.props;
    return (
        <div>
            <MovieCharacteristics id={id}/>
        </div>
    );
}
// [...]
```

Notre premier panneau est maintenant prêt à recevoir les données depuis le store applicatif, et à faire les appels serveurs permettant le chargement de l'entité dans les store.

### Chargement de l'entité en mémoire

Le chargement de l'entité passe par les stores applicatif, en suivant l'architecture **flux**.

Il est donc nécessaire de lancer une action qui va effectuer le chargement serveur de l'entité, et de s'abonner aux changements du store de l'entité afin de bénéficier des données retournées par le serveur.

Nous allons donc créer les actions et les services associés aux manipulations de cette entité.

```js
/* actions/movie.js */
import movieServices from '../services/movie';
import actionBuilder from 'focus-core/application/action-builder';

export const movieActions = {
    load: actionBuilder({
        node: 'movie',
        service: movieServices.loadMovie,
        shouldDumpStoreOnActionCall: true,
        status: 'loaded'
    }),
    save: actionBuilder({
        node: 'movie',
        service: movieServices.updateMovie,
        shouldDumpStoreOnActionCall: false,
        status: 'saved'
    })
}
```

```js
/* services/movie.js */
import fetch from 'focus-core/network/fetch';
import movieUrl from '../config/server/movies';

export default {
    loadMovie(id) {
        return fetch(movieUrl.load({urlData: {id}}), {isCORS: true});
    },
    updateMovie(movie) {
        const movieId = movie.id;
        return fetch(movieUrl.update({urlData: {id: movieId}, data : movie}), {isCORS: true});
    }
}
```

Notre entité *movie* dispose maintenant de deux méthodes de manipulation, un **load** et et un **save**.

Il est ensuite necessaire de créer le fichier config/movies de la façon suivante : 

```js
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

Appelons le load au chargement de la page de détail afin de disposer des données dans le store et donc dans les vues :

```js
/* views/movie/detail/index.jsx */
// [...]
import {movieActions} from '../../../action/movie';
// [...]
const MovieDetail = React.createClass({
    [...]
    componentWillMount() {
        // Chargement de l'entité depuis le serveur
        movieActions.load(this.props.id);
    },
    [...]
});
// [...]
```

### Affichage de l'entité

Maintenant que l'entité est chargée en mémoire au montage de la page de détail, il est possible de l'afficher dans le panneau *movieCharacteristics*.

Pour cela, nous allons utiliser le **formPreset** dans le panneau, qui va nous faire bénéficier de l'ensemble des fonctionnalités du form, à savoir l'abonnement aux stores, le chargement des définitions avec domaines associés, les helpers de field, et le branchement aux actions de l'entité, le load et le save.

```js
/* views/movie/detail/characteristics.jsx */
[...]
import {mixin as formPreset} from 'focus-components/common/form';
import {movieActions} from '../../../action/movie';
import movieStore from '../../../stores/movie';
[...]
const MovieCharacteristics = React.createClass({
    displayName: 'MovieCharacteristics',
    mixins: [formPreset], // Chargement du preset de form
    definitionPath: 'movie', // définition de notre entité
    stores: [{store: movieStore, properties: ['movie']}], // permet de s'abonner au store
    action: movieActions, // donne les actions au form
    renderContent() {
        return (
            <Panel actions={this._renderActions} title='view.movie.detail.characteristics'> // _renderActions permet d'afficher les actions en tête du panneau, à savoir Editer, Sauver, Annuler
                {this.fieldFor('title')} // Les fieldFor sont des fonctions helper pour afficher et éditer un champ, avec label
                {this.fieldFor('originalTitle')}
                {this.fieldFor('keywords')}
                {this.fieldFor('runtime')}
                {this.fieldFor('movieType')}
                {this.fieldFor('productionYear')}
            </Panel>
        );
    }
});
```

Il est important d'ajouter une *prop* depuis le parent vers `MovieCharacteristics` afin de lui signaler de ne pas effectuer le **load** à son chargement, car le parent le fait déjà. Par défaut, le *formPreset* se chargera de le faire en appelant le `load(this.props.id)`.

Faire le chargement dans le parent permet de s'assurer qu'il n'est fait qu'une fois pour l'ensemble des enfants.

```js
/* views/movie/detail/index.jsx */
// [...]
<div>
    <MovieCharacteristics id={id} hasLoad={false}/>
</div>
// [...]
```

## Ajout d'un second panneau

Nous allons ajouter un panneau propre au synopsis du movie, afin de séparer l'information et de rendre plus limpide la lecture de la page de détail.

Le synopsis est un attribut de notre entité, on bénéficie donc déjà de l'information dans le store `movieStore` dans le noeud `movie`.

```js
/* views/movie/detail/synopsis.jsx */
import Panel from 'focus-components/components/panel';
import {mixin as formPreset} from 'focus-components/common/form';
import {movieActions} from '../../../action/movie';
import movieStore from '../../../stores/movie';

const MovieSynopsis = React.createClass({
    displayName: 'MovieSynopsis',
    mixins: [formPreset],
    definitionPath: 'movie',
    stores: [{store: movieStore, properties: ['movie']}],
    action: movieActions,
    renderContent() {
        return (
            <Panel actions={this._renderActions} title='view.movie.detail.synopsis'>
                {this.fieldFor('synopsis')}
            </Panel>
        );
    }
});

export default MovieSynopsis;
```

```js
/* views/movie/detail/index.jsx */$
// [...]
import MovieSynopsis from './synopsis';
// [...]
<div>
    <MovieCharacteristics id={id} hasLoad={false}/>
    <MovieSynopsis id={id} hasLoad={false}/>
</div>
// [...]
```

## Ajout de la navigation rapide

La navigation rapide est rapidemment mise en place. En effet, il s'agit d'un simple wrapper autour de nos panneaux, qui va de lui-même lister les panneau et mettre en place la navigation.

```js
/* views/movie/detail/index.jsx */$
// [...]
import ScrollspyContainer from 'focus-components/components/scrollspy-container';
// [...]
<ScrollspyContainer gridContentSize={10} gridMenuSize={2}> // Colonne de 10 pour le contenu, colonne de 2 pour le menu de nav rapide
    <MovieCharacteristics id={id} hasLoad={false}/>
    <MovieSynopsis id={id} hasLoad={false}/>
</ScrollspyContainer>
// [...]
```

## Ajout d'une entité dérivée

Afin d'étoffer notre page de détail, nous allons ajouter un panneau traitant un entité dérivée de `movie`, le casting, que nous appellerons `movieCasting`. Il s'agit de l'ensemble des personnes reliées à un film, à savoir les producteurs, réalisateurs, acteurs, etc...

Le chargement des ces entités se fait par un webservice séparé dans la mesure où il ne s'agit pas directement d'un attribut propre au film.

Créons donc les actions et services associés à cette entité dérivée.

```js
/* actions/movieCasting.js */
import movieCastingServices from '../services/movieCasting';
import actionBuilder from 'focus-core/application/action-builder';

export const movieActions = {
    load: actionBuilder({
        node: 'movieCasting',
        service: movieCastingServices.loadMovieCasting,
        shouldDumpStoreOnActionCall: true,
        status: 'loaded'
    }),
    save: actionBuilder({
        node: 'movieCasting',
        service: movieCastingServices.updateMovieCasting,
        shouldDumpStoreOnActionCall: false,
        status: 'saved'
    })
}
```

```js
/* services/movieCasting.js */
import fetch from 'focus-core/network/fetch';
import movieCastingUrl from '../config/server/movieCasting';

export default {
    loadMovieCasting(id) {
        return fetch(movieCastingUrl.load({urlData: {id}}), {isCORS: true});
    },
    updateMovieCasting(movie) {
        const movieId = movie.id;
        return fetch(movieCastingUrl.update({urlData: {id: movieId}, movie}), {isCORS: true});
    }
}
```

Nous allons ajouter un panneau spécifique à cette entité dans la page de détail.

Nous sommes ici face à un cas de correspondance directe entre un noeud du store (`movieCasting`), une paire d'action (load/save) et un panneau d'affichage. Il est donc possible de confier l'appel du load au panneau directement, et ainsi ne pas avoir à préciser le `hasLoad` dans le parent.

```js
/* views/movie/detail/casting.jsx */
import Panel from 'focus-components/components/panel';
import {mixin as formPreset} from 'focus-components/common/form';
import {castingActions} from '../../../actions/movie';
import movieStore from '../../../stores/movie';

const MovieCasting = React.createClass({
    displayName: 'MovieCasting',
    mixins: [formPreset],
    definitionPath: 'movieCasting',
    stores: [{store: movieStore, properties: ['movieCasting']}],
    action: movieCastingActions,
    renderContent() {
        return (
            <Panel actions={this._renderActions} title='view.movie.detail.casting'>
                {...}
            </Panel>
        );
    }
});

export default MovieCasting;
```

Ne pas oublie de l'ajouter au parent :

```js
/* views/movie/detail/index.jsx */$
// [...]
import MovieCasting from './casting';
// [...]
<ScrollspyContainer gridContentSize={10} gridMenuSize={2}> // Colonne de 10 pour le contenu, colonne de 2 pour le menu de nav rapide
    <MovieCharacteristics id={id} hasLoad={false}/>
    <MovieSynopsis id={id} hasLoad={false}/>
    <MovieCasting id={id}/>
</ScrollspyContainer>
// [...]
```

## Ajout du header

Pour finaliser notre page de détail, nous allons ajouter des éléments dans le header (ou cartridge).

Le header a deux modes de fonctionnement : déplié et replié. Il faut donc lui fournir un composant pour chaque mode.

Le store étant déjà peuplé par le composant parent de la page de détail, on peut donc simplement utiliser le formPreset pour s'abonner au store et afficher les champs qui nous intéressent.

### Création des composants

```js
/* views/movie/detail/header-expanded.jsx */
import React from 'react';

import {mixin as formPreset} from 'focus-components/common/form';

import movieStore from '../../../stores/movie';

// Composant custom 
import Poster from '../components/poster';

const MovieHeaderExpanded = React.createClass({
    displayName: 'MovieHeaderExpanded',
    mixins: [formPreset],
    definitionPath: 'movie',
    stores: [{store: movieStore, properties: ['movie', 'movieSynopsis']}],
    renderContent() {
        const {poster, title} = this.state;
        return (
            <div>
                {poster &&
                    <Poster poster={poster} title={title} />
                }
                <h3>{this.textFor('title')}</h3>
                <h5>{this.textFor('movieType')}</h5>
                <h6>{this.textFor('productionYear')}</h6>
                <div>{this.textFor('shortSynopsis')}</div>
            </div>
        );
    }
});

export default MovieHeaderExpanded;
```

Le composant de header replié est similaire, avec quelques informations en moins pour occuper moins de place.

```js
/* views/movie/detail/header-collapsed.jsx */
import React from 'react';

import {mixin as formPreset} from 'focus-components/common/form';

import movieStore from '../../../stores/movie';

const MovieHeaderCollapsed = React.createClass({
    displayName: 'MovieHeaderCollapsed',
    mixins: [formPreset],
    definitionPath: 'movie',
    stores: [{store: movieStore, properties: ['movie', 'movieSynopsis']}],
    renderContent() {
        const {poster, title} = this.state;
        return (
            <div>
                <h3>{this.textFor('title')}</h3>
                <h6>{this.textFor('productionYear')}</h6>
            </div>
        );
    }
});

export default MovieHeaderCollapsed;
```

### Injection des composants dans le header

Nos composants de header sont définis, mais ne sont pas injectés dans le header.

Pour ce faire, on peut utiliser le `cartridgeBehaviour`, qui va permettre d'indiquer à la page quels composants afficher dans le header, ainsi que les actions globales disponibles en tant que boutons dans le header.

Modifions la page parente afin de lui donner le cartridgeBehaviour et d'envoyer les composants dans le header.

```js
/* views/movie/detail/index.jsx */$
// [...]
import MovieHeaderCollapsed from './header-collapsed';
import MovieHeaderExpanded from './header-expanded';
import {component as BackButton} from 'focus-components/common/button/back';
import {cartridgeBehaviour} from 'focus-components/page/mixin';
// [...]
const MovieDetail = React.createClass({
    // [...]
    mixins: [cartridgeBehaviour],
    cartridgeConfiguration() {
        const props = { hasLoad: false, hasForm: false }; // props qui seront données aux composants du header
        return {
            barLeft: { component: BackButton }, // On ajoute le bouton Back en haut à gauche de la page
            cartridge: { component: MovieHeaderExpanded, props },
            summary: { component: MovieHeaderCollapsed, props },
            actions: {
                primary: [{ // action d'exemple
                    label: 'Imprimer',
                    icon: 'print',
                    action: () => { alert('todo print')}
                }],
                secondary: []
            }
        };
    },
    // [...]
});
// [...]
```

## Epilogue

![](https://media.giphy.com/media/lgIyvBoSKEhuo/giphy.gif)
