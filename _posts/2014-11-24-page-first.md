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
![Data Model]({{ site.url }}/assets/directory_model.png)

The pages we want are (in realization order)

- **User Detail** page, a simple then a complex one, url will be `http://localhost:3333/#user/:id` where `:id` is the identifier of the user.
- **User Search** page, a page where we can search a user and then find it and consult it, url will be `http://localhost:3333/#user`.
- **Home** page, a simple home page displaying indocators, url will be `http://localhost:3333/#home` 

![Data Model]({{ site.url }}/assets/directory_pages.png)

## On your own

 If you have follow the page lifecycle describe.

 ![LifeCycle_10]({{ site.url }}/assets/life_cycle_10.PNG)

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

### Your page needs a model

### Your page needs a view

### Your page needs consult and edit template

### Your page needs a load service

### Your page needs a save service





## Using the generator

Soon ...