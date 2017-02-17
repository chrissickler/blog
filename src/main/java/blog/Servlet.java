package blog;

import com.google.appengine.api.datastore.DatastoreService;

import com.google.appengine.api.datastore.DatastoreServiceFactory;

import com.google.appengine.api.datastore.Entity;

import com.google.appengine.api.datastore.Key;

import com.google.appengine.api.datastore.KeyFactory;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;

import java.util.Date;

 

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


public class Servlet extends HttpServlet{
	
	public static DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
     // We have one entity group per Guestbook with all Greetings residing
     // in the same entity group as the Guestbook to which they belong.
     // This lets us run a transactional ancestor query to retrieve all
     // Greetings for a given Guestbook.  However, the write rate to each
     // Guestbook should be limited to ~1/second.

		String userName = req.getParameter("userName");
		Key guestbookKey = KeyFactory.createKey("Guestbook", userName);
		String[] content = req.getParameterValues("content");
		String title = content[0];
		String postContent = content[1];
		Date date = new Date();
		Entity greeting = new Entity("Greeting", guestbookKey);
		greeting.setProperty("user", user);
		greeting.setProperty("date", date);
		greeting.setProperty("title", title);
		greeting.setProperty("postContent", postContent);
		datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(greeting);
		resp.sendRedirect("/blog.jsp?userName=" + userName);
	}

}





// copied from ofysignguestbookservlet

//Greeting greet = new Greeting(user, content);

//ofy().save().entity(greet).now();





