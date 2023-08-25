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
			<div class="user-order-info">
			
			
			<%
				int total = 0;
				String email = null;
				if(session.getAttribute("email")!=null){
					email = session.getAttribute("email").toString();
				}
				Connection conn = null;
				PreparedStatement pstmt = null,pstmt2 = null;
				ResultSet rs = null,rs2 = null;
				try{
					conn = ConnectionProvider.getCon();
					pstmt = conn.prepareStatement("select sum(total) from cart where email = ? and status is null");
					pstmt.setString(1, email);
					rs = pstmt.executeQuery();
					while(rs.next()){
						total = rs.getInt(1);
					}
					
					pstmt2 = conn.prepareStatement("select * from product inner join cart on product.pid = cart.product_id where cart.email=? and cart.status IN ('Processing','Delivered','Cancelled')");
					pstmt2.setString(1, email);
					rs2 = pstmt2.executeQuery();
					while(rs2.next()){	
					%>
					
				<div class="user-order-product">
					<div class="user-order-details">
						<div class="user-order-img">
						<img src="image/<%=rs2.getString("pimg") %>" alt=""> 
						</div>
						<div class="order-name-status">
						<span>
						<b>Product:</b> <br>
						 <%=rs2.getString("pname") %>
						</span>
						<span><b>Status: </b> <br>
						<%=rs2.getString("status") %>
						 </span>
						
						</div>
						<div class="total-product">
							<b style="font-size:20px;">Quantity:</b>
							<div class="product-amount">
								&nbsp;<%=rs2.getString("quantity")%>&nbsp;	
							</div>
							<button class="download-button" onclick="window.location.href='userinvoice.jsp?id=<%=rs2.getInt("orderid") %>'">Download</button>
							
						</div>
					</div>
					<div class="product-price">
						<b>Price:</b>₹ <%=rs2.getDouble("pprice") %>
						<div class="remove-btn">
						<%if("Processing".equals(rs2.getString("status"))){%>
						<form action="cancelDeliveredAction" method="post" id="cancelForm">
    						<input type="hidden" name="action" value="Cancelled">
    						<input type="hidden" name="id" value="<%=rs2.getInt("orderid")%>">
    						<input type="hidden" name="email" value="<%=rs2.getString("email")%>">
    						
   							<button type="submit">Cancel</button>
						</form>
						<%} %>
						</div>
					</div>
				</div>
				<hr>
<%}
				}catch(Exception e){
					e.printStackTrace();
				}finally {
					DatabaseUtils.closeResultSet(rs2);
					DatabaseUtils.closeResultSet(rs);
					DatabaseUtils.closePreparedStatement(pstmt2);
					DatabaseUtils.closePreparedStatement(pstmt);
					DatabaseUtils.closeConnection(conn);
					}
			%>

			</div>
		</div>
	</div>
</body>
</html>