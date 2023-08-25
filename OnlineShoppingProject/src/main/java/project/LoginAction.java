package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/validate")
public class LoginAction extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		HttpSession session = req.getSession();
		if("admin@gmail.com".equals(email)&&"admin".equals(password)) {
			session.setAttribute("email", email);
			resp.sendRedirect("admin/adminhome.jsp");
		}
		else {
			int z=0;
			Connection connection=null;
			Statement stmt = null;
			ResultSet resultSet = null;
			try {
				connection = ConnectionProvider.getCon();
				stmt = connection.createStatement();
				resultSet = stmt.executeQuery("select * from users where email='"+email+"' and password='"+password+"'");
				while(resultSet.next()) {
					z=1;
					session.setAttribute("email", email);
					resp.sendRedirect("homepage.jsp");
				}
				if(z==0)
					resp.sendRedirect("login.jsp?msg=notexist");
			}catch(Exception e){
				System.out.println(e);
				resp.sendRedirect("login.jsp?msg=invalid");
			}finally {
				DatabaseUtils.closeResultSet(resultSet);
				try {
					if (stmt != null) {
						stmt.close();
			        }
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				DatabaseUtils.closeConnection(connection);
			}
		}
	}
}
