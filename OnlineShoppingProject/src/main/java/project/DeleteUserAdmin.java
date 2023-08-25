package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/deleteUserAdmin")
public class DeleteUserAdmin extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = req.getParameter("email");
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("Delete from users where email = ?");
			pstmt.setString(1, email);;
			pstmt.executeUpdate();
			resp.sendRedirect("adminhome.jsp?msg=deleted");
		} catch (Exception e) {
			resp.sendRedirect("adminhome.jsp?msg=error");
			e.printStackTrace();
		}
	}
}
