# Les outils

## Développement

### Node
<img src="https://nodejs.org/static/images/logo.svg" width="200" style='float:right; background-color:#333' />
 [Node.js](https://nodejs.org/en/). est un moteur d'exécution JavaScript construit sur le moteur JavaScript V8 de Chrome. Node.js utilise un, non-bloquant modèle I / O event-driven qui le rend léger et efficace. Ensemble de l'écosystème de Node.js, **npm**, est le plus grand écosystème de bibliothèques open source dans le monde.


### npm
<img src="https://www.npmjs.com/static/images/npm-logo.svg" width="200" style='float:right' />
[npm](https://www.npmjs.com/) qui signifie **node package module** est le gestionnaire de dépendances de [node.js](https://nodejs.org/en/). Il est installé en même temps que ce dernier. C'est aujourd'hui le gestionnaire de dépendances le plus fourni, tout langage confondu. Il suit la logique unix, un package doit être simple et modulaire. Les packages node doivent dans la mesure du possible suivre le [Semantic Versionning](http://semver.org/). Les livrables techniques de **Focus** sont hébergés sur npm. Si vous souhaitez en savoir plus sur [npm](http://www.sitepoint.com/beginners-guide-node-package-manager/).


### Babel

<img src="https://babeljs.io/images/logo.svg" width="200" style='float:right; background-color:#f5da55' />

[Babel](https://babeljs.io/) est un compilateur **Javascript** (dernière spécification du langage ES6 / 2015 ou ES7 / 2016) vers **Javascript** (version stable dans les navigateur récents ES5). Il permet d'utiliser les dernières versions du langages dans le développement de tous les jours tout en restant compatibles avec les navigateurs cibles. La transformation du code permet également des améliorations / optimisations sur ce dernier.

### Webpack

<img src="https://webpack.github.io/assets/what-is-webpack.png" width="400" style='float:right' />

[Webpack](https://webpack.github.io/) est un outil servant à développer et packager une application construite sous forme de module. Ces modules peuvent provenir de différentes sources:
- [npm](https://www.npmjs.com/)
- Les modules développés par nos soins
- Les modules développés par vous

Une application est un module composé de modules.

Webpack permet donc de travailler de manière modulaire et de choisir ce que l'on veut en sortie (un fichier JS, plusieurs fichiers JS).
Webpack est également configurable via un système de [plugins](http://webpack.github.io/docs/). Il ne fonctionne pas que pour le JavaScript, il fonctionne égalemeent pour les images, les polices, le style (CSS, SASS, ...).

C'est un outil qui fonctionne en mode différentiel et permet de recharger la page du navigateur en temps réel quand vous modifiez un fichier.

Une aide à la configuration de webpack a été réalisée par l'équipe focus: [webpack-focus](https://github.com/KleeGroup/webpack-focus)

### Brunch

<img src="https://camo.githubusercontent.com/56a4708402855f3c8dc2aff7f4123039a1d12ff0/687474703a2f2f6272756e63682e696f2f696d616765732f7376672f706e672f6272756e63682d6c6f676f2d6e61706b696e2e706e67" width="200" style='float:right' />
C'est l'outil qu'on utilisait avant Webpack en interne, il fonctionne globalement de la même manière (en mode différentiel), mais n'est pas aussi efficace avec les modules nodes et dispose d'un jeu de plugins moins fournis.
Il est cependant très rapide pour transformer les sources et dispose d'une configuration très simple pour démarrer rapidement. Il est également associé à un système de squelette très efficace pour mettre en place rapidement un projet.

### Eslint

<img src="http://eslint.org/img/logo.svg" width="200" style='float:right' />

JavaScript étant un langage dynamique et peu typé, est  sujet à l'erreur de développeur. Sans le bénéfice d'un processus de compilation, le code JavaScript est généralement exécuté afin de trouver la syntaxe ou d'autres erreurs. **ESLint** permettent aux développeurs de découvrir des problèmes avec leur code JavaScript sans l'exécuter.

La principale motivation pour créer **ESLint** a été créée était de permettre aux développeurs de créer leurs propres règles. ESLint est conçu pour avoir toutes les règles de base (comme [jshint](http://jshint.com/) ou [jslint](http://www.jslint.com/)). Les règles par défaut sont écrites comme des règles du plugin serait. Ils peuvent tous suivre le même modèle, à la fois pour les règles elles-mêmes ainsi que des tests. Alors que ESLint sera livré avec des règles intégrées pour le rendre utile dès le début, vous serez en mesure de charger dynamiquement règles à tout moment.
Focus a regroupé un certains nombre de règles existantes afin de bénéficier de règles de codage communes à l'échelle de l'entreprise: [eslint-config-focus](https://github.com/KleeGroup/eslint-config-focus)

## travis

## Communication / Organisation

### Github

### Slack
