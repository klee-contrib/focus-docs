# Flux

## Présentation

Dans la SPA, les données sont stockées dans des magasins de données appelés `store`.

Les stores permettent :
  * de définir un ensemble de `nodes` qui organisent les données à l'intérieur d'un store
  * d'accéder en lecture/écriture à ses `nodes`
  * de publier des méthodes pour s'abonner aux changement d'un `node`


Les composants React qui affichent des données s'abonnent à un ensemble de `stores` et de `nodes`.

Pour mettre à jour les données d'un store, on utilise le [AppDispatcher](..:fiche:appdispatcher).
