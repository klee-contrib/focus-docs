# Création d'un entête 

Afin de mettre en place un entête pour une page de l'application, deux méthodes sont possibles en fonction du besoin. 
Un entête générique transverse à plusieurs pages peut être mis en place, ou un entête particulier. 
La première méthode implique une surcharge du layout, la seconde une utilisation du mixin CartridgeBehaviour. 

__Surcharge du Layout__
Dans le dossier `initializer`, il est possible de définir le layout de la page et notamment son entête. Pour cela, il suffit de déclarer un autre composant dans la fonction `render` du fichier `layout-initializer` de la façon suivant : 
``` javascript
let AppHeader = require('../views/header');
render(Layout, 'body', {
    props: {MenuLeft, AppHeader}
});
```
Dans le fichier associé au composant AppHeader qui peut se trouver dans le dossier `views/header`, il suffit de déclarer un composant `Header` disponible dans Focus Component. 
Par défaut, si aucun composant n'est défini dans le fichier `layout-initializer` l'entête est défini ainsi : 
``` javascript
class AppHeader extends Component{
    render() {
        return (
            <Header>
                <ContentBar>
                    <Bar />
                    <Cartridge />
                </ContentBar>
                <ContentActions />
            </Header>
        );
    }
}
```
[L'entête Focus](enteteLayout.png)

A savoir, ces composants utilisent le store d'application qui est déjà instancié. Ce store permet d'avoir une notion de store commun dans les composants, notamment dans le cas de l'entête. Initialement ce store est composé par les éléments suivants concernant l'entête : 
* summaryComponent : composant de l'entête réduit
* barContentLeftComponent : composant en haut à gauche de l'entête, présent lorsque l'entête est réduit ou non.
* barContentRightComponent : composant à haut à droite de l'entête présent lorsque l'entête est réduit ou non.
* cartridgeComponent : composant de l'entête non réduit.
* actions : actions disponibles via l'entête.

Il est possible de modifier les composants de cet entête via la fonction `updateComponents()` ou la fonction `_.defer()` qui ajoute des propriété au composant une fois que les composants sont déjà rendus comme le montre l'exemple suivant : 
``` javascript 
const CartridgeContent = React.createClass({
    render(){
        return <div>CARTOUCHE</div>;
    }
});
const Summary = React.createClass({
    render(){
        return <div>SUMMARY</div>;
    }
});
const BarContentRight = React.createClass({
    render(){
        return <div>BAR RIGHT</div>;
    }
});
const BarContentLeft = React.createClass({
    render(){
        return <div>BAR LEFT</div>;
    }
});

function updateComponents(cartridgeConf){
    const {cartridge: cartridgeComponent, summary: summaryComponent, actions: actions, barLeft: barContentLeftComponent, barRight: barContentRightComponent} = cartridgeConf;
    dispatcher.handleViewAction({
      data: {
        cartridgeComponent,
        summaryComponent,
        actions,
        barContentLeftComponent,
        barContentRightComponent
      },
      type: 'update'
    });
}

_.defer(()=>{
    updateComponents({
      cartridge: {component: CartridgeContent, props:{}},
      summary:{component: Summary, props:{}},
      actions: {
          primary: [],
          secondary: []
      },
      barLeft: {component: BarContentLeft, props:{}},
      barRight: {component: BarContentRight, props:{}}
    })
});
```

__Utilisation du Mixin__

Si l'entête d'une page est amené à être différent et utilisé que pour une page, il est intéressant d'utiliser, le mixin : `cartridgeBehaviour`. 
En effet via ce mixin, il est possible d'utiliser la fonction `cartridgeConfiguration()` permettant ainsi de redéfinir l'entête d'une page (cf. la documentation du `cartridgeBehaviour`).


![entetelayout](https://cloud.githubusercontent.com/assets/10349407/9871190/2680f840-5b92-11e5-95b1-9ec79e280c9e.png)
