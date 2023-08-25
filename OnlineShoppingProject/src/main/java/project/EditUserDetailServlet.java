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
import javax.servlet.http.HttpSession;

@WebServlet("/editUserDetailServlet")
public class EditUserDetailServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("EditUserDetailServlet");
		
		String name = req.getParameter("name");
		long mobile = Long.parseLong(req.getParameter("mobile"));
		String address = req.getParameter("address");
		String city = req.getParameter("city");
		String state = req.getParameter("state");
		String country = req.getParameter("country");
		int pincode = Integer.parseInt(req.getParameter("pincode"));
		int id =0;
		Connection conn = null;
		PreparedStatement pstmt = null,pstmt2=null;
		ResultSet rs = null;
		HttpSession session = req.getSession();
		String email = session.getAttribute("email").toString();
	
		try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("select userId from users where email=?");
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getInt("userId");
			}
			pstmt2= conn.prepareStatement("update users set name=?, mobilenumber=?, address=?, city=?, state=?,country=?,pincode=? where userId = ?");
			pstmt2.setString(1, name);
			pstmt2.setLong(2, mobile);
			pstmt2.setString(3, address);
			pstmt2.setString(4, city);
			pstmt2.setString(5, state);
			pstmt2.setString(6, country);
			pstmt2.setInt(7, pincode);
			pstmt2.setInt(8, id);
			int z = pstmt2.executeUpdate();
			if(z>0) {
				resp.sendRedirect("userdashboard.jsp");
			}else {
				resp.sendRedirect("userdashboardedit.jsp?msg=wrong");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DatabaseUtils.closeResultSet(rs);
			DatabaseUtils.closePreparedStatement(pstmt2);
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
		}
	}
}
