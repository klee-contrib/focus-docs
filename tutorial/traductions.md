# Utiliser l'outil d'internationnalisation de Focus
​
Focus utilise i18next (http://i18next.com/) librairie qui permet de gérer l'internationnalisation.
​
Les traductions sont dans le dossier "app/i18n". Certaines d'entre elles sont générées automatiquement par le build du serveur, à partir de ce qui est renseigné dans les
fichiers ksp. Les traductions générées sont dans le dossier "generated". Les traductions non générées sont dans le dossier portant le code langue, par exemple "fr-FR.js".
​
Pour utiliser les traductions, il suffit d'importer la fonction "translate" de focus-core :
```js
import {translate} from 'focus-core/translation';
```
Puis d'appeler cette fonction avec en argument la clef présente dans le fichier de traduction.
​
Par exemple, pour obtenir la valeur associée à la clef "button.yes" déclarée dans le fichier de traduction suivant :
```js
export default {
    button: {
        yes: "Oui"
    }
```
Il faut écrire :
```js
translate("button.yes");
```
​
Pour utiliser par exemple une variable "name" dans les traductions, il faut l'écrire ainsi dans le fichier de traduction :
```js
export default {
    button: {
        yes: "Oui __name__"
    }
```
Et dans le fichier js appellant la traduction, il faut donner en second argument à la fonction "translate" un objet contenant les variables utilisées :
```js
translate("button.yes", {
    name: "Mr. Toto"
});
```
