package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/editUserPasswordServlet")
public class EditUserPasswordServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String oldPass = req.getParameter("oldPassword");
		String newPass = req.getParameter("newPassword");
		String confirmPass = req.getParameter("confirmPassword");
		String email = req.getParameter("email");
		String password = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null,pstmt1=null;
		ResultSet rs = null;
		try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("Select password from users where email = ?");
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				password = rs.getString("password");
			}
			if(newPass.equals(confirmPass)) {
				if(oldPass.equals(password)) {
					try {
						
						pstmt1 = conn.prepareStatement("Update users set password=? where email=?");
						pstmt1.setString(1, newPass);
						pstmt1.setString(2, email);
						pstmt1.executeUpdate();
						resp.sendRedirect("changepassword.jsp?msg=success");
					} catch (Exception e) {
						e.printStackTrace();
					}finally {
						DatabaseUtils.closePreparedStatement(pstmt1);
					}
				}else {
					resp.sendRedirect("changepassword.jsp?msg=error");
				}
			}else {
				resp.sendRedirect("changepassword.jsp?msg=cancel");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
				DatabaseUtils.closeResultSet(rs);
				DatabaseUtils.closePreparedStatement(pstmt1);
				DatabaseUtils.closePreparedStatement(pstmt);
				DatabaseUtils.closeConnection(conn);
		}
	}
}
