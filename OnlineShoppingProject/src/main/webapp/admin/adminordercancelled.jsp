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
<title>Alpha admin</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet" href="adminhome.css">
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");


if(session.getAttribute("email")==null){
	response.sendRedirect("../login.jsp");
}
%>
	<jsp:include page="topbar.jsp"></jsp:include>
	<div class="admin-container">
		<jsp:include page="sidebar.jsp"></jsp:include>


		<div class="otherpages">
			<h1>Order Records</h1>
			
		 <%
      String msg = request.getParameter("msg"); 
      if("Delivered".equals(msg)){
      %>
      <span style="color:green;">Product Delivered Successfully!</span>
      <%
      } if("Cancelled".equals(msg)){
      %>
      <span style="color:red;">Product Cancelled Successfully!</span>
      <%
      }
      if("error".equals(msg)){
      %>
      <span style="color:red;">Something went Wrong</span>
      <%
      }
      %>
     
			<div class="records">
			

				<div class="table-container">
					<table>
						<thead>
							<tr>
								<th>Product name</th>
								<th>Quantity</th>
								<th>Subtotal</th>
								<th>Name</th>
								<th>Email</th>
								<th>Mobile Number</th>
								<th>Address</th>
								<th>City</th>
								<th>State</th>
								<th>Country</th>
								<th>Order Date</th>
								<th>Expected Delivery</th>
								<th>Payment Method</th>
								<th>Transaction Id</th>
								<th>Status</th>

							</tr>
						</thead>
						<tbody>
							<%
							Connection conn = null;
							Statement stmt = null;
							ResultSet rs = null;
							try {
								conn = ConnectionProvider.getCon();
								stmt = conn.createStatement();
								rs = stmt.executeQuery("select * from cart inner join product on product.pid = cart.product_id where cart.orderDate is not null and cart.status='Cancelled'");
								while (rs.next()) {
							%>


							<tr>
								<td><%=rs.getString("pname")%></td>
								<td><%=rs.getString("Quantity")%></td>
								<td><%=rs.getLong("total")%></td>
								<td><%=rs.getString("name")%></td>
								<td><%=rs.getString("email")%></td>
								<td><%=rs.getString("mobileNumber")%></td>
								<td><%=rs.getString("address")%></td>
								<td><%=rs.getString("city")%></td>
								<td><%=rs.getString("state")%></td>
								<td><%=rs.getString("country")%></td>
								<td><%=rs.getString("orderDate")%></td>
								<td><%=rs.getString("deliveryDate")%></td>
								<td><%=rs.getString("paymentMethod")%></td>
								<td><%=rs.getString("transactionId")%></td>
								<td><%=rs.getString("status")%></td>
							</tr>




							<%
							}
							} catch (Exception e) {
							e.printStackTrace();
							} finally {
							DatabaseUtils.closeResultSet(rs);
							if (stmt != null) {
							try {
								stmt.close();
							} catch (Exception e) {
								e.printStackTrace();
							}
							}
							DatabaseUtils.closeConnection(conn);
							}
							%>


						</tbody>
					</table>
				</div>

			</div>
		</div>

	</div>
	<script type="text/javascript">
	document.getElementById('cancelAction').addEventListener('click', function () {
	    document.getElementById('cancelForm').submit();
	});

	document.getElementById('updateAction').addEventListener('click', function () {
	    document.getElementById('updateForm').submit();
	});

  </script>
</body>
</html>