# Getting started

Pour commencer le projet, il est nécessaire de mettre en place l'environnement de développement.

## NodeJS

<img src="https://deversoy.files.wordpress.com/2015/06/nodejs-logo.png" style="float:right" width="200">

[NodeJS](https://nodejs.org/en/) est un framework web serveur permettant d'exécuter du code Javacript sur toute machine en dehors du browser.

### Téléchargement

La dernière version est téléchargeable [ici](https://nodejs.org/dist/v4.1.1/node-v4.1.1-x64.msi).

### Installation

Lancer l'installeur Windows, et suivre les instructions, en laissant les valeurs par défault.

## Editeur de texte

Le code source Javascript du projet peut être édité avec différents logiciels, dont deux sont cités ici.

### Webstorm

<img src="https://upload.wikimedia.org/wikipedia/fr/archive/6/67/20150409204138!Webstorm_logo.gif" style="float:right" width="200">

Voir [l'article dédié ](https://notes.part.klee.lan.net/logiciel/webstorm/start) sur la plateforme .Notes.

### Atom

<img src="https://assets-cdn.github.com/images/modules/integrations/2015-06/logos/atom@2x.png" style="float:right" width="200">

Voir [l'article dédié ](https://notes.part.klee.lan.net/logiciel/atom/start) sur la plateforme .Notes.

## Kit de démarrage (focus-starter-kit)

Un kit de démarrage est fourni [sur Github](https://github.com/KleeGroup/focus-starter-kit).

Ce kit contient une base pour démarrer tout projet Focus.

### Installation

```bash
git clone git@github.com:KleeGroup/focus-starter-kit.git
mv focus-starter-kit nouveau_nom_de_projet
cd nouveau_nom_de_projet
rm -rf .git
npm install
npm run watch
```

### Utilisation

Le kit de démarrage suggère une arborescence type pour la partie client d'une application web. Cette arborescence est détaillée par la suite.

```
.
├── app                                     Dossier principal de l'application
|   ├── assets                              Fichiers statiques
|   |   ├── img
|   |   ├── fonts
|   |   └── index.html
|   ├── config                              Configuration du client
|   |   ├── domain                          Définition des domaines
|   |   ├── entity-definition               Définition des entités
|   |   ├── scopes                          Définition des scopes de recherche
|   |   └── server                          Configuration des routes serveur
|   ├── i18n                                Traductions
|   |   ├── en-GB                           Anglais
|   |   ├── fr-FR                           Français
|   |   ├── generated                       Généré par le serveur
|   |   ├── .eslintrc
|   |   └── index.js
|   ├── initializer                         Initialisation de l'application
|   |   ├── definition-initializer.js       
|   |   ├── domain-initializer.js
|   |   ├── index.js
|   |   ├── layout-initializer.js
|   |   ├── query-store-initializer.js
|   |   ├── reference-list-initializer.js
|   |   ├── translation-initializer.js
|   |   └── user-initializer.js
|   ├── router                              Configuration du routeur client
|   |   ├── home-router.js
|   |   ├── index.js
|   |   └── search-router.js
|   ├── services                            Services client
|   |   ├── index.js
|   |   ├── reference.js
|   |   └── search.js
|   ├── views                               Vues ReactJS
|   |   ├── common
|   |   |   ├── cartridge-search.jsx
|   |   |   └── summary-search.jsx
|   |   ├── home
|   |   |   ├── application-title.jsx
|   |   |   └── index.jsx
|   |   └── menu
|   |   |   └── index.jsx
|   ├── application.js
|   ├── index.js
|   └── legacy.js
├── scripts                                 Scripts applicatifs
|   └── install.js                          Script de post installation npm
├── vendor                                  Librairies inclues dans la build BrunchJs
|   ├── awesomplete.css
|   ├── awesomplete.js
|   ├── i18next.js
|   ├── lodash.js
|   └── material-icons.css
├── .eslintrc                               Configuration du linter ESLint
├── .gitignore                              Configurationd de Git
├── .npmrc                                  
├── README.md                               README présenté par Github
├── brunch-config.js                        Configuration de BrunchJs
└── package.json                            Manifeste du projet
```

#### Assets

Le dossier `assets` contient l'ensemble des fichiers qui seront recopiés à la racine du serveur Web. Ils sont recopiés tels quels et sont donc directement accessibles à la racine du site.

#### Config

Ce dossier contient l'ensemble de la configuration de base de l'application.

Les domaines sont définis dans le sous-dossier `domain`. Ils définissent la manière dont les domaines seront exploités dans les champs du `form`.

Le dossier `entity-definition` est principalement généré par le serveur, et permet de définir le modèle de données de l'application.

Les `scopes` de la recherche sont définis dans le dossier `scopes`.

Finalement, l'ensemble des routes du backend sont définies dans le dossier `server`. C'est ici que les services viennent chercher les routes à adresser lorsque le client effectue des requêtes vers le serveur.

#### i18n

Ce dossier contient l'ensemble des données d'internationalisation de l'application. Les traductions y sont regroupées, référencées par des clés de type `parent.child.prop.etc...`.

#### Initializer

Le lancement de l'application se déroule dans ce dossier. L'ensemble des domaines, des définitions y sont chargées. Les traductions sont initialisées, le layout de page est mis en place, les droits utilisateurs sont définis, et les listes de référence sont mises en place.

#### Router

Le routage client est configuré à travers le contenu de ce dossier. Il est possible de découper le routage à travers différents fichiers, chacun traitant une partie du routage.

#### Views

C'est dans ce dossier que l'on retrouve l'ensemble des composants ReactJS spécifiques à l'application.
