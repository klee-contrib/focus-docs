Panneau glissant
================

## Présentation

**TODO: image**

Ce composant est un composant React permettant de mettre en place un panneau glissant venant de la droite de la page ou du menu de celle-ci. Ce composant est fait pour apparaître suite à une action sur la page ( clique sur un bouton, sur une ligne d'une liste ou autres ).

## Détail du composant

Le composant panneau glissant est appelé `Popin`, il se trouve dans Focus-components/application/popin.

__Ses attributs__

<table>
<thead>
<tr>
<th>Type </th>
<th align="center">Nom </th>
<th align="center"> Valeurs par défaut </th>
<th align="center"> Valeurs possibles </th>
<th align="center"> Rôle</th>
</tr>
</thead>
<tbody>
<tr>
<td>bool  </td>
<td align="center"> modal  </td>
<td align="center"> false  </td>
<td align="center"> true / false  </td>
<td align="center"> Permet de savoir si la Popin est modal ou non.</td>
</tr>
<tr>
<td>string  </td>
<td align="center"> size  </td>
<td align="center"> Medium  </td>
<td align="center"> Small / Medium / Large </td>
<td align="center"> Permet de définir la taille de la Popin.</td>
</tr>

<tr>
<td>string  </td>
<td align="center"> type  </td>
<td align="center"> full  </td>
<td align="center"> full / from-menu / from-right </td>
<td align="center"> Permet de définir d'où apparaît la Popin </td>
</tr>

<tr>
<td>string  </td>
<td align="center"> level  </td>
<td align="center"> 0  </td>
<td align="center"> 0 / 1 / 2 </td>
<td align="center"> Permet de modifier le z-index du css de la Popin </td>
</tr>

<tr>
<td>string  </td>
<td align="center"> overlay  </td>
<td align="center"> true  </td>
<td align="center"> true / false </td>
<td align="center"> Permet de définir le css de la Popin à visibility : collapse si ce dernier est false. </td>
</tr>

<tr>
<td>bool  </td>
<td align="center"> open  </td>
<td align="center"> true  </td>
<td align="center"> true / false </td>
<td align="center"> Permet de définir si la Popin est à l'état ouverte ou non. </td>
</tr>

</tbody>
</table>


__Ses fonctions__

* __toggleOpen()__ : Fontion permettant d'ouvrir ou de fermer une Popin en changeant son état.

* __onPopinClose()__ : Fonction pouvant être passée en propriété à la Popin. Cette fonction est à écrire.

* ___getAnimationProps()__ : Fonction qui renvoie un json necessaire l'initialisation de la Popin.


* ___validateSize()__ : Fonction permettant de vérifier que la taille de la Popin, définie dans ses props, est valide ( à savoir l'une des trois valeurs possibles). Elle retourne la taille valide ou une lève une exception.


* ___preventPopinClose()__ : Fonction permettant une fermeture de la popin en cas de clique en dehors de la Popin.

## Exemple

Afin de pouvoir mettre en place une Popin il est recommandé de lire la documentation de React sur le this.refs : [https://facebook.github.io/react/docs/more-about-refs.html](https://facebook.github.io/react/docs/more-about-refs.html).
Ce dernier permet de récupérer un element du `render()`.

Pour créer une `Popin`, il suffit de déclarer une `Popin` dans la fonction `render` de votre classe React comme un composant.

Ensuite à l'intérieur de ce composant, il faut définir un composant enfant qui sera le rendu de la Popin.

Il ne reste plus qu'à mettre en place l'évènement qui déclanchera l'ouverture de la Popin en utilisant le `this.refs` pour avoir accès à la fonction d'ouverture (`toggleOpen()`) de la `Popin` déclarée dans la fonction `render()`.

Dans l'exemple, le click du bouton permet d'ouvrir la popin.

```javascript
let Button = FocusComponents.common.button.action.component;
let Popin = Focus.components.application.popin.component;

module.exports = React.createClass({
    ouverturePopinExemple() {
        return this.refs['popinExemple'].toggleOpen();
    },
    render() {
        return (
            <div>

                <Button handleOnClick={this.ouverturePopinExemple}
                        shape='flat'
                        label="Ouverture d'une Popin" type='button'
                        icon="play">
                </Button>
                <Popin ref='popinExemple' type='from-right'>

                   <PopinContent/> //todo
                   <div>Bonjour, je suis la Popin d'Exemple !</div>
                </Popin>
            </div>
        );
    }
});
```
