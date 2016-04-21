# Les cas tordus du Form Mixin
Dans ce tutoriel nous allons expliquer comment bien exploiter certaines propriétés  de certaines fonctions dans un Form Mixin. Nous allons prendre le cas des  ‘fieldFor’ et ‘listfor’, les fonctions les plus utilisées sur les différents projets.
## fieldFor
Pour afficher un champ simple (par exemple un champ `Label`) dans un Form on fait comme suit :
```jsx
	this.fieldFor(‘label’)
```
Par défaut, la fonction `fieldFor` utilise les composants (d’affichage et d’édition) définis sur le domaine du champ. 
Cette fonction offre la possibilité au développeur, de  renseigner le composant à utiliser au lieu de celui qui est défini par défaut par le domaine du champ.
Ci-dessous un exemple d’utilisation de composant customisé :
```jsx
const Textarea = Focus.components.components.input.Textarea;
// ou require('focus-components/components/input/text-area')
// ou import from 'focus-components/components/input/text-area'
…

	this.fieldFor(‘label’, { InputComponent: Textarea})

…
```
Dans  l’exemple ci-dessus, nous surchargeons le composant utilisé en mode édition, le développeur peut également surcharger le composant utilisé en mode affichage avec les  propriétés `InputLabelComponent` ou `FieldComponent`.

Vous pouvez également créer des composants custom à l'aide de fonctions pures: 

```jsx
const MonComposantCustom = (value, label, error) => <div>value: {value}</div>
```

## listFor

Le composant de liste du type sélection est utilisé par défaut quand on appelle la fonction `listFor` dans un `Form`. 
Mais heureusement, tout comme la fonction `fieldFor`, cette fonction donne la possibilité au développeur de  définir le composant liste à utiliser.

* Ci-dessous un exemple dans lequel on affiche une liste sous forme de Timeline en utilisant la fonction listFor dans un Form : 

```jsx
const List = Focus.components.list.timeline.list.component;
const  line = require('../lines/line');
…

this.listFor(‘data’, {LineComponent: line, listComponent: List});

…
```


