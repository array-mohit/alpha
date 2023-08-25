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

@WebServlet("/editUserQuestionServlet")
public class EditUserQuestionServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String question = req.getParameter("securityquestion");
		String answer = req.getParameter("answer");
		String confirmPass = req.getParameter("confirmPassword");
		Connection conn = null;
		PreparedStatement pstmt = null,pstmt2=null;
		ResultSet rs = null;
		String password = null;
		try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("Select password from users where email = ?");
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				password = rs.getString("password");
			}
			if(password.equals(confirmPass)) {
				pstmt2 = conn.prepareStatement("update users set securityQuestion = ?,answer=? where email = ?");
				pstmt2.setString(1, question);
				pstmt2.setString(2, answer);
				pstmt2.setString(3, email);
				pstmt2.executeUpdate();
				resp.sendRedirect("changequestion.jsp?msg=success");
			}else {
				resp.sendRedirect("changequestion.jsp?msg=error");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DatabaseUtils.closeResultSet(rs);
			DatabaseUtils.closePreparedStatement(pstmt2);
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
		}
		
	}
}
