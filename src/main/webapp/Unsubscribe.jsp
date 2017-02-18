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

<html>

  <head>
    <title>New Post</title>
	<link type="text/css" rel="stylesheet" href="/stylesheets/Unsubscribe.css" />
	<link href='http://fonts.googleapis.com/css?family=Raleway:400,300,200,100' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
	<link rel="shortcut icon" href="http://www.example.com/myicon.ico"/> 
  </head>

  <body>
 	<div id="navbar">
		<a href="blog.jsp"><div class="navbarbuttons"; id="home">HOME</div></a>
		<a href="http://www.google.com"><div class="navbarbuttons">GALLERY</div></a>
		<a href="http://www.google.com"><div class="navbarbuttons">CATEGORIES</div></a>
		<a href="http://www.google.com"><div class="navbarbuttons">ABOUT US</div></a>
		<a href="NewPost.jsp"><div id="newpost">NEW POST</div></a>
		<a href="Subscribe.jsp"><div id="subscribe">SUBSCRIBE</div></a>
		<a href="Unsubscribe.jsp"><div id="unsubscribe">UNSUBSCRIBE</div></a>		
		<div id="signinbox"></div>
		
	</div>
	
	<div id="navbar2">
			<a href="http://www.google.com"><div id="chrislogo"><img src="https://i.imgur.com/TzSql7x.png" /></div></a>
	</div>
	<div id="wallpaper"></div>
	<div id="wallpaper2"></div> 

    <form action="/unsubscribe" method="post">
      <div id="emailtext"><textarea name="content" rows="1" cols="60"></textarea></div>
      <div id="button"><input type="submit" value="Unsubscribe" /></div>
    </form>

 

  </body>

</html>