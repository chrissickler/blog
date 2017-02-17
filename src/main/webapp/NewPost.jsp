<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 

<html>

  <head>
    <title>New Post</title>
	<link type="text/css" rel="stylesheet" href="/stylesheets/NewPost.css" />
	<link href='http://fonts.googleapis.com/css?family=Raleway:400,300,200,100' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
	<link rel="shortcut icon" href="http://www.example.com/myicon.ico"/> 
  </head>

  <body>
 	<div id="navbar">
		<a href="http://www.google.com"><div class="navbarbuttons"; id="home">HOME</div></a>
		<a href="http://www.google.com"><div class="navbarbuttons">GALLERY</div></a>
		<a href="http://www.google.com"><div class="navbarbuttons">CATEGORIES</div></a>
		<a href="http://www.google.com"><div class="navbarbuttons">ABOUT US</div></a>
		<a href="NewPost.html"><div id="newpost">NEW POST</div></a>
		<a href="loginpage.jsp"><div id="login">LOG IN</div></a>
		<div id="signinbox"></div>
		<a href="http://www.google.com"><div id="searchlogo"><img src="http://www.clker.com/cliparts/9/g/p/H/1/F/search-icon-dark-grey-md.png" /></div></a>
		<a href="http://www.google.com"><div id="searchword">Search</div></a>
		<div id="searchbox"></div>
	</div>
	
	<div id="navbar2">
			<a href="http://www.google.com"><div id="chrislogo"><img src="https://i.imgur.com/TzSql7x.png" /></div></a>
	</div>
	<div id="wallpaper"></div>
	<div id="wallpaper2"></div>

<%

    String userName = request.getParameter("userName");

    if (userName == null) {

        userName = "default";

    }

    pageContext.setAttribute("userName", userName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<div id="greeting"><p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p></div>

<%

    } else {

%>

<div id="greeting"><p>Hello!

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

to include your name with greetings you post.</p> </div>

<%

    }

%>

 

<%

    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    Key guestbookKey = KeyFactory.createKey("Guestbook", userName);

    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.

    Query query = new Query("Greeting", guestbookKey); //.addSort("date", Query.SortDirection.DESCENDING);

    List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));

    if (greetings.isEmpty()) {

        %>

        <div id="nomessages"><p>Guestbook '${fn:escapeXml(userName)}' has no messages.</p></div>

        <%

    } else {

        %>

        <p>Messages in Guestbook '${fn:escapeXml(userName)}'.</p>

        <%

        for (Entity greeting : greetings) {

            pageContext.setAttribute("greeting_content",

                                     greeting.getProperty("content"));

            if (greeting.getProperty("user") == null) {

                %>

                <p>An anonymous person wrote:</p>

                <%

            } else {

                pageContext.setAttribute("greeting_user",

                                         greeting.getProperty("user"));

                %>

                <p><b>${fn:escapeXml(greeting_user.nickname)}</b> wrote:</p>

                <%

            }

            %>

            <blockquote>${fn:escapeXml(greeting_content)}</blockquote>

            <%

        }

    }

%>

 

    <form action="/sign" method="post">

      <div id="newposttext"><textarea name="content" rows="3" cols="60"></textarea></div>

      <div id="postbutton"><input type="submit" value="Post Greeting" /></div>

      <input type="hidden" name="userName" value="${fn:escapeXml(userName)}"/>

    </form>

 

  </body>

</html>

