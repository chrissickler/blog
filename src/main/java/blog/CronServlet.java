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
				 // Assuming you are sending email from localhost
			      String host = "localhost";

			      // Get system properties
			      Properties properties = System.getProperties();

			      // Setup mail server
			      properties.setProperty("mail.smtp.host", host);

			      // Get the default Session object.
			      Session session = Session.getDefaultInstance(properties);

			      try {
			         // Create a default MimeMessage object.
			         MimeMessage message = new MimeMessage(session);

			         // Set From: header field of the header.
			         message.setFrom(new InternetAddress(from));

			         // Set To: header field of the header.
			         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

			         // Set Subject: header field
			         message.setSubject("Blog entries from the last 24 hours");

			         String text = "";
			         List<Entity> posts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(100));
			         Date date = new Date();
			         for(Entity post: posts){
			        	 
			        	 if(date.getTime() - ((Date) post.getProperty("date")).getTime() < 86400000){
			        		 text+= "At " + post.getProperty("date") + ", " + post.getProperty("user") + "posted: \n\t" + post.getProperty("title") + "\n\t\t" + post.getProperty("postContent") + "\n\n"; 
			        	 }
			         }
			         
			         // Now set the actual message
			         message.setText(text);

			         // Send message
			         Transport.send(message);
			         System.out.println("Sent message successfully....");
			      }catch (MessagingException mex) {
			         mex.printStackTrace();
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