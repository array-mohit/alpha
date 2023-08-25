<%@page import="java.sql.PreparedStatement"%>
<%@page import="project.DatabaseUtils"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>user dashboard</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet" href="css/userdashboard.css">
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");


if(session.getAttribute("email")==null){
	response.sendRedirect("login.jsp");
}
%>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="user-container">
		<jsp:include page="sidebar.jsp"></jsp:include>


		<div class="otherpages">

			<!-- Inside the 'otherpages' div -->
			<div class="user-details">
			<%
			String email = null;
            if(session.getAttribute("email")!=null){
				email = session.getAttribute("email").toString();
			}
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try{
				conn = ConnectionProvider.getCon();
				pstmt = conn.prepareStatement("Select * from users where email=?");
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				if(rs.next()){
					
				
			%>
				<h2>User Details</h2>
				<p>
					<strong>Name:</strong> <%=rs.getString("name") %>
				</p>
				<p>
					<strong>Mobile Number:</strong> <%=rs.getLong("mobilenumber") %>
				</p>
				<p>
					<strong>Email:</strong> <%=rs.getString("email") %>
				</p>
				<p>
					<strong>Address:</strong> <%=rs.getString("address") %>
				</p>
				<p>
					<strong>City:</strong> <%=rs.getString("city") %>
				</p>
				<p>
					<strong>State:</strong> <%=rs.getString("state") %>
				</p>
				<p>
					<strong>Pincode:</strong> <%=rs.getString("pincode") %>
				</p>
				<% 
				}
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				DatabaseUtils.closeResultSet(rs);
				DatabaseUtils.closePreparedStatement(pstmt);
				DatabaseUtils.closeConnection(conn);
			}
			%> 
				<button class="editUserDetails" onclick="window.location.href='userdashboardedit.jsp'">Edit</button>
			</div>
		</div>
	</div>
</body>
</html>