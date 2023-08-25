package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/paymentAddressAction")
public class PaymentAddressAction extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 HttpSession session = req.getSession();
		 String email = session.getAttribute("email").toString();
		 
		 String name = req.getParameter("Name");
		 String address = req.getParameter("address");
		 Long mobileNo = Long.parseLong(req.getParameter("phoneNumber"));
		 String city = req.getParameter("city");
		 String state = req.getParameter("state");
		 int pincode = Integer.parseInt(req.getParameter("pinCode"));
		 String country = req.getParameter("country");
		 
		 Connection conn = null;
		 PreparedStatement pstmt = null,pstmt2 = null;
		 try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("update users set name=?,address=?,city=?,state=?,country=?,mobilenumber=?,pincode=? where email=? and address is null");
			pstmt.setString(1, name);
			pstmt.setString(2, address);
			pstmt.setString(3, city);
			pstmt.setString(4, state);
			pstmt.setString(5, country);
			pstmt.setLong(6, mobileNo);
			pstmt.setInt(7, pincode);
			pstmt.setString(8, email);
			pstmt.executeUpdate();
			
			pstmt2 = conn.prepareStatement("update cart set name=?,address=?,city=?,state=?,country=?,mobileNumber=?,cpincode=? where email=? and status is null");
			pstmt2.setString(1, name);
			pstmt2.setString(2, address);
			pstmt2.setString(3, city);
			pstmt2.setString(4, state);
			pstmt2.setString(5, country);
			pstmt2.setLong(6, mobileNo);
			pstmt2.setInt(7, pincode);
			pstmt2.setString(8, email);
			pstmt2.executeUpdate();
			
			resp.sendRedirect("paymentcard.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			
			DatabaseUtils.closePreparedStatement(pstmt2);
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
		}
		 
		 
				 
		 
	}
}
