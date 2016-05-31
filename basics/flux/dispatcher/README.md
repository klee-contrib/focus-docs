AppDispatcher
=============

## Présentation

Github : [Focus.dispatcher](https://github.com/KleeGroup/focus/blob/master/src/dispatcher/index.js)

Le `AppDispatcher` est le hub central qui fait transiter les données dans la SPA.

Les sources de flux de données sont :
  * les retours d'appels de services (API REST)
  * les actions des vues (sauvegarde d'un block)
  * les appels manuels

Les cibles de flux de données sont :
  * les stores

## Usage

### Store

Le `AppDispatcher` est automatiquement utilisé par les stores via le CoreStore.

Les `stores` s'abonnent aux actions sur des `nodes`.

### Action

Les actions construites via le ActionBuilder appellent automatiquement le `AppDispatcher`.

### Appel manuel

Le `AppDispatcher` publie des méthodes pour dispatcher des données.

Exemple

Appels manuels :
```javascript>
Focus.dispatcher.handleViewAction({
	data: {
		name : 'Raymond'
	},
	type: 'update',
	identifier: 'STORE_ID'
});
```

Détail :
  * j'appelle le dispatcher pour un flux de données issue d'une vue
  * `data` représente les données à transiter
  * `type` représente le type de flux (mise à jour, ...)
  * `identifier` est l'identifiant du store visé
