Page de détail composite
========================

## Présentation

Ce tutoriel explique comment implémenter une page de détail avec ses fonctions de chargement de données, de sauvegarde ainsi que la navigation entre les blocs grâce à la barre à gauche de l'écran.
 
## Implémentation

Les pages de détail sont souvent déclinées en plusieurs blocs.

Un bon exemple d'application serait la page de détail d'un utilisateur de l'application sur laquelle les informations personnelles de l'utilisateur (nom, prénom, date de naissance ...) seraient dans un bloc et ses informations professionnelles (poste occupé, autorisations, mail, téléphone ...) dans un autre bloc.

Pour réaliser cette page, nous devons suivre les étapes de la check list suivante :

Check list :

* Implémenter le service côté serveur
* Implémenter l'URL côté client
* Implémenter le service côté client
* Implémenter l'action
* Implémenter les blocs
* Implémenter le composant de la page
* Implémenter la route vers la page

### Services

Tout d'abord pour assurer l'affichage du contenu des blocs de pages de détail ainsi que les actions d'ajout, modification et suppression des données, nous devons implémenter les services relatifs à la donnée détaillée dans le bloc.

#### Côté serveur

Nous supposerons que nous avons déjà implémenté ces services côté server et que nous disposons d'un webservice permettant d'y avoir accès. L'extrait de code suivant provient du fichier de webservice `WsUser.java`.

```java
@GET("/{id}/usrPersonalInfo")
public UserPersonalInfo getUserPersonalInfoById(@PathParam("id") final long id) {
    return userServices.getUserPersonalInfoById(id);
};
```

Ce service permet récupérer les informations personnelles d'un utilisateur dont nous connaissons l'id en utilisant l'URL `racine/valeur_id/usrPersonalInfo`.

#### Côté client

Une fois le fichier de webservice prêt côté server il ne nous reste plus qu'à le renseigner côté client. Cette démarche se fait en trois étapes:

* Renseigner l'URL du webservice :
<br> 1) Naviguer jusqu'à app/config/server
2) Si un fichier du nom de la donnée n'existe pas, le créer, sinon l'ouvrir.
3) Renseigner l'URL de la façon suivante :

```Javascript
var root = "./api/user/";
var url = Focus.util.url.builder;
module.exports = {
// ...
   getUserPersonalInfoById: url(root + "${id}" + "/usrPersonalInfo", 'GET')
// ...
};
```

* Créer un service en faisant appel à l'URL renseignée :
<br> 1) Naviguer jusqu'à app/services
2) Si un fichier du nom de la donnée n'existe pas, le créer, sinon ouvrir.
3) Créer le service de la façon suivante :

```Javascript
var URL = require('../config/server');
var fetch = Focus.network.fetch;
module.exports = {
// ...
   getUserPersonalInfoById: function getUserPersonalInfoById(usrId){
   	return fetch(URL.user.getUserPersonalInfoById({urlData:{id:usrId}}));
    }
// ...
};
```

### Actions

Le rôle d'une action est essentiellement de faire appel à un service renseigné et de mettre à jour un store.

Il est aussi possible de faire appel à plusieurs services "secondaires" si la tâche du premier service est remplie avec succès.

L'extrait de code suivant du fichier `app/action/user/index.js` illustre la forme la plus courante du code d'une action :

```Javascript
var AppDispatcher = Focus.dispatcher;
var userServices = require('../../services').user;
module.exports = {
// ...
   loadUserPersonalInfoById: function loadUserPersonalInfoById(usrId){
   	userServices.getUserPersonalInfoById().then(
            function (data){
                AppDispatcher.handleServerAction({
                    data: {userPersonalInfo: data},
                    type: "update"
                });
            }
        )
    }
// ...
};
```

Le store mis à jour dans cet exemple est `userPersonalInfo`.

Si ce store n'existe pas, il faut le créer dans le fichier `app/stores/user.js`.

#### Blocs de détail

Maintenant que nous disposons d'actions, nous pouvons commencer à construire nos blocs.

Continuons de travailler sur le bloc relatif aux données personnelles de l'utilisateur. Ce bloc contiendra le nom, prénom, la date et le lieu de naissance.

Dans `app/views` chercher le dossier `user`, si le dossier n'existe pas encore, le créer.

Créer ensuite le fichier `userPersonalInfo.jsx` :

```javascript
var formMixin = FocusComponents.common.form.mixin;
var userAction = require('../../action/user');
var userStore = require('../../stores/user');
var Block = FocusComponents.common.block.component;

module.exports = React.createClass({
    definitionPath: 'usrPersonalInfo',
    displayName: 'usrPersonalInfo',
    mixins: [formMixin],
    stores: [{store: userStore, properties: ["usrPersonalInfo"]}],
    /** @inheritDoc */
    action:{
        load: function loadUserPersonalInfoById(id) {
            userAction.loadUserPersonalInfoById(id);
        },
        save: function saveUsrPersonalInfo(usrPersonalInfo){
        	userAction.saveUserPersonalInfo(usrPersonalInfo);
        }
    },
    renderContent: function render() {
        return (
                <Block title={i18n.t('donnee.resume.title')}>
                            <div>{this.fieldFor('nom')}</div>
                            <div>{this.fieldFor('prenom')}</div>
                            <div>{this.fieldFor('dateNaissance')}</div>
                            <div>{this.fieldFor('lieuNaissance')}</div>
                </Block>
            </div>
        );
    }
});
```
Nous commençons d'abord par importer le mixin des formulaires `formMixin`, le store, le fichier des actions ainsi que le composant focus `Block`.

Le `definition path` doit correspondre au type de données manipulées sur cette page.

Nous spécifions ensuite les éléments du store auxquels nous souhaitons nous abonner, dans cet exemple c'est `usrPersonalInfo`.

Pour brancher les actions de `load` et de `save` pour ce détail de bloc, il suffit de les surcharger comme sur l'exemple. Ainsi les données seront chargées au chargement de la page et le `save` sera automatiquement branché sur le bouton `save` du bloc.

Enfin, dans le `renderContent`, nous créons notre bloc à l'aide du composant focus `Block` que nous avons importé. Nous remplissons le composant par des `div` contenant les valeurs des attributs chargés depuis le store. Dans ce cas nous utilisons un `fieldFor` à l'intérieur des `div`.

#### Page de détail

Une fois que tous nos blocs sont créés, il nous suffit de les rassembler dans un fichier `index.jsx` (souvent placé dans le même dossier `app/views/user`).

Dans notre exemple, le fichier `userPersonalInfo.jsx` a besoin du paramètre `id` pour pouvoir charger les données relatives de l'utilisateur. Ce paramètre est typiquement transmis en tant que `props`.

Voici la méthode `render` du fichier `index.jsx` rassemblant les blocs de cette page de détail.

```Javascript

render: function renderUserView(){
        return(
            <Detail>
                <UserPersonalInfo id={this.props.id}/>
                <UserProfessionalInfo id={this.props.id}/>
            </Detail>
        )
    }

```

Les blocs importés sont rassemblés dans le composant focus `<Detail>` qui permet de créer automatiquement la barre de navigation à gauche.

#### En tête

TODO

#### Router

TODO
