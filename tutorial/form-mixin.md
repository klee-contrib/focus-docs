# A quoi servent tous les mixins du formulaire ?

Focus vous propose par défaut plusieurs mixins, qui vous permettent d'enrichir très facilement le comportement des composants que vous développez.

## Un mixin c'est quoi ?

Un mixin est __fonction amie__ : elle ajoute des fonctionnalités à votre fonction, votre classe, votre composant ...

## Pourquoi ?

Grâce à ces mixins, vous pouvez facilement ajouter à votre composant tous les fonctionnalités nécessaires pour :
* En faire un formulaire consultable / éditable
* Définir des champs de formulaire qui sauront se rendre automatiquement en fonction du type de donnée (défini dans les domaines)
* Vous connecter aux stores de votre application
* Utiliser les données du référentiel de votre application...

En utilisant ces mixins, vous augmentez très rapidement les capacités de votre composant à adopter un de ces comportements, nécessaire à vos développements.
De plus, vous ne vous souciez plus de réécrire toutes les étapes à un peu lourdes liées : au chargement de données, à la connexion à une source de données, à la validation des données de votre formulaire, ... Ces mixins fournissent l'ensemble de la mécanique pour mettre en place des comportements.

## Quels sont-ils ?

Dans cet article, nous parlons uniquement des mixins liés à la gestion des formulaires. Vous serez principalement amenés à utiliser les mixins suivants :
* `form-mixin` : il embarque tous les comportements pour charger et sauvegarder les données du formulaire, s'abonner aux stores de données, valider les données en surface les données à la soumission, afficher les champs, utiliser les données du référentiel, ... C'est le super-mixin, qui embarque tous les autres. Ce form-mixin est d'ailleurs à utiliser lorsque vous devez implémentez un formulaire classique qui inclut des modes consultation / édition. Pour en savoir plus sur son utilisation, vous pouvez consulter ce tutoriel "[Comment implémenter une page de détail ?](detail.md)"
* `store-behavior` : il facilite la connexion aux stores de données définis dans votre app. Pour en savoir plus sur son utilisation, consultez le tutoriel "[Comment s'abonner à des stores sans le form mixin ?](store-behavior.md)"
* `reference-mixin` : il facilite l'utilisation des listes de données issues du référentiel. Vous pouvez par exemple, très facilement, utilisez une liste de référence pour afficher une liste déroulante. Par défaut, le `form-mixin` l'intère déjà. Il s'avère cependant que dans de nombreux cas l'utilisation du `form-mixin` est trop luxieuse pour avoir à disposition les listes de référence. Sachez que vous pouvez utiliser le `reference-mixin` de manière autonome. Tout est expliqué dans le tutoriel "[Comment utiliser une liste de référence sans le form mixin ?](reference-mixin.md)"
* `built-in-component-mixin` : celui-ci aussi est sympathique. Il offre toutes les fonctions `fieldFor`, `selectFor`, `autocompleteFor`, `listFor`, ... Le `built-in-component-mixin` est embarqué par défaut dans le `form-mixin`. Une fois de plus, l'utilisation de ce dernier peut-être parfois luxieuse. Sachez que vous pouvez utiliser le `built-in-component-mixin` dans votre composant, indépendemment du `form-mixin`. Tout est expliqué dans ce tutoriel "[Comment utiliser les helpers de field sans le form mixin ?](built-in-component-mixin.md)"
