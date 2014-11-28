---
layout: post
title: Exceptions
date:   2014-11-12 17:59:15
categories: jekyll update
---

All exeptions are available in th object : `Fmk.Helpers.Exceptions` or `Focus.Helpers.Exceptions`
See [file]()

| Exception                | Purpose                                                                      |
|--------------------------|------------------------------------------------------------------------------|
| ArgumentNullException    | To use when a propery is null and shouldn't be                               |
| ArgumentInvalidException | To use when a propery is not null but has the wrong value or the wrong type. |
| NotImplementedException  | To use when a function is not implemented                                    |
| DependencyException      | To use when a dependency is missing                                          |

They all have a similar signature. `Exception(message, context)`

{% highlight javascript %}
var ArgumentInvalidException =  Fmk.Helpers.Exceptions.ArgumentInvalidException;
function saveObject(jsonObject){
  if(!_.isObject(jsonObject)){
     throw new ArgumentInvalidException(
                 "jsonObject should be an object",
                 jsonObject
               );
  }
}
{% endhighlight %}

Really often these Exceptions should be use after testing properties with [underscore](http://underscorejs.org/#isEmpty).
All types has  a function associated:

- [isObject](http://underscorejs.org/#isObject)
- [isNumber](http://underscorejs.org/#isNumber)
- [isString](http://underscorejs.org/#isString)
- ...

Candidates for all these type checking are the services. Each parameter of a service should be tested.

