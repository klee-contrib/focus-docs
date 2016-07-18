# A quoi servent tous les mixins du formulaire ?

Focus vous propose par défaut plusieurs mixins, qui vous permettent d'enrichir très facilement le comportement des composants que vous développez.

## Un mixin c'est quoi ?

Un mixin est __"fonction amie / classe amie"__ : elle ajoute des fonctionnalités et enrichit votre composant...

## Pourquoi ?

Grâce à ces mixins, vous pouvez facilement ajouter à votre composant tous les fonctionnalités nécessaires pour :
* En faire un formulaire consultable / éditable
* Définir des champs de formulaire qui sauront se rendre automatiquement en fonction du type de donnée (défini dans les domaines)
* Vous connecter aux stores de votre application
* Utiliser les données du référentiel de votre application
* **Et encore plein d'autres choses...**

En utilisant ces mixins, vous **augmentez très rapidement les capacités de votre composant** à adopter un de ces comportements, nécessaire à vos développements.
De plus, vous ne vous souciez plus de réécrire toutes les étapes à un peu lourdes liées : au chargement de données, à la connexion à une source de données, à la validation des données de votre formulaire, ... Ces mixins fournissent l'ensemble de la mécanique pour mettre en place des comportements.

## Quels sont-ils ?

Dans cet article, nous parlons uniquement des mixins liés à la gestion des formulaires. Vous serez principalement amenés à utiliser les mixins suivants :

### `form-mixin`

Il embarque **tous les comportements** pour charger et sauvegarder les données du formulaire, s'abonner aux stores de données, valider les données en surface les données à la soumission, afficher les champs, utiliser les données du référentiel, ... **C'est le super-mixin, qui embarque tous les autres**. Ce form-mixin est d'ailleurs à utiliser lorsque vous devez implémentez un formulaire classique qui inclut des modes consultation / édition.

Pour en savoir plus sur son utilisation, vous pouvez consulter ce tutoriel "[Comment implémenter une page de détail ?](detail.md)"

Pour visualiser tout le code, c'est ici : [focus-components/src/common/form/index.js](https://github.com/KleeGroup/focus-components/blob/develop/src/common/form/index.js)

### `store-behaviour`

Il facilite la connexion aux stores de données définis dans votre app.

Pour en savoir plus sur son utilisation, consultez le tutoriel "[Comment s'abonner à des stores sans le form mixin ?](store-behavior.md)"

Pour visualiser tout le code, c'est ici : [focus-components/src/common/mixin/store-behaviour.js](https://github.com/KleeGroup/focus-components/blob/develop/src/common/mixin/store-behaviour.js)

### `reference-behaviour`

Il facilite l'utilisation des listes de données issues du référentiel. Vous pouvez par exemple, très facilement, utilisez une liste de référence pour afficher une liste déroulante. Par défaut, le `form-mixin` l'intère déjà. Il s'avère cependant que dans de nombreux cas l'utilisation du `form-mixin` est trop luxieuse pour avoir à disposition les listes de référence. Sachez que vous pouvez utiliser le `reference-mixin` de manière autonome.

Tout est expliqué dans le tutoriel "[Comment utiliser une liste de référence sans le form mixin ?](reference-mixin.md)"

Pour visualiser tout le code, c'est ici : [focus-components/src/common/form/mixin/reference-behaviour.js](https://github.com/KleeGroup/focus-components/blob/develop/src/common/form/mixin/reference-behaviour.js)

### `built-in-component-mixin`

Celui-ci aussi est sympathique. Il offre toutes les fonctions qui vous permette très rapidement de rendre correctement les champs de votre formulaire, par exemple :
* `autocompleteFor` pour rendre un champ d'autocompletion
* `displayFor` pour rendre un champ en consultation uniquement
* `fieldFor` pour rendre un champ automatiquement en fonction des données du domaine défini
* `textFor` pour rendre le texte d'une propriété uniquement
* `selectFor` pour rendre une liste déroulante
* `buttonDelete`, `buttonEdit`, `buttonCancel`, `buttonSave` pour rendre les actions d'un formulaire
* `listFor` et `tableFor` pour rendre une liste ou un tableau d'éléments
* ...

Pour visualiser tout le code, c'est ici : [focus-components/src/common/mixin/built-in-components.js](https://github.com/KleeGroup/focus-components/blob/develop/src/common/mixin/built-in-components.js)

Le `built-in-component-mixin` est embarqué par défaut dans le `form-mixin`. Une fois de plus, l'utilisation de ce dernier peut-être parfois luxieuse. Sachez que vous pouvez utiliser le `built-in-component-mixin` dans votre composant, indépendemment du `form-mixin`. Tout est expliqué dans ce tutoriel "[Comment utiliser les helpers de field sans le form-mixin ?](built-in-component-mixin.md)"
