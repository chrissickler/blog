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
		<a href="NewPost.jsp"><div id="newpost">NEW POST</div></a>
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

to include your name with greetings you post.</p></div>

<%

    }

%>

 


 

 

    <form action="/sign" method="post">

	  <div id="post"><a>Post your stuff here!</a></div>

	  <div id="newposttitle"><textarea name="content" rows="1" cols="60"></textarea></div>
	
	  <div id="newposttext"><textarea name="content" rows="3" cols="60"></textarea></div>

      <div id="postbutton"><input type="submit" value="Post Greeting" /></div>

      <input type="hidden" name="userName" value="${fn:escapeXml(userName)}"/>

    </form>

 

  </body>

</html>

