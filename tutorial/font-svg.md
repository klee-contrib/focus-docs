# Comment intégrer des icônes SVG dans l'application ?

Dans les applications que nous concevons, nous utilisons au maximum l'iconographie grand public, faisant partie complète de nos usages quoditiens :
* [Material design icons](https://design.google.com/icons/)
* [Fontawesome](http://fontawesome.io/icons/)

Parfois, le métier impose que nous crééions des icônes spécifiques car aucune icône fournie par ces librairies ne sont assez parlantes. Ou bien, le client nous fourni des icônes déjà utilisées car répandues dans le langage commun de l'entreprise et de ses applications.

Dans tous les cas, lors de sa prestation, nous demandons au graphiste de nous fournir l'ensemble des icônes spécifiques au format SVG.

Du coup, comment fait-on pour les intégrer à notre projet en développement ? C'est ce que ce tutoriel s'attache à décrire.

# Icomoon

Icomoon est un application web qui permet de générer des font Web à partir de fichiers svg. L'application est disponible ici : https://icomoon.io/app/#/select

## Transformation des svg en font

Cliquer sur `import icons` dans le bandeau du haut. Vos svg s'ajouteront sur l'application web dans un nouveau sous-dossier que vous pouvez renommer.
Sélectionner ensuite les SVG. Vous pouvez pour cela cliquer sur le bouton de menu de voter sous-dossier, puis `select all`.
Cliquer sur `Generate Font` tout en bas de l'écran.

Sur la nouvelle page, vous pouvez personnaliser vos icônes, puis cliquer sur `download` en bas de l'écran.

## Importer les fonts dans mon projet

Après avoir ajouté le contenu du dossier `fonts` dans votre dossier de font de votre projet, il faut ajouter le fichier `style.css` à ses feuilles de style.
Il ne reste plus qu'à importer ce fichier pour que les icônes soient accessibles.

## Comment utiliser ces font ?

### Ajout d'une classe

Une première méthode est d'ajouter la classe correspondante aux noms des classes du fichier `style.css` là où on veut qu'un icône apparaît et `style.css` fera le reste.

Exemple :

```css
    <span class=“icon-Home” />
```

### Les boutons focus

Pour les utiliser sur les boutons focus, il faut ajouter dans les props du bouton :

```javascript
    icon: 'Litige'
    iconLibrary: 'font-custom'
```

### Autres méthodes

Il existe peut-être une autre méthode en utilisant directement les codes des icônes: “\e901”. Si vous utilisez cette méthode, ou même une autre, n'hésitez pas à compléter cette partie.

## Prévenir un problème de build

L'ajout ou la modification de font peut poser problème pour les builds: il faut dans ce cas suivre les étapes supplémentaires suivantes: Export des fonts.
