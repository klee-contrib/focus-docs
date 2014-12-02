---
layout: post
title: Installation
date:   2014-11-12 17:59:15
categories: jekyll update
---

## Browser

- Install [Google Chrome](https://www.google.com/intl/fr/chrome/browser/) 
- Configure your chrome dev tools  press `F12`
![DevTools]({{ site.url }}/{{site.baseurl}}/assets/dev-tools.png)
- [Postman](https://chrome.google.com/webstore/detail/postman-rest-client/fdmmgilgnpjigdojojpjoooidkmcomcm) extension.


## Node JS

- Install [Git Bash](http://git-scm.com/downloads)
- Install [node js](http://nodejs.org/)
- Ask your **technical leader** for configuration files in order to deal with a proxy
- Open your command prompt and run the following command
- Install [brunch](http://brunch.io/) `npm install -g brunch `
- Install [bower](http://bower.io/)  `npm install -g bower `
- Install [mocha](http://visionmedia.github.io/mocha/) `npm install -g mocha `

- (Optional) Install [Python](http://www.python.org/download/releases/2.7.6/) and add it into the PATH.


## Editor

The new strategy is now to rather install webstorm than sublime text.

### Sublime Text 2

- Install [Sublime Text](http://www.sublimetext.com/2), and install [Package Control](https://sublime.wbond.net/installation#st2), and then the following list of plugins:
 _AdvancedNewFile_,_Alignment_,_Coffee Formatter_,_CoffeeScript_,_Emmet_,_Git_,_Handlebars_,_HTML Snippets_,_Http Requester_,_Jade_,_JsFormat_,_LoremIpsum_,_Package Control_,_Stylus_,_SublimeLinter_,_Tomorrow Color Schemes_,_DocBlockr_, _MarkdownPreview_<br />
In order to install a plugin, you have to do `ctrl+shift+p` then type `install package` and then the name of the package.
- Install [ternjs](https://github.com/marijnh/tern_for_sublime) plugin for sublime **WARNING this plugin is not available through the package manager.**
- Ternjs [documentation](http://ternjs.net/)

### Web Storm

- Install [WebStorm](https://www.jetbrains.com/webstorm/download/) which is more an IDE than a text editor

## Application configuration

- Get your application from the source control
- Go into the **SPA** project's directory
- Install node dependencies `npm install --no-optional`
- Install bower dependencies `bower install --no-optional`
- Build the project with `brunch b` or `brunch w`.
- Launch the server and build `brunch w --server`
![Brunch]({{ site.url }}/{{site.baseurl}}/assets/brunch.png)
- Open the `public/` dir to see the result.
- Write your code in `app/`.

