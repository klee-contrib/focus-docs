# Comment utiliser une liste de référence sans le `form-mixin` ?

Ce tutoriel explique comment utiliser les listes de référence déclarées dans votre application, sans utiliser le `form-mixin` (Il est parfois luxieux et inutile d'utiliser le `form-mixin` pour faire cela)...

# Comment procéder ?

1. Déclarez le `referenceBehaviour` dans vos imports
2. Etendez le comportement de votre composant à travers la directive `mixins: [referenceBehaviour],`
3. Définissez la liste à récupérer à l'aide de la syntaxe `referenceNames: ['genders']`
4. Utiliser la liste de référence dans votre composant :


```javascript
//librairies
import React, {PropTypes} from 'react';

// web components
import Panel from 'focus-components/components/panel';
import referenceBehaviour from 'focus-components/common/form/mixin/reference-behaviour';

[...]

export default React.createClass({
    displayName: 'PersonIdentity',
    propTypes: {
        id: PropTypes.number.isRequired
    },
    mixins: [referenceBehaviour],
    referenceNames: ['genders'],

    [...]

    /** @inheritDoc */
    renderContent() {
        return (
            <Panel title='view.person.detail.identity'>
                {this.fieldFor('fullName')}
                {this.fieldFor('sex', {listName: 'genders'})}
            </Panel>
        );
    }
});
```

Ici, la liste de référence est déclarée sur le `fieldFor`.

Vous pouvez également la récupérer directement dans le state pour itérer dessus. Par exemple :

```javascript
const referenceList = this.state.reference.[nom-de-la-liste-de-reference];
```

That's all !
