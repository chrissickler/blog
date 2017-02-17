package blog;

import java.io.IOException;
import java.util.*;
import java.util.logging.Logger;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;



import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;

public class CronServlet extends HttpServlet{
	private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			_logger.info("Cron Job has been executed");
			//Put your logic here
			//BEGIN
			DatastoreService emailList = SubscribeServlet.emailList;
			DatastoreService datastore = Servlet.datastore;
			String from = "christopher.sickler@utexas.edu";
			String to;
			Query query = new Query();
			List<Entity> emails = emailList.prepare(query).asList(FetchOptions.Builder.withLimit(100000));
			for(Entity e : emails){
				to = (String) e.getProperty("email");
				// set credentials
				Sendgrid mail = new Sendgrid("christobear","Password1!");
				String text = "";
		         List<Entity> posts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(100));
		         Date date = new Date();
		         for(Entity post: posts){
		        	 
		        	 if(date.getTime() - ((Date) post.getProperty("date")).getTime() < 86400000){
		        		 text+= "At " + post.getProperty("date") + ", " + post.getProperty("user") + "posted: \n\t" + post.getProperty("title") + "\n\t\t" + post.getProperty("postContent") + "\n\n"; 
		        	 }
		         }
				// set email data
				mail.setTo(to).setFrom(from).setSubject("Blog posts from the past 24 hours").setText(text).setHtml("<strong>ChriSquared!</strong>");

				// send your message
				if(text != ""){
					mail.send();
				}
			}
			//END
		}
		catch (Exception ex) {
			//Log any exceptions in your Cron Job
		}
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
		}
}