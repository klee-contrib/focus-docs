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

### Your page needs consult and edit template

### Your page needs a load service

### Your page needs a save service





## Using the generator

Soon ...