Maintenance
===========

## Politique de livraison

FocusJs et FocusComponents ont des nouvelles releases **mineures** toutes les **deux semaines** environ.

Chaque release mineure est suivie dans les jours qui suivent d'une ou plusieurs releases de **patchs**.

Le suivi des releases peut se faire sur les pages de release des projets :
  * https://github.com/KleeGroup/focus/releases
  * https://github.com/KleeGroup/focus-core/releases
  * https://github.com/KleeGroup/focus-components/releases

## Politique de gestion des dépendances

Le build de l'application SPA doit être **déterministe** pour une version du `package.json` donné.

En particulier :
  * le build ne doit **pas** dépendre du **moment** de la dernière exécution de `npm install` sur un projet.
  * le build ne doit **pas** dépendre du **poste** du développeur / build-agent

Pour cela, il faut figer les numéros de versions dans le `package.json` :

```javascript
{
 /* ... */
  "dependencies": {
    "awesomplete": "1.0.0",
    "babel-eslint": "4.0.5",
    "backbone": "1.2.1",
    "daterangepicker": "0.0.3",
    "eslint": "0.24.1"
    /* ...  */
  }
}
```

Pour connaître les numéros de version effectifs dans un projet donné, taper :

```
npm list
```

On obtient l'arbre de dépendances node du projet :

```
├─┬ focusjs@0.9.0-1
│ ├─┬ flux@2.1.1
│ │ ├── fbemitter@2.0.0
│ │ └─┬ fbjs@0.1.0-alpha.7
│ │   ├── core-js@1.1.3
│ │   ├─┬ promise@7.0.4
│ │   │ └── asap@2.0.3
│ │   └── whatwg-fetch@0.9.0
│ ├── keymirror@0.1.1
│ ├── object-assign@2.1.1
│ └── uuid@2.0.1
├─┬ focusjs-components@0.5.1-4
│ ├─┬ babel-core@5.8.23
│ │ ├── babel-plugin-constant-folding@1.0.1
│ │ ├── babel-plugin-dead-code-elimination@1.0.2
```

## Politique de mise à jour des projets

Les projets doivent se mettre **régulièrement** à jour, pour prendre en compte les corrections au fur et à mesure.

Pour se mettre à jour :

```
npm run update-focus
```

Cette commande :
  * télécharge la dernière version de `FocusCore`
  * télécharge la dernière version de `Focus Components`
  * met à jour les numéros de version figé dans le `package.json` du projet

La commande est définie dans le `package.json` du starter-kit :

https://github.com/KleeGroup/focus-starter-kit/blob/master/package.json
