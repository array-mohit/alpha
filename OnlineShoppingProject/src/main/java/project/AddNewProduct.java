package project;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet("/admin/addNewProduct")
public class AddNewProduct extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int id= Integer.parseInt(req.getParameter("pid"));
		String name= req.getParameter("pname");
		String desc = req.getParameter("pdesc");
		String cat = req.getParameter("pcat");
		double price = Double.parseDouble(req.getParameter("pprice"));
		String active = req.getParameter("active");
		Part imgPart = req.getPart("pimg");
		
		
		
		String imgFileName = imgPart.getSubmittedFileName();
		String uploadPath = "C:/Users/mohit bhange/Documents/javaproject/OnlineShoppingProject/src/main/webapp/image/"+imgFileName;
		System.out.println(imgFileName);
		System.out.println(uploadPath);
		
		try {
		FileOutputStream outputStream = new FileOutputStream(uploadPath);
		InputStream inputStream = imgPart.getInputStream();
		
		byte[] bs = new byte[inputStream.available()];
		inputStream.read(bs);
		outputStream.write(bs);
		outputStream.close();
		inputStream.close();
		
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		Connection con= null;
		PreparedStatement pstmt = null;
		try {
			con =  ConnectionProvider.getCon();
			pstmt = con.prepareStatement("insert into product(pid,pname,pcat,pprice,active,pdesc,pimg) value(?,?,?,?,?,?,?)");
			pstmt.setInt(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, cat);
			pstmt.setDouble(4, price);
			pstmt.setString(5, active);
			pstmt.setString(6, desc);
			pstmt.setString(7, imgFileName);
			int res = pstmt.executeUpdate();
			if(res >0) {
				resp.sendRedirect("createproduct.jsp?msg=done");
			}else {
				resp.sendRedirect("createproduct.jsp?msg=wrong");
			}
			
		} catch (Exception e) {
			System.out.println(e);
			resp.sendRedirect("createproduct.jsp?msg=wrong");
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		
		
//		
//		Part imgPart = req.getPart("pimg");
//		String imgFileName = imgPart.getSubmittedFileName();
//		String uploadPath = "C:/Users/mohit bhange/Documents/javaproject/OnlineShoppingProject/image/" + imgFileName;
//
//		try {
//		    FileOutputStream outputStream = new FileOutputStream(uploadPath);
//		    InputStream inputStream = imgPart.getInputStream();
//
//		    byte[] bs = new byte[1024];
//		    int bytesRead;
//		    while ((bytesRead = inputStream.read(bs)) != -1) {
//		        outputStream.write(bs, 0, bytesRead);
//		    }
//
//		    inputStream.close();
//		    outputStream.close();
//
//		} catch (Exception e) {
//		    e.printStackTrace();
//		}
	}
}
