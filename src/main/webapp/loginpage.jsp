<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<html>
	<head>
		<title>ChriSquared</title>
		<link type="text/css"; rel="stylesheet"; href="loginpage.css">
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
		    UserService userService = UserServiceFactory.getUserService();
		    User user = userService.getCurrentUser();
		    if (user != null) {
		        pageContext.setAttribute("user", user);
		%>
		
		<p>/n/n/n/n/nYou are already signed in, ${fn:escapeXml(user.nickname)}! (You can
		    <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
		<%
		    } else {
		%>
		<p>/n/n/n/n/nHello!
		    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
		    to include your name in your post.</p>
		<%
		    }
		%>
		
		
		
		
		
		
	</body>
</html>