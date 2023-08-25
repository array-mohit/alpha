package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/continueShoppingServlet")
public class ContinueShoppingServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		String status = "Processing";
		String email = session.getAttribute("email").toString();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("update cart set status = ? where email = ? and status ='bill'");
			pstmt.setString(1, status);
			pstmt.setString(2, email);
			pstmt.executeUpdate();
			resp.sendRedirect("homepage.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
		}
	}
}
