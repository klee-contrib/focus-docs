# Librairies utilisées

## Introduction

Focus utilise massivement le language JavaScript. Une bonne partie du code de Focus est codée directement en JavaScript.

## React

Cependant pour la partie **Composant graphique**, nous nous appuyons sur la librarie [React](https://facebook.github.io/react/).
<img src="http://www.coderstug.org/assets/images/section-past_events/discover-react.jpg" width="200" style='float:right' />

React est une librairie développée par Facebook servant à créer des composants graphique très simplement.

### Principes

Elle est construite autour de principes très simples:
- React ne sert qu'à créer des composants graphiques
<img src="https://upload.wikimedia.org/wikipedia/commons/4/4f/Lego_Chicago_City_View_2001.jpg" width="200" style='float:right' />
- Les composants sont par définition composables à l'infini. (un peu comme des Lego)

- les composants graphques disposent de deux informations les `props` qui sont fournies par un composant parent et qui sont non _mutables_, le `state` qui est mutable et qui traduit de l'état interne du composant.
- Habituellement les composants graphiques sont rendu directrement dans le [Document Object Model](https://developer.mozilla.org/fr/docs/DOM) aussi appellé DOM. Ce dernier, lié au navigateur est assez lent et possède de nombreuses informations liée au navigateur rendant complexe l'interaction avec ce dernier. En s'inspirant des moteurs de jeux video, React s'appuie sur un [DOM Virtuel](https://facebook.github.io/react/index.html), à chaque changement d'état de l'application les composants concernés sont rendus à nouveau dans DOM virtuel.
- React a construit un pont entre le DOM réel et le DOM virtuel, chaque changement dans le DOM virtuel est reporté efficacement dans le DOM réel. Les gains en fiabilité et en performance sont concidérables sur une application.
- React apporte également la syntaxe [JSX](https://facebook.github.io/react/docs/jsx-in-depth.html) qui permet de combiner un style d'écriture à la HTML pour les composants tout en utilisant le JavaScript. Cette syntaxe a grandement contribué au succès de React.
**Exemple:**
```jsx
const HelloMessage = React.createClass({
    render: function() {
        return <div>Hello {this.props.name}</div>;
    }
});
ReactDOM.render(<HelloMessage name="Joe Lopez" />, mountNode);
```
qui donne

```javascript
var HelloMessage = React.createClass({
    displayName: "HelloMessage",

    render: function render() {
        return React.createElement(
            "div",
            null,
            "Hello ",
            this.props.name
        );
    }
});
ReactDOM.render(React.createElement(HelloMessage, { name: "Joe Lopez" }), mountNode);

```

### Sites connus

- [facebook](https://www.facebook.com/)
- [netflix](http://www.netflix.com/browse)
- [yahoo mail](http://www.netflix.com/browse)
- [whatsapp](https://www.whatsapp.com/?l=fr)
- [instagram](https://instagram.com/)
- [airbnb](https://www.airbnb.fr/)
- ...

### Tutoriaux

React étant une librairie très utilisé, elle est très documentée sur le Web. Il est primordial de lire le site officiel pour comprendre les principes de base qui sont très simples.

- Le site de [React](https://facebook.github.io/react/)
- Le tuto React officiel [ici](https://facebook.github.io/react/docs/tutorial.html)
- React pour les gens qui connaissent jQuery: [ici](http://reactfordesigners.com/labs/reactjs-introduction-for-people-who-know-just-enough-jquery-to-get-by/)
- [Build with React](http://buildwithreact.com/)
- [Toto eggheas.io](https://egghead.io/series/react-fundamentals)
- ...

## Google Material Design lite

Focus prend le partie de s'appuyer sur le Material Design, proposé par Google dont la spécification est [ici](https://www.google.com/design/spec/material-design/introduction.html).
Nous avons donc choisi de nous appuyer sur la librairie CSS réalisé par Google appellée [Material Design Lite](http://www.getmdl.io/). La plupart des composants material sont intégrés directement par Focus mais n'hésitez pas à parcourir la documentation de Google qui est très bien réalisée.
