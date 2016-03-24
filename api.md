Le but de ce point est le suivant:
- Réduire le nombre d'aller retour entre l'application et l'api
- Améliorer le facilité de construction d'écran



## Le concept de fieldset

Si nous prenons une entité A qui possède les champs `field1`, `field2`, `field3`, `field4`,`field5`, `field6`

```cson
{
  entityA:
    field1
    field2
    field3
    field4
    field5
    field6
}
```

Les fieldsets de cette entité seront un sous ensemble nommé des fields de l'entité A.

Voci une vision 'mathématique' de ce que peut donner un fieldSet.

`buildfieldSet = (fieldSetName, Entity, fieldsToSelect) =>  {Entity.name: {fieldSetName : Entity.fields.filter(fieldsToSelect)}}`

Par exemple si nous reprenons notre entité A:
Si nous lui appliquons un filtre de fieldSet , par exemple `buildfieldSet('summary', entityA, ['field1', 'field4', 'field6'])`, nous obtenons

```cson
{
  entityA:
    summary:
      field1
      field4
      field6
}
```
Une entité peut avoir autant de fieldSet que l'on veut.
Par défaut une entité aura un fieldSet correspondant à tous ses champs

Ce concept de fieldSet va nous permettre de sortir de ce que l'on fait de manière habituelle.

Lorsqu'on charge un fieldSet on charge l'entité associée et on filtre les champs sélectionnés.

## Le découpage d'une page

### Structure de la page

Une page va concerner un concept clef

```md
# Concept
 ## ConceptHeader
 ## ConceptSummary
 ## ConceptBloc1
   ### fieldSet1(Entity1)
   ### fieldSet1(Entity2)
 ## ConceptBloc2
   ### fieldSet2(Entity1)
   ### fieldSet1(Entity3)
 ## ConceptBloc3
   ### fieldSetAll(Entity4)
```
### Chargement des informations de la page

Le chargement peut se penser en deux temps ou deux tâches séparées:
- Chargement des informations principales de la page (cruciales pour l'utilisateur et qui font sens ensemble uniquement)(les deux premiers blocs)
- Chargement des informations secondaires (le troisième bloc)

Au chargement de la page on va donc appeller l'url suivante:

```
/concept/:id/main
  => LoadEntity1FieldSet1
  => LoadEntity2FieldSet1
  => LoadEntity1FieldSet2
  => LoadEntity3FieldSet1
```

  qui peut se traduire par


```
                            => LoadEntity1 => Entity1FieldSet1
                                           => Entity1FieldSet2
                            => LoadEntity2 => Entity2FieldSet1
                            => LoadEntity3 => Entity3FieldSet1
```

On peut ainsi avec se principe charger les informations que l'on souhaite à partir d'une entité simplement sur une route


Ce principe permet également d'adresser la question de la sécurité
On peut ainsi exposer des routes regroupant certaines informations par profile.
Ceci suppose une combinatoire simple des blocs à afficher en fonction des profils
Ceci permettra de mettre en évidence les problèmes de conception liés à la sécurité.
