package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/deleteProductAdmin")
public class DeleteProductAdmin extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int productId=Integer.parseInt(req.getParameter("id"));
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = ConnectionProvider.getCon();
			pstmt = conn.prepareStatement("Delete From product where pid = ?");
			pstmt.setInt(1, productId);
			pstmt.executeUpdate();
			resp.sendRedirect("adminproduct.jsp?msg=deleted");
		} catch (Exception e) {
			resp.sendRedirect("adminproduct.jsp?msg=wrong");
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
		        }
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (conn != null) {
					conn.close();
		        }
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
}
