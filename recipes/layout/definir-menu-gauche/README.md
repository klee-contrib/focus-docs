Définir le menu de gauche
=========================

## Présentation

Le menu de gauche permet de naviguer dans les modules de l'application.

Au click sur un menu on peut au choix :
  * naviguer directement sur une page
  * faire apparaître un panneau glissant
    * typiquement pour la recherche rapide

## Usage

Pour définir le menu, il faut définir la liste des items avec :
  * un icône
  * un libellé
  * une route ou un handler de click

## Exemple

```javascript
const type = Focus.component.types;
const menuMixin = Focus.components.application.menu.mixin;

const Menu = React.createClass({
    displayName: 'menu',
    mixins: [menuMixin],
    propTypes: {
        type: type('string'),
        links: type('array')
    },
    renderContent() {
        if ('menuLeft' === this.props.type) {
            return this.props.links.map(link => {
                if (!link.img) {
                    return <a href={link.url}>link.title</a>;
                } else {
                    return <a href={link.url}><img src={link.img}/></a>;
                }
            });
        }
        return this.renderLinks();
    }
});


const Wrapper = React.createClass({
    displayName: 'menu-wrapper',
    _handleClick(){
        // Gère le click : ouverture de popin, etc.
    },
    _getItems() {
        return ([
            {
                icon: 'home',
                route: 'home',
                name: 'Accueil',
                onClick: this._handleClick
            },
            {
                icon: 'cog',
                route: 'admin',
                name: 'Admin',
                onClick: this._handleClick
            }
        ]);
    },
    render() {
        return (
            <div>
                <Menu
                    direction='vertical'
                    items={this._getItems()}
                    open={true}
                    position='left'
                    ref='menu'
                    title=''
                    />
            </div>
        );
    }
});

module.exports = Wrapper;
```

Détail :
  * On définit un composant Menu à partir d'un mixin de menu
  * On définit un composant de Wrapper pour le Menu, dans lequel on définit les items du menu (`_getItems`)
    * ici il y a deux routes, vers la page d'accueil et la page d'administration
