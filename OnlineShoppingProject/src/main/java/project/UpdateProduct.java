package project;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet("/admin/updateProduct")
public class UpdateProduct extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("pid"));
		String name= req.getParameter("pname");
		String desc = req.getParameter("pdesc");
		String cat = req.getParameter("pcat");
		double price = Double.parseDouble(req.getParameter("pprice"));
		String active = req.getParameter("active");
		Part imgPart = req.getPart("pimg");
		String imgFileName = imgPart.getSubmittedFileName();
		
		Connection con = null;
		PreparedStatement pstmt = null,pstmt2 = null;
		String query; 
		
		try {
			
			con = ConnectionProvider.getCon();
			
			if(imgFileName != null && !imgFileName.isEmpty()) {
				String uploadPath = "C:/Users/mohit bhange/Documents/javaproject/OnlineShoppingProject/src/main/webapp/image/"+imgFileName;
				deleteExistingImage(id);
				imgPart.write(uploadPath);
				query= "Update product set pname=?, pdesc=?, pcat=?, pprice=?,active=?,pimg=? where pid=?";
			}else {
				query= "Update product set pname=?, pdesc=?, pcat=?, pprice=?,active=? where pid=?";
			}
			
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, name);
			pstmt.setString(2, desc);
			pstmt.setString(3, cat);
			pstmt.setDouble(4, price);
			pstmt.setString(5, active);
			if(imgFileName != null && !imgFileName.isEmpty()) {
				pstmt.setString(6, imgFileName);
				pstmt.setInt(7, id);
			}else {
				pstmt.setInt(6, id);
			}
			
			
			
			pstmt.executeUpdate();
			if(active.equals("No")) {
				pstmt2 = con.prepareStatement("delete from cart where product id =? and status is null");
				pstmt2.setInt(1, id);
				pstmt2.executeUpdate();
			}
			resp.sendRedirect("adminproduct.jsp?msg=update");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("adminproduct.jsp?msg=wrong");
		} finally {
			DatabaseUtils.closePreparedStatement(pstmt2);
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(con);
		}
		
	}
	
//	private void saveImageToServer(Part imgPart, String uploadPath) throws IOException{
//		FileOutputStream outputStream = new FileOutputStream(uploadPath);
//		InputStream inputStream = imgPart.getInputStream();
//		
//		byte[] bs = new byte[inputStream.available()];
//		inputStream.read(bs);
//		outputStream.write(bs);
//		outputStream.close();
//	}
	private void deleteExistingImage(int id) {
		try {
			Connection con = ConnectionProvider.getCon();
			PreparedStatement pstmt = con.prepareStatement("Select pimg From product where pid=?");
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String existingImgFileName = rs.getString("pimg");
				if (existingImgFileName != null) {
                    File existingImgFile = new File("C:/Users/mohit bhange/Documents/javaproject/OnlineShoppingProject/src/main/webapp/image/" + existingImgFileName);
                    if (existingImgFile.exists()) {
                        existingImgFile.delete();
                    }
                }
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			System.out.println("update delete me gadbad");
		}
	}
}
