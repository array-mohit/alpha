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
			<%
			String msg = request.getParameter("msg");
			if("success".equals(msg)){
			%>
			<span class="valid">Password Change Successfully.</span>
			<%	
			}
			%>
			
			<%
			if("error".equals(msg)){
			%>
			<span class="invalid">Incorrect old password</span>
			<%	
			}
			%>
			<%
			if("cancel".equals(msg)){
			%>
			<span class="invalid">New Password and Confirm password doesn't match</span>
			<%	
			}  
			String email = null;
		    if(session.getAttribute("email")!=null){
				email = session.getAttribute("email").toString();
			}							
		%>
				<h2>Edit User Details</h2>
  
				<form id="userDetailsForm" method="post"
					action="editUserPasswordServlet">
					<div class="form-group">
					<input type ="hidden" name="email" value="<%=email%>">
						<label for="oldPassword">Old Password:</label>
						<div class="password-input">
							<input type="password" name="oldPassword" id="oldPassword"
								required>
							<button type="button" class="password-toggle"
								id="oldPasswordToggle">
								<i class="fa-solid fa-eye"></i>
							</button>
						</div>
					</div>

					<div class="form-group">
						<label for="name">New Password:</label> 
						<div class="password-input">
							<input type="password" name="newPassword" id="newPassword"
								required>
							<button type="button" class="password-toggle"
								id="newPasswordToggle">
								<i class="fa-solid fa-eye"></i>
							</button>
						</div>
					</div>
					<div class="form-group">
						<label for="name">Confirm Password:</label> 
						<div class="password-input">
							<input type="password" name="confirmPassword" id="confirmPassword"
								required>
							<button type="button" class="password-toggle"
								id="confirmPasswordToggle">
								<i class="fa-solid fa-eye"></i>
							</button>
						</div>
					</div>
					<button type="submit" class="edit-button" id="editButton">Save
						Changes</button>
				</form>
			</div>
		</div>
	</div>
	<script>
document.getElementById('oldPasswordToggle').addEventListener('click', function () {
    togglePasswordVisibility('oldPassword');
});
document.getElementById('confirmPasswordToggle').addEventListener('click', function () {
    togglePasswordVisibility('confirmPassword');
});
document.getElementById('newPasswordToggle').addEventListener('click', function () {
    togglePasswordVisibility('newPassword');
});

function togglePasswordVisibility(inputId) {
    const input = document.getElementById(inputId);
    
    if (input.type === 'password') {
        input.type = 'text';
    } else {
        input.type = 'password';
    }
}
</script>

</body>
</html>