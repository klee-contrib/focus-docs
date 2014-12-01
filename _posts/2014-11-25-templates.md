---
layout: post
title: Template
date:   2014-11-12 17:59:15
categories: jekyll update
---

## what is a template

What is a template. In order to generate **html** which is the language interpreted by the browser.

In order to stay close to the html we have chosen to use [handlebarsjs](http://handlebarsjs.com).

A template is written in handlebars language which is really close to the html.

Once written in handlebars template, the template is compiled into a  **JavaScript** function. Then you can call it from any piece of js code.

Once you have the template, the process is quite simple:
In order to get plain **html** from a template you have to give it data.

Maybe a little example would help:
The following example is a template which should generate a title. The file template is named **home.hbs** 
{% highlight html %}
 <h1>{{title}}</h1> 
{% endhighlight %}
Then you can call it this way
{% highlight javascript %}
  var homeTemplate = require('home');
  var templateData = {title: 'Welcome to the fantastic app'}; 
  homeTemplate(templateData); 
  // render 
  //<h1>Welcome to the fantastic app</h1> ’’’
{% endhighlight %}

## Focus use
