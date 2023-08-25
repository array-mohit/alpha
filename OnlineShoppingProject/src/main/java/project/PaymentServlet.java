package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/paymentServlet")
public class PaymentServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		String email = session.getAttribute("email").toString();

		String paymentMethod = req.getParameter("paymentType");
		String status = "bill";
		String transactionId = generateTransactionId();
		Connection conn = null;
		PreparedStatement pstmt=null,pstmt2 = null;

		try {
			conn = ConnectionProvider.getCon();
			if("COD".equals(paymentMethod)) {
				transactionId = "-";
				pstmt = conn.prepareStatement(
						"Update cart set status=?,paymentMethod=?,orderDate=now(),deliveryDate=DATE_ADD(orderDate,INTERVAL 7 DAY),transactionId=? where email = ? and status is null");
				pstmt.setString(1, status);
				pstmt.setString(2, paymentMethod);
				pstmt.setString(3, transactionId);
				pstmt.setString(4, email);
				pstmt.executeUpdate();
			}else if("Card".equals(paymentMethod)) {
				transactionId = generateTransactionId();
				pstmt2 = conn.prepareStatement(
						"Update cart set status=?,paymentMethod=?,orderDate=now(),deliveryDate=DATE_ADD(orderDate,INTERVAL 7 DAY),transactionId=? where email = ? and status is null");
				pstmt2.setString(1, status);
				pstmt2.setString(2, paymentMethod);
				pstmt2.setString(3, transactionId);
				pstmt2.setString(4, email);
				pstmt2.executeUpdate();
			}
			

			resp.sendRedirect("invoice.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DatabaseUtils.closePreparedStatement(pstmt2);
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
		}

	}

	private static String generateTransactionId() {
		// Get current timestamp
		long timestamp = System.currentTimeMillis();

		// Generate a random UUID
		String uuid = UUID.randomUUID().toString();

		// Combine elements to create a unique transaction ID
		String transactionId = timestamp + "_" + uuid;

		// You can further format or manipulate the transaction ID as needed
		return transactionId;
	}
}
