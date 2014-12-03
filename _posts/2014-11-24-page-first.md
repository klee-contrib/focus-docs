---
layout: post
title: first page
date:   2014-11-12 17:59:15
categories: jekyll update
---
In order to write you first page, you have two options: use the page [generator](https://github.com/KleeGroup/focus-generator) or write a page on your own.
This tutorial will follow the rules describe [here](rules)

## Specification

The use case is what follows: **I want to build a directory app**.
![Data Model]({{ site.url }}/{{site.baseurl}}/assets/directory_model.png)

The pages we want are (in realization order)

- **User Detail** page, a simple then a complex one, url will be `http://localhost:3333/#user/:id` where `:id` is the identifier of the user.
- **User Search** page, a page where we can search a user and then find it and consult it, url will be `http://localhost:3333/#user`.
- **Home** page, a simple home page displaying indocators, url will be `http://localhost:3333/#home` 

![Data Model]({{ site.url }}/{{site.baseurl}}/assets/directory_pages.png)

## On your own

 If you have follow the page lifecycle describe.

 ![LifeCycle_10]({{ site.url }}/{{site.baseurl}}/assets/life_cycle_10.PNG)

## The first page we want is the detail of a user 

The process of element creation leading to the display the page will be as follows:

{% highlight html %}
{% raw %}
[url] -> [router] -> [model + view] -> [service] -> [templates]
{% endraw%}
{% endhighlight %}

### Your page needs a route inside a router

In the `app/routers/{yourRouterNameFile}`, you have to write a new route.
{% highlight javascript %}
//Dependencies.
var Router = Fmk.Helpers.Router;
var application = require('../application');
var NotImplementedException = Fmk.Helpers.CustomExceptions.NotImplementedException;
/**
 * Router dealing with the module user.
 * @module  'app/router/user'
 */
module.exports = Router.extend({
  /**
   * Routes du module messgae.
   * @type {Object}
   */
  routes: {
    'user/:userId': 'userDetailRoute'
  },
  /**
   * Route dealing with the contact detail.
   * @return {undefined}
   */
  userDetailRoute: function userDetailRoute(contactId) {
      throw new NotImplementedException("userDetailRoute");
    }));
  }
});
{% endhighlight %}

### Initialize empty directory

If you follows the application coding rules, you have to create two directories in views and models.
Your page should be in an application module. Here we have a module called `user` dealing with all user pages.
{% highlight javascript %}
|app
__views
  __user
__models
  __user
{% endhighlight %}

You now need to create a directory with the name of your page. In our case it is __userDetail__.
Your directory structure should now be:

{% highlight javascript %}
|app
__views
  __user
    __userDetail
__models
  __user
    __userDetail
{% endhighlight %}

### Your page needs a model

The first thing, you will need in order to display your page is to create a model.
You have to create it in the __models/user/userDetail__ directory.
Your model has to Extend a `Focus.Models.Model` model.
{% highlight javascript %}
//Dependency
var Model = Fmk.Models.Model;

/**
 * Model for a message.
 * @type {function}
 */
module.exports = Model.extend({
  /**
   * Metadata property of the model.
   * @type {String}
   */
  modelName: "user.user"
});
{% endhighlight %}

You have to notice that we define the `modelName` property which is used in order to find what metadatas should be used by the model.
See [domains]({{ site.url }}/{{site.baseurl}}/jekyll/2014/11/12/domains.html) section.

### Your page needs a view

Now that you have a model. You can create the view.
You have to create it in the __views/user/userDetail__ directory.
Your model has to Extend one of the  `Focus.Views` views.
In our case we will use the `Focus.Views.ConsultEditView` wich is the view to use when you have a simple __display/edit__ form.
In order to know what kind of view fits with your need you can have a look at: [choose a view]({{ site.url }}/{{site.baseurl}}/jekyll/2014/11/12/what-kind-of-view.html) section. 

### The code

{% highlight javascript %}
//Dependencies.
var ConsultEditView = Fmk.Views.ConsultEditView;
var userSvc = require('../../../services/serviceUser');
/**
 * @module 'views/message/message/messageDetail'
 * @type {ConsultEditView}
 */
module.exports = ConsultEditView.extend({
  /**
   * Options de la vue.
   * @type {Object}
   */
  customOptions:{
    isModelToLoad: true,
    isSaveOnServer: true,
    isNavigationOnSave: false,
    isEditMode: true,
    isEdit: false
    //,DEBUG: true
  },
  referenceNames:['poles', 'locomotions'],
  /**
   * Template de consultation de la vue.
   * @type {function}
   */
  templateConsult: require('./templates/userConsult'),
  /**
   * Template d'edition de la vue.
   * @type {function}
   */
  templateEdit: require('./templates/userEdit'),
  /**
   * Service to call in order to load the data from a service.
   * @type {function}
   */
  getModelSvc: userSvc.loadUserById,
  /**
   * Service which is called in order to save the message.
   * @type {function}
   */
  saveModelSvc: userSvc.saveUser
});
{% endhighlight %}

In the next parts, i will try to explain each part of the view in order to explain all elements.

### Your page needs consult and edit template

In order to be displayed the view needs two templates which are represented in the properties: `templateConsult` and `templateEdit`.
These templates should be written in handlebars. A more detailed section on the templates is describe in the documentation ([here]({{ site.url }}/{{site.baseurl}}/jekyll/2014/11/12/templates.html)).
The consultation template:

{% highlight html %}
{% raw %}
{{#page "user.detail.title"}}
  {{#display}}
    {{display_for "firstName"}}
    {{display_for "lastName"}}
    {{display_for "email"}}
    {{display_for "phone"}}
    {{display_for "poleCode" listKey='poles'}}
    {{display_for "locomotionCode" listKey='locomotions'}}
    {{button_edit}}
  {{/display}}
{{/page}}
{% endraw %}
{% endhighlight %}
The consultation template:

{% highlight html %}
{% raw %}
{{#page "user.detail.title"}}
 { {#form}}
    {{input_for "firstName"}}
    {{input_for "lastName"}}
    {{input_for "email"}}
    {{input_for "phone"}}
    {{options_selected "poleCode" listKey='poles'}}
    {{options_selected "locomotionCode" listKey='locomotions'}}
    {{!-- Action button of the page--}}
    {{button_cancel}}
    {{button_save}}
  {{/form}}
{{/page}}
{% endraw %}
{% endhighlight %}

### Your page needs a load service

In order to load the data which will be displayed in the page, we have to call the service layer of the application.

As describe in the [service]({{ site.url }}/{{site.baseurl}}/jekyll/2014/11/12/service.html) section of the documentation, the service does not know about the view or the model. It only takes `JSON` object as entry and always return a [Promise]({{ site.url }}/{{site.baseurl}}/jekyll/2014/11/12/promise.html) exposing `JSON` as exit.

The service method we will call needs to perform an `AJAX` request on a `WebApi` exposing a `REST` webservice.

{% highlight javascript %}
function _getPromiseUser(json) {
  return promisify.model(URL_USER_DETAIL, json);
}

/**
 * Load a user by its identifier.
 * @param  {string} userId - The user identifier.
 * @return {Promise} - The loading promise of the message.
 */
function loadUserById(userId) {
  if (!_.isString(userId)) {
    throw new ArgumentInvalidException('userId should be a string', userId);
  }
  return _getPromiseUser({
    id: userId
  }).fetch();
}
{% endhighlight %}

There is a helper in focus which is named `Focus.Helpers.promisifyHelper` which is used in order to create wrapper objects around ajax request. These objects takes a collection or a model and a URL in order to be initialized. Then they exposes methods in order to call the webServices from the server.

| type       | method | purpose                            |
|------------|--------|------------------------------------|
| model      | fetch  | load the data with a GET           |
|            | save   | save the data with a POST or a PUT |
|            | delete | delete the data with a DELETE      |
| collection | fetch  | get the data with a POST or a GET  |
|            | save   | save the data with a POST          |
|            | delete | delete the data with a DELETE      |


### Your page needs a save service

{% highlight javascript %}
/**
 * Save a json user.
 * @param  {object} jsonUser The json user.
 * @return {Promise}  The save promise.
 */
function saveUser(jsonUser) {
  if (!_.isObject(jsonUser)) {
    throw new ArgumentInvalidException('jsonUser should be an object', jsonUser);
  }
  return _getPromiseUser(jsonUser).save();
}
{% endhighlight %}


## Using the generator

Soon ...