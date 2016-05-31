# Ecrire ma première page

Ce tutoriel décrit l'ensemble des actions à réaliser, étape par étape, pour écrire une première page FOCUS.

Les concepts suivants seront mis en musique
* [Backbone](http://backbonejs.org/) : [Router](http://cdnjs.com/libraries/backbone.js/tutorials/what-is-a-router)
* [React](https://facebook.github.io/react/) : [Composant](https://facebook.github.io/react/docs/tutorial.html)


## Etape 1 : Ouverture du projet dans l'éditeur
Ouvrir Atom ou votre environnement de développement Javascript de prédilection. (si vous n'avez pas d'éditeur de préféré, nous vous conseillons d'utiliser Atom. La documentation d'installation de l'outil est [ici](/getting-started).)

1. Ouvrir une console SHELL à la racine du répertoire de votre projet
2. taper la commande ```atom .```

![Commande pour ouvrir l'éditeur](./images/launch_atom.png)

L'application Atom s'ouvre alors directement dans le répertoire du projet.

![Atom](./images/atom_launched.png)

## Etape 2 : Création du fichier routeur
La route est le chemin qui permet d'accéder à votre page. Avant de créer votre page, il vous faut déclarer la route (l'URL) par laquelle vous y accéderez.

1. Editer le fichier ```app/router/index.js```. Ce fichier liste l'ensemble des points d'entrée des routes.
> Nous vous recommandons d'ajouter un point d'entrée par KeyConcept

2. Ajouter une entrée dans le fichier ```index.js``` (si votre KeyConcept n'existe pas)

![Ajouter une entrée dans le router](./images/router1.png)

3. Créer le fichier ```router``` déclaré  (ici ```myConcept-router.js```)

4. Déclarer les routes

```javascript
const {router: Router, application} = Focus; // cette syntaxe permet d'exposer les variables Router [issue de Focus.router] et application [issue de Focus.application]

const MyConceptRouter = Router.extend({
    log: true,
    beforeRoute(){
        // déposer ici le code que vous souhaitez executer avant d'afficher une page de votre concept
        console.debug('[MyConceptRouter] Before route');
        application.changeRoute('my-concept'); // Par exemple : cet appel ajoute un tag dans le component layout de focus-components (utile ici pour styler les pages d'un KeyConcept d'une manière particulière par exemple)
    },
    routes: {
        // déclarer ici l'ensemble des routes (pages) de votre projet
        'concept': 'concept',
    },
    concept() {
        // Cette méthode est appelé à l'appel de la route dans votre navigateur
        // Elle a pour mission d'executer le code qui va afficher votre page.
        console.log('[MyConceptRouter] Call of route my-concept');
    }
});

// publication du router
export default new MyConceptRouter;

```

## Etape 3 : Affichage d'un log dans la console$

Lancer votre application, ouvrez votre navigateur préféré et accédez à l'URL de la route que vous avez créé. Ici : ```http://location:PORT/#concept

## Etape 4 : Affichage d'un composant simple dans la page

## Etape 5: Afficher les paramètres de la route dans le composant
