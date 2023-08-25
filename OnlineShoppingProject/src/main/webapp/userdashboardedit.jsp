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
			<div class="user-details-form">
    <h2>Edit User Details</h2>
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
    <form id="userDetailsForm" method="post" action="editUserDetailServlet">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%=rs.getString("name") %>" required>
        </div>
        <div class="form-group">
            <label for="mobile">Mobile Number:</label>
            <input type="tel" id="mobile" name="mobile" value="<%=rs.getLong("mobilenumber") %>" pattern="[0-9]{10}" maxlength="10"
             title="Please enter a valid mobile number with 10 digits" onkeypress="allowOnlyNumbers(event)" required>
        </div>
        <div class="form-group">
            <label for="address">Address:</label>
            <textarea id="address" name="address" rows="3" required><%=rs.getString("address") %></textarea>
        </div>
        <div class="form-row">
            <div class="form-group-inline">
                <label for="city">City:</label>
                <input type="text" id="city" name="city" value="<%=rs.getString("city") %>" required>
            </div>
            <div class="form-group-inline">
                <label for="state">State:</label>
                <input type="text" id="state" name="state" value="<%=rs.getString("state") %>" required>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group-inline">
                <label for="country">Country:</label>
                <select name="country" class="addressFormInput" required>
					<option value=""> Select Country</option>
					<option value="India"  <%= ("India".equals(rs.getString("country"))) ? "selected" : ""%>>India</option>
				</select>
            </div>
            <div class="form-group-inline">
                <label for="pincode">Pin Code:</label>
                <input type="text" id="pincode" name="pincode" value="<%=rs.getString("pincode") %>" required>
            </div>
        </div>
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
        <button type="submit" class="edit-button" id="editButton">Save Changes</button>
    </form>
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
  	function allowOnlyNumbers(event) {
        const key = event.keyCode || event.which;
        const keyChar = String.fromCharCode(key);
        const pattern = /^\d+$/;

        if (!pattern.test(keyChar)) {
            event.preventDefault();
        }
    }
  </script>
</body>
</html>