# Les outils

## Aide au développement

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

### Brunch

<img src="https://camo.githubusercontent.com/56a4708402855f3c8dc2aff7f4123039a1d12ff0/687474703a2f2f6272756e63682e696f2f696d616765732f7376672f706e672f6272756e63682d6c6f676f2d6e61706b696e2e706e67" width="200" style='float:right' />
C'est l'outil qu'on utilisait avant Webpack en interne, il fonctionne globalement de la même manière (en mode différentiel), mais n'est pas aussi efficace avec les modules nodes et dispose d'un jeu de plugins moins fournis.
Il est cependant très rapide pour transformer les sources et dispose d'une configuration très simple pour démarrer rapidement. Il est également associé à un système de squelette très efficace pour mettre en place rapidement un projet.

### Eslint

## travis

## Communication / Organisation

### Github

### Slack
