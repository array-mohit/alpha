package project;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/admin/logout","/logout"})
public class LogoutAction extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if(session != null) {
			session.removeAttribute("email");
			session.invalidate();
		}
		String requestUrl = req.getRequestURI().toString();
		String contextPath = req.getContextPath();
		
		if(requestUrl.endsWith("/admin/logout")) {
			resp.sendRedirect("../login.jsp");
		}else if(requestUrl.endsWith("/logout")) {
			resp.sendRedirect("login.jsp");
		}
		
	}
}
