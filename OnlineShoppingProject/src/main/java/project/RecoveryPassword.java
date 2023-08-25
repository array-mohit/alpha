package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/recovery")
public class RecoveryPassword extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
		String email = request.getParameter("email");
		String securityquestion = request.getParameter("securityquestion");
		String answer = request.getParameter("answer");
		String pwd = request.getParameter("newpassword");
		String cpwd = request.getParameter("cpassword");
		
		Connection conn = null;
		PreparedStatement pstmt = null,pstmt2 = null;
		ResultSet rs = null;
		try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("SELECT * FROM users WHERE email = ? AND securityquestion = ? AND answer = ?");
            pstmt.setString(1, email);
            pstmt.setString(2, securityquestion);
            pstmt.setString(3, answer);
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	if (pwd.equals(cpwd)) {
            		pstmt2 = conn.prepareStatement("UPDATE users SET password = ? WHERE email = ?");
            		pstmt2.setString(1, pwd);
            		pstmt2.setString(2, email);
            		pstmt2.executeUpdate();
            		resp.sendRedirect("recovery.jsp?msg=done");
            	} else {
            		resp.sendRedirect("recovery.jsp?msg=mismatch");
            	}
            } else {
            	resp.sendRedirect("recovery.jsp?msg=invalid");
            }
		}catch(Exception e) {
			System.out.println(e);
			resp.sendRedirect("recovery.jsp?msg=invalid");
		}
		finally {
			DatabaseUtils.closeResultSet(rs);
			DatabaseUtils.closePreparedStatement(pstmt2);
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
		}
	}
}
