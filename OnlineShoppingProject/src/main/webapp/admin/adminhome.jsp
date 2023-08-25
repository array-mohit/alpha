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
			<h1>All records</h1>
			
			 <%
			 String msg = request.getParameter("msg");
      if("deleted".equals(msg)){
      %>
      <span style="color:green;">User Deleted Successfully!</span>
      <%
      } if("error".equals(msg)){
      %>
      <span style="color:red;">Something Went Wrong! Try Again!</span>
      <%
      }
      %>
			<div class="records">
			

				<div class="table-container">
					<table>
						<thead>
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Mobile Number</th>
								<th>Security Question</th>
								<th>Answer</th>
								<th>Address</th>
								<th>City</th>
								<th>State</th>
								<th>Country</th>
								<th>Action</th>

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
								rs = stmt.executeQuery("select * from users");
								while (rs.next()) {
							%>


							<tr>
								<td><%=rs.getString("name")%></td>
								<td><%=rs.getString("email")%></td>
								<td><%=rs.getLong("mobilenumber")%></td>
								<td><%=rs.getString("securityQuestion")%></td>
								<td><%=rs.getString("answer")%></td>
								<td><%=rs.getString("address")%></td>
								<td><%=rs.getString("city")%></td>
								<td><%=rs.getString("state")%></td>
								<td><%=rs.getString("country")%></td>
								<td><span class="deleteicon"
									onclick="deleteUser('<%=rs.getString("email")%>')"><i
										class="fa-solid fa-trash"></i></span></td>
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
  	function deleteUser(user){
  		console.log("function called");
  		 if (confirm("Are you sure you want to delete this user?")) {
  	        window.location.href = "deleteUserAdmin?email=" + user;
  	    }
  	}
  </script>
</body>
</html>