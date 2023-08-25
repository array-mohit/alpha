package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addToCart")
public class CartServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String email = session.getAttribute("email").toString();
		int id = Integer.parseInt(req.getParameter("pid"));

		int quantity = 1;
		int product_price = 0;
		int product_total = 0;
		int cart_total = 0;
		String img = null;

		int z = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null,pstmt2 = null,pstmt3 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;

		try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("select * from product where pid = ?");
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				product_price = rs.getInt("pprice");
				img = rs.getString("pimg");
				product_total = product_price;
			}
			pstmt1 = conn.prepareStatement("select * from cart where product_id=? and email=? and status is null");
			
			pstmt1.setInt(1, id);
			pstmt1.setString(2, email);
			rs2 = pstmt1.executeQuery();
			while (rs2.next()) {
				cart_total = rs2.getInt("total");
				cart_total = cart_total + product_total;
				quantity = rs2.getInt("quantity");
				quantity = quantity + 1;
				z = 1;
			}
			if(z==1) {
				pstmt3 = conn.prepareStatement("update cart set total=?, quantity=? where product_id=? and email=? and status is null");
				pstmt3.setInt(1, cart_total);
				pstmt3.setInt(2, quantity);
				pstmt3.setInt(3, id);
				pstmt3.setString(4, email);
				pstmt3.executeUpdate();
				resp.sendRedirect("cart.jsp?msg=added");
			}
			if(z==0) {
				pstmt2 = conn.prepareStatement("insert into cart (email,product_id,quantity,price,total) values(?,?,?,?,?)");
				pstmt2.setString(1, email);
				pstmt2.setInt(2, id);
				pstmt2.setInt(3, quantity);
				pstmt2.setInt(4, product_price);
				pstmt2.setInt(5, product_total);
				pstmt2.executeUpdate();
				resp.sendRedirect("cart.jsp?msg=added");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DatabaseUtils.closeResultSet(rs2);
			DatabaseUtils.closeResultSet(rs);
			DatabaseUtils.closePreparedStatement(pstmt3);
			DatabaseUtils.closePreparedStatement(pstmt2);
			DatabaseUtils.closePreparedStatement(pstmt1);
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
		}
	}
}
