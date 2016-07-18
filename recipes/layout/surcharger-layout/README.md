Surcharger le layout
====================

## Présentation

Le Layout définit la mise en page globale de l'IHM de l'application.

Pour chacun de ses composants (sauf le menu de gauche), il définit une props avec une valeur par défaut.

## Usage

Pour surcharger le Layout, il suffit d'implémenter un composant et de l'injecter via les props du Layout à son initialisation

## Exemple

Dans le fichier `layout-initializer.js` du starter-kit :

```javascript
let render = Focus.application.render;
let Layout = Focus.components.application.layout.component;
let MenuLeft = require('../views/menu');
let AppHeader = require('../views/common/app-header');

render(Layout, 'body', {
    props: {
        AppHeader,
        MenuLeft,
        footerText: 'Application Acmé Copyright Kleegroup'
    }
});
```

Détail :
  * On require un composant AppHeader spécifique au projet
  * On l'injecte dans le Layout au moment de son rendu
