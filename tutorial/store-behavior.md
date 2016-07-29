# Comment s'abonner à des stores sans le `form-mixin` ?

Ce tutoriel explique comment utiliser les stores de votre application, sans utiliser le `form-mixin` (Il est parfois luxieux et inutile d'utiliser le `form-mixin` pour faire cela)...

## Comment procéder ?

1. Déclarez le `store-behaviour` dans les imports
2. Déclarez le(s) store(s) que vous souhaitez utiliser
3. Déclarez le `store-behaviour` dans les mixins via la directive `mixins: [storeBehaviour]`
4. Déclarez le store utilisé via la directive `stores: [{store: movieStore, properties: ['movieCaracteristics']}]`
5. Lancer le chargement des données dans le store dans la fonction `componentWillMount`

Vos données sont à ce stade présentes dans le `state` de votre composant. Vous pouvez maintenant les utiliser directement !

```javascript
//libraries
import React, {PropTypes} from 'react';

// web components
import Panel from 'focus-components/components/panel';
import builtInComponents from 'focus-components/common/mixin/built-in-components';
import storeBehaviour from 'focus-components/common/mixin/store-behaviour';

//stores & actions
import movieStore from '../../../stores/movie';
import {caracteristicsActions} from '../../../action/movie';

export default React.createClass({
    displayName: 'Test',
    propTypes: {
        id: PropTypes.number.isRequired
    },
    mixins: [builtInComponents, storeBehaviour],
    definitionPath: 'movie',
    stores: [{store: movieStore, properties: ['movieCaracteristics']}],

    /** @inheritDoc */
    componentWillMount() {
        const {id} = this.props;
        caracteristicsActions.load(id);
    },
    
    getInitialState(){
        return (
            ...this._getStateFromStores()
        )
    },


    /** @inheritDoc */
    render() {
        return (
            <Panel title='test'>
                {this.fieldFor('title')}
            </Panel>
        );
    }
});
```

That's all !
