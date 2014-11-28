---
layout: post
title: first page
date:   2014-11-12 17:59:15
categories: jekyll update
---
In order to write you first page, you have two options: use the page [generator](https://github.com/KleeGroup/focus-generator) or write a page on your own.
This tutorial will follow the rules describe [here](rules)


The use case is what follows: **I want to build a directory app**.

## On your own
 If you have follow the page lifecycle.

### Your page needs a route inside a router

In the `app/routers/{yourRouterNameFile}`, you have to write a new route.
{% highlight javascript %}
//Dependencies.
var Router = Fmk.Helpers.Router;
var application = require('../application');
var NotImplementedException = Fmk.Helpers.CustomExceptions.NotImplementedException;
/**
 * Router dealing with the modul contact.
 * @module  'app/router/contact'
 */
module.exports = Router.extend({
  /**
   * Routes du module messgae.
   * @type {Object}
   */
  routes: {
    'contact/:contactId': 'contactDetail',
  },
  /**
   * Route dealing with the contact detail.
   * @return {undefined}
   */
  contactDetail: function contactDetailRoute(contactId) {
      throw new NotImplementedException("contactDetailRoute");
    }));
  }
});
{% endhighlight %}

## Using the generator

Soon ...