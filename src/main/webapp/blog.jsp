<%@ page import="java.util.Collections" %> 
<%@ page import="com.googlecode.objectify.Objectify" %> 
<%@ page import="com.googlecode.objectify.ObjectifyService" %> 
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
		<title>ChriSquared</title>
		<link type="text/css"; rel="stylesheet"; href="loadingpage.css">
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
		<div id="banner">This is a blog about Chris's... So... Post your stuff about Chris's.</div>
		<div id="floatingtext"><strong>CHRIS OF THE DAY</strong></div>
		<div id="floatingtext2"><strong>LATEST BLOG POSTS</strong></div>		
		<div id="leftpic"; class="twomainpix"><img src="http://www.trbimg.com/img-56d31ec6/turbine/la-bio-chris-megerian/400/400x225" /></div>
		<div id="leftpicback"></div>
		<div id="rightpic"; class="twomainpix"><img src="http://www.hortoncomponents.com/images/stockprogram2.jpg" /></div>
		<div id="rightpicback"></div>
		
		<form action= "/blog.jsp" method= "get">
			
		</form>
		
	</body>
<html>