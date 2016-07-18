# Comment utiliser les helpers de field sans le form mixin avec le `built-in-components` ?

Ce tutoriel explique comment utiliser les fonctions de field dans votre application, sans utiliser le `form-mixin` (Il est parfois luxieux et inutile d'utiliser le `form-mixin` pour faire cela)...

Par exemple :
* `fieldFor` pour afficher un champ qui se rend automatiquement en fonction des données de son domaine
* `selectFor` pour afficher un champ de type liste déroulante
* `displayFor` pour afficher un champ en mode consultation uniquement
* `textFor` pour afficher le texte d'un champ uniquement
* `listFor` pour afficher une liste
* `tableFor` pour afficher un tableau
* ...    

Cette liste n'est pas exhaustive. [Tous les helpers sont décrits ici](https://github.com/KleeGroup/focus-components/blob/develop/src/common/mixin/built-in-components.js)

## Comment procéder ?

Le code ci-dessous est un exemple d'utilisation. Attention, les données doivent être présentes dans le `state` du composant (pour cela, vous pouvez utiliseur un `store-behaviour` ou bien déclarer les données vous même dans le state du composant).

1. Déclarez le `built-in-components` dans vos imports
2. Entendez le comportement de votre composant à travers la directive `mixins: [BuiltInComponents]`
3. Définissez la définition de votre composant (c'est important, sinon le mixin ne sera pas comment rendre automatiquement votre champ)
4. Utilisez les helpers, par exemple ici `fieldFor`

```javascript
//libraries
import React, {PropTypes} from 'react';

// web components
import Panel from 'focus-components/components/panel';
import builtInComponents from 'focus-components/common/mixin/built-in-components';

export default React.createClass({
    displayName: 'Test',
    mixins: [builtInComponents],
    definitionPath: 'movie',
    getInitialState() {
        return {
            name: 'Amélie'
        };
    },

    /** @inheritDoc */
    render() {
        return (
            <Panel title='test'>
                {this.fieldFor('name')}
            </Panel>
        );
    }
});
```

That's all !
