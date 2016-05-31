Définir un service REST
=======================

## Présentation

Un service est une méthode qui exécute une requête HTTP à un web service REST publié par le server.

## Usage

Une requête HTTP est définie par :
  * un URL (contenant éventuellement des paramètres injectés)
  * un verbe HTTP
  * un corps (facultatif)

Le service renvoie une promesse de la requête HTTP qui est asynchrone.

## Exemple

### Fichier des urls

On définit des appels par un pattern d'URL et un verbe.

```javascript
var root = "./movies/";
var url = Focus.util.url.builder;
module.exports = {
    get: url(root + "${id}", 'GET'),
    update: url(root + "${id}",'PUT'),
    castings: url(root + "${id}/" + 'castings', 'GET')
};
```

### Fichier des services

On implémente les méthodes qui utilisent URL définies précédemment en injectant les paramètres et le corps du message.

```javascript
let URL = require('../../config/server');
let fetch = Focus.network.fetch;

module.exports = {
    getMovieById(id) {
        return fetch(URL.movie.get({urlData: {id: id}}))
    },
    updateMovie(jsonMovie) {
        return fetch(URL.movie.update({urlData: {id: jsonMovie.movId}, data: jsonMovie}));
    },
    getMovieCastingsById(id) {
        return fetch(URL.movie.castings({urlData: {id: id}}));
    }
};
```
