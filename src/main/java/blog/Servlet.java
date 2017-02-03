package blog;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Servlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

      UserService userService = UserServiceFactory.getUserService();

      User user = userService.getCurrentUser();



      if (user != null) {

          resp.setContentType("text/plain");

          resp.getWriter().println("Shit");

      } else {

          resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));

      }

  }
	
}
