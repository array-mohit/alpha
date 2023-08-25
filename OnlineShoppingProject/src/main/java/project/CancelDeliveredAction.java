package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/admin/cancelDeliveredAction","/cancelDeliveredAction"})
public class CancelDeliveredAction extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("id"));
		String email = req.getParameter("email");
		String status = req.getParameter("action");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = ConnectionProvider.getCon();
			if("Cancelled".equals(status)) {
				String expectedDelivery = "-";
				pstmt = conn.prepareStatement("update cart set status = ?,deliveryDate=? where orderid=? and email=? and transactionId is not null");
				
				pstmt.setString(1, status);
				pstmt.setString(2, expectedDelivery);
				pstmt.setInt(3, id);
				pstmt.setString(4, email);
				pstmt.executeUpdate();
			}else if("Delivered".equals(status)){
				pstmt = conn.prepareStatement("update cart set status = ?,deliveryDate=now() where orderid=? and email=? and transactionId is not null");
				
				pstmt.setString(1, status);
				pstmt.setInt(2, id);
				pstmt.setString(3, email);
				pstmt.executeUpdate();
			} 
			String requestUrl = req.getRequestURI().toString();
			String contextPath = req.getContextPath();
			
			if(requestUrl.endsWith("/admin/cancelDeliveredAction")) {
				resp.sendRedirect("adminorder.jsp?msg="+status);
			}else if(requestUrl.endsWith("/cancelDeliveredAction")) {
				resp.sendRedirect(contextPath+"/userorders.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("adminorder.jsp?msg=error");
		} finally {
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
		}
	}
}
