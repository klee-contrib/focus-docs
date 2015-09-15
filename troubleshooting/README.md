# Problèmes récurents

Cette page liste les messages d'erreurs qui arrivent régulièrement et comment les analyser.

## Utilisation d'un objet qui n'est pas un composant React

### Symptômes

Stacktrace :

```
Uncaught TypeError: type.toUpperCase is not a function
```

### Analyse

Ceci arrive quand on tente d'utiliser un objet comme composant React alors que ce n'est pas un composant React.

[Issue Github](https://github.com/facebook/react/issues/3478)

Cela arrive typiquement quand :
  * On oublie d'exporter le composant dans son module (avec `module.exports = `)
  * On exporte un `mixin` (un objet litéral) au lieu d'un composant (un objet structuré issu de `React.createClass`)

Exemple :

```javascript
var MonComposant = {};
var Hello = React.createClass({
    render: function() {
        return <MonComposant>Hello {this.props.name}</MonComposant>;
    }
});
```
