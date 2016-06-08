# Comment déployer une application Focus/Vertigo sur un serveur Tomcat unique sans configuration externe ?

L'objectif est de déployer une application réalisée en Focus/Vertigo sur un serveur unique Tomcat sans avoir à toucher à la configuration du serveur.
L'idée principale est de différencier les routes définies dans **Focus** et celles définies dans **Vertigo** par des préfixes puis utiliser des filtres HTTP pour intercepter les deux types de requêtes.
Les requêtes Focus étant forwardées sur la page d'index qui contient le fichier JS de l'application.

Pour réaliser cela, un peu de configuration et un nouveau filtre sont nécessaires.

- Côté app, définition des séparations des routes dans le `package.json`
  Modification des deux paramètres `API_ROOT` et `BASE_URL` pour refléter les deux types de routes :

```javascript
{
    ...
    "API_ROOT": "'/vision-app/api/'",
    "BASE_URL": "'/vision-app/app/'"
    ...
}
```

> Ne pas oublier les cotes à l'intérieur des guillemets.

- Côté app, définition de la route Home vers la page d'accueil de l'application située dans le répertoire _`/app/`_. Modification du `home-router.js` :

> Cette configuration permet à l'app de reconnaître la route `/app/index.jsp`

```javascript
const routes = [
   {
        path: 'home',
        component: HomeView
    },
    {
    	path: 'index.jsp',
    	onEnter: ({ params }, replace) => replace(`${__BASE_URL__}home`)
    }
];
```

- Coté Vertigo, création d'un fichier `index.html` qui redirige vers la page d'index `app/index.jsp`
```html
<META HTTP-EQUIV="Refresh" CONTENT="0; URL=app/index.jsp">
```

- Coté Vertigo, Modification du mapping du filtre `VegaSparkFilter` vers _`/api/`_
```xml
<filter-mapping>
    <filter-name>SparkFilter</filter-name>
    <url-pattern>/api/*</url-pattern>
  </filter-mapping>
```

- Côté Vertigo, dans le fichier `web.xml` Ajout d'un nouveau filtre `RouteFilter` prenant en paramètre la page de redirection à partir du context-path : _`/app/index.jsp`_ et le mapper sur les adresses _`/app/`_ définies pour les routes Focus
```xml
<filter>
    <filter-name>RouteFilter</filter-name>
    <filter-class>fr.cavimac.vision.ui.filter.RouteFilter</filter-class>
	<init-param>
		<param-name>redirection-jsp</param-name>
		<param-value>/app/index.jsp</param-value>
	</init-param>
  </filter>
  <filter-mapping>
    <filter-name>RouteFilter</filter-name>
    <url-pattern>/app/*</url-pattern>
  </filter-mapping>
```

- Le code du `RouteFilter` utilise la page de redirection comme base du forward et comme exclusion du filtre pour éviter les redirections infinies :
```java
@Override
public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		if (isUrlMatch(req, excludesPattern)) {
			chain.doFilter(req, res);
		} else {
			req.getRequestDispatcher(redirectionJsp).forward(req,  res);
		}

	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		redirectionJsp = filterConfig.getInitParameter(REDIRECTION_JSP);
		excludesPattern = parsePattern(redirectionJsp);
	}
```

Les méthodes `ParsePattern` et `isUrlMatch` sont identiques à celles du [AbstractFilter](https://github.com/KleeGroup/vertigo-struts2/blob/master/src/main/java/io/vertigo/struts2/impl/servlet/filter/AbstractFilter.java) de **Vertigo-Struts2**.

- Côté Vertigo, modification de l'`index.jsp` en utilisant le context-path pour servir les ressources statiques :
```html
<head>
    <meta charset="UTF-8">
    <title>Vision <%=Home.getApp().getComponentSpace().resolve(ParamManager.class).getStringValue("admin.versioning.versionNumber") %></title>
    <link href="${pageContext.request.contextPath}/static/Vision.css" rel="stylesheet">
</head>
<body>
    <div class="vision-app"/>
    <script type='text/javascript' src='${pageContext.request.contextPath}/static/Vision.js'></script>
</body>
```

> L'utilisation de **`${pageContext.request.contextPath}`** permet de toujours avoir une ressources qui provient de /static/ quelque soit l'URL de la page affichée dans le navigateur.



Et c'est fini !

L'application répond de manière habituelle sur les URL _`/api/`_, elle forwarde les URL _`/app/`_ vers la page principale en gardant l'URL complète ce qui permet de reprendre la page en cours.
