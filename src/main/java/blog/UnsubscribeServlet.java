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

public class UnsubscribeServlet extends HttpServlet{
	
	
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		DatastoreService emailList = SubscribeServlet.emailList;
		String content = req.getParameter("content");
		Key emailKey = KeyFactory.createKey("Email", content);
		Entity email = new Entity("Email",emailKey);
		email.setProperty("email", content);
		emailList.delete(emailKey);
		resp.sendRedirect("/blog.jsp");
	}
}
