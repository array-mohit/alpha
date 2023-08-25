package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/signupaction")
public class SignupAction extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String mno = request.getParameter("mno");
		String securityquestion = request.getParameter("securityquestion");
		String answer = request.getParameter("answer");
		String pwd = request.getParameter("password");
		String cpwd = request.getParameter("cpassword");
		String address="";
		String city="";
		String state= "";
		String country=""; 
		Connection connection = null;
		PreparedStatement preparedStatement= null;
		if(pwd.equals(cpwd)){
			try{
				  connection=ConnectionProvider.getCon();
				  preparedStatement=connection.prepareStatement("Insert into users(name,email,mobilenumber,securityQuestion,answer,password) values(?,?,?,?,?,?)");
				  preparedStatement.setString(1, name);
				  preparedStatement.setString(2, email);
				  preparedStatement.setString(3, mno);
				  preparedStatement.setString(4, securityquestion);
				  preparedStatement.setString(5, answer);
				  preparedStatement.setString(6, pwd);
				 
				  preparedStatement.executeUpdate();
				  response.sendRedirect("login.jsp?msg=valid");
				  
			}catch(Exception e){
				System.out.print(e);
				response.sendRedirect("signup.jsp?msg=invalid");
			}finally {
				DatabaseUtils.closePreparedStatement(preparedStatement);
				DatabaseUtils.closeConnection(connection);
			}
		}
		else{
			response.sendRedirect("signup.jsp?msg=invalid");
		}
	}
}
