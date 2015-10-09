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

## Kit de démarrage

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
├── app
|   ├── assets
|   |   ├── img
|   |   ├── fonts
|   |   └── index.html
|   ├── config
|   |   ├── domain
|   |   ├── entity-definition
|   |   ├── scopes
|   |   └── server
|   ├── i18n
|   |   ├── en-GB
|   |   ├── fr-FR
|   |   ├── generated
|   |   ├── .eslintrc
|   |   └── index.js
|   ├── initializer
|   |   ├── definition-initializer.js
|   |   ├── domain-initializer.js
|   |   ├── index.js
|   |   ├── layout-initializer.js
|   |   ├── query-store-initializer.js
|   |   ├── reference-list-initializer.js
|   |   ├── translation-initializer.js
|   |   └── user-initializer.js
|   ├── router
|   |   ├── home-router.js
|   |   ├── index.js
|   |   └── search-router.js
|   ├── services
|   |   ├── index.js
|   |   ├── reference.js
|   |   └── search.js
|   ├── views
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
├── scripts
|   └── install.js
├── vendor
|   ├── awesomplete.css
|   ├── awesomplete.js
|   ├── i18next.js
|   ├── lodash.js
|   └── material-icons.css
├── .eslintrc
├── .gitignore
├── .npmrc
├── README.md
├── brunch-config.js
└── package.json
```
#### App
