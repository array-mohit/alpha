package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/incDecAction")
public class IncDecServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String email = session.getAttribute("email").toString();
		int id = Integer.parseInt(req.getParameter("id"));
		String incdec = req.getParameter("quan");
		
		int price = 0;
		int total = 0;
		int quantity = 0;
		int finalTotal = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null,pstmt2 = null;
		ResultSet rs = null;
		
		try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("select * from cart where email = ? and product_id =? and status is Null");
			pstmt.setString(1, email);
			pstmt.setInt(2, id);
			rs = pstmt.executeQuery();
					while(rs.next()) {
						price= rs.getInt("price");
						total=rs.getInt("total");
						quantity = rs.getInt("quantity");
						
					}
					if(quantity<=1 && incdec.equals("dec")) {
						resp.sendRedirect("cart.jsp?msg=notpossible");
					}else if(quantity >= 1 && incdec.equals("dec")){
						total = total - price;
						quantity = quantity -1;
						pstmt2 = conn.prepareStatement("update cart set total=?,quantity=? where email =? and product_id = ? and status is null");
						pstmt2.setInt(1, total);
						pstmt2.setInt(2, quantity);
						pstmt2.setString(3, email);
						pstmt2.setInt(4, id);
						pstmt2.executeUpdate();
						resp.sendRedirect("cart.jsp?msg=dec");
					}else if(quantity >= 1 && incdec.equals("inc")) {
						total = total + price;
						quantity = quantity +1;
						pstmt2 = conn.prepareStatement("update cart set total=?,quantity=? where email =? and product_id = ? and status is null");
						pstmt2.setInt(1, total);
						pstmt2.setInt(2, quantity);
						pstmt2.setString(3, email);
						pstmt2.setInt(4, id);
						pstmt2.executeUpdate();
						resp.sendRedirect("cart.jsp?msg=inc");
					}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			resp.sendRedirect("cart.jsp?msg=error");
		}finally {
			DatabaseUtils.closeResultSet(rs);
			DatabaseUtils.closePreparedStatement(pstmt2);
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
		}
	}
}
