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
				<span class="valid">Security Question Change Successfully.</span>
				<%	
			}
			%>

				<%
			if("error".equals(msg)){
			%>
				<span class="invalid">Incorrect Confirm Password</span>
				<%	
			}
			%>
				<%
			String email = null;
		    if(session.getAttribute("email")!=null){
				email = session.getAttribute("email").toString();
			}							
		%>
				<h2>Edit User Details</h2>

				<form method="post" action="editUserQuestionServlet">
					<div class="form-group">
						<input type="hidden" name="email" value="<%=email%>">
						<label for="securityquestion">Select new security question:</label>
							
						 <select name="securityquestion" required>
							<option value="what was your first car?">what was your first car?</option>
							<option value="what is the name of youur first pet?">what is the name of your first pet?</option>
							<option value="what elementary school did you attend?">what elementary school did you attend?</option>
							<option value="what is the name of the town where you were born?">what is the name of the town where you were born?</option>
						</select>
					</div>

					<div class="form-group">
						<label for="answer">Answer:</label> 
						<input type="text" name="answer" required>
					</div>
					<div class="form-group">
						<label for="name">Confirm Password:(for security)</label>
						<div class="password-input">
							<input type="password" name="confirmPassword" id="confirmPassword" required>
							<button type="button" class="password-toggle" id="confirmPasswordToggle">
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

document.getElementById('confirmPasswordToggle').addEventListener('click', function () {
    togglePasswordVisibility('confirmPassword');
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