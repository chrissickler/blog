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
		<link type="text/css"; rel="stylesheet"; href="/stylesheets/loadingpage.css">
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
			<a href="Subscribe.jsp"><div id="subscribe">SUBSCRIBE</div></a>	
			<a href="Unsubscribe.jsp"><div id="unsubscribe">UNSUBSCRIBE</div></a>		
			<div id="signinbox"></div>
			
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
		
		<%
			String title = request.getParameter("title");
		
			if (title == null) {
				
				title = "default";
				
			}
			
			pageContext.setAttribute("title", title);
				
			UserService userService = UserServiceFactory.getUserService();
			
			User user = userService.getCurrentUser();
			
			if (user != null) {
			
		    	pageContext.setAttribute("title", title);
			
		    	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			
		    	Key guestbookKey = KeyFactory.createKey("Guestbook", title);
			
		    	// Run an ancestor query to ensure we see the most up-to-date
			
		    	// view of the Greetings belonging to the selected Guestbook.
			
		    	Query query = new Query("Greeting", guestbookKey); //.addSort("date", Query.SortDirection.DESCENDING);
			
		    	List<Entity> titles = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));
				
		    	if (titles.isEmpty()) {

		    	    %>
		
		    	    <p>Empty right now</p>
		
		    	    <%

		    	} else {
		
			        for (Entity greeting : titles) {
		
			            pageContext.setAttribute("title_content",
		
			                                     greeting.getProperty("title"));
		
		
			            %>
		
			            <div class="titles">
			            	<blockquote>${fn:escapeXml(title_content)}</blockquote>
			            </div>
		
			            <%
		
			        }
		
			    }
			}	    
			%>
			
			<%
			
		    String userName = request.getParameter("userName");
		
		    if (userName == null) {
		
		        userName = "default";
		
		    }
		
		    pageContext.setAttribute("userName", userName);
		
		   
		    if (user != null) {
		
		    	pageContext.setAttribute("user", user);
		
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
		
			                                     greeting.getProperty("title"));
		
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
			}	    
			%>
	
		
		
		
		<form action= "/blog.jsp" method= "get">
			
		</form>
		
	</body>
<html>