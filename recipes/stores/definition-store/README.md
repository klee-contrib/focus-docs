Définir un store
================

Dans le dossier `app/stores`, rajouter un fichier `facture-store.js`.

```javascript
/* global focus*/
/**
 * Store pour le module administration.
 * @type {focus}
 */
const administrationStore = new Focus.store.CoreStore({
    definition: {
        profilList: 'profilList',
        profilDetail: 'profilDetail'
    }
});
module.exports = administrationStore;
```
