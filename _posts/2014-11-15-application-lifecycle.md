---
layout: post
title: Application lifecycle
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

5.The view call the service to load the data

* The **view** call the **getModelSvc** to load the data
![LifeCycle_5]({{ site.url }}/assets/life_cycle_5.PNG)

6.The service returns JSON to load in the view

* The **view** gets the json back
![LifeCycle_6]({{ site.url }}/assets/life_cycle_6.PNG)

7.The data is injected into the model as attributes

* The **view** called `model.set(jsonData)`
![LifeCycle_7]({{ site.url }}/assets/life_cycle_7.PNG)

8.The model trigger a **:change** event

* The **model** is rendered into an application layout
![LifeCycle_8]({{ site.url }}/assets/life_cycle_8.PNG)

9.The view handles the event and call the template to be rendered

* The view calls the `render` data
* The `render` call an handlebars **template**
![LifeCycle_9]({{ site.url }}/assets/life_cycle_9.PNG)

10.The view DOM element is updated and visible in the layout

* The view update its `el` property
* The page is already refreshed with the updated data
![LifeCycle_10]({{ site.url }}/assets/life_cycle_10.PNG)

