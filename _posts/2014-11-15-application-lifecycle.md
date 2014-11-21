---
layout: post
title: Installation
date:   2014-11-12 17:59:15
categories: jekyll update
---

1.The route is parsed and is handled by the good router

* The route is `http://localhost/#contact/1`
* The associated route is `http://localhost/#contact/:id`
* The handler `contactDetailRoute` is matched
![LifeCycle_1]({{ site.url }}/assets/life_cycle_1.PNG)

2.The router creates the the model

* The **model** `contactDetail` is created
* It is instanciated with a `ctcId` value as `new ContactDetail({ctcId: id})`
![LifeCycle_2]({{ site.url }}/assets/life_cycle_2.PNG)

3.The router creates the the view
* The **view** is created and associated with the model
* `new ContactDetailView({model: contactDetail})`
![LifeCycle_3]({{ site.url }}/assets/life_cycle_3.PNG)

4.The view is injected into one of the application layout
* The **view** is rendered into an application layout
![LifeCycle_4]({{ site.url }}/assets/life_cycle_4.PNG)

5.The view is injected into one of the application layout
* The **view** is rendered into an application layout
![LifeCycle_5]({{ site.url }}/assets/life_cycle_5.PNG)
