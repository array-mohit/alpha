<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="css/login.css" type="text/css">
</head>
<body>
	<div class="wrapper">
		<h2>Login</h2>
		<form action="validate" method="post">
			<input type="email" name="email" placeholder="Email" required> 
			<input type="password" name="password" placeholder="Password" autocomplete="off" required>
			<div class="recover">
				<a href="./recovery.jsp">Forget Password</a>
			</div><br>
			<%
			String msg = request.getParameter("msg");
			if("notexist".equals(msg)){
			%>
			<span class="invalid">Incorrect Credentials</span>
			<%	
			}
			%>
			
			<%
			if("invalid".equals(msg)){
			%>
			<span class="invalid">Something Went Wrong</span>
			<%	
			}
			%>
			
			<input type="submit" value="Login">
			 <span> Not a
				member? <a href="./signup.jsp">Register Now</a>
			</span>
		</form>
	</div>
</body>
</html>