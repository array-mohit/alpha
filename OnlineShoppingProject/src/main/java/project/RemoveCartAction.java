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
import javax.servlet.http.HttpSession;

@WebServlet("/removeCartAction")
public class RemoveCartAction extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String email= session.getAttribute("email").toString();
		int cid = Integer.parseInt(req.getParameter("productId"));
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("Delete From cart where product_id = ? and email=? and status is null");
			pstmt.setInt(1, cid);
			pstmt.setString(2, email);
			pstmt.executeUpdate();
			resp.sendRedirect("cart.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
		}
	}
}
