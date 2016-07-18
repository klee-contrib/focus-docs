Composant React
===============

## Présentation

Les composants React sont les briques d'IHM de l'application.

Les composants React se composent les uns les autres pour construire des pages en séparant la complexité.

  * Le Layout est le composant racine de l'application. Il est composé (en cascade) :
    * du menu de gauche
    * du bandeau (avec le cartouche)
    * du composant de contenu principal (qui contient la page courante)
  * les pages sont des composants, rendus dans le Layout
    * une page de détail par exemple, est composée de Block
    * les Block ont un composant Title
    * dans les Block, on utilise des composants Field pour rendre des champs
  * les plus petits composants sont les Button, Icon, Img, ...
  * etc.

Avec différents mixins, on peut donner à un composant les fonctionnalités standard suivantes :
  * S'abonner aux changements de données d'un store
  * Afficher les données issues du store et des props
  * Appeler des actions
