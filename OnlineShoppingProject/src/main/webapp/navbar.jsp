<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Navbar</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
	integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="css/index.css">
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
	<nav class="navbar">
		<div class="logo">
			<h1>Alpha</h1>
		</div>
		<ul class="menu">
			<li><a href="homepage.jsp">Home</a></li>
			<li>
				<div class="dropdown">
					<button class="profile-button">
						<i class="fa-solid fa-user icon-large"></i>
					</button>
					<div class="dropdown-options">
						<form action ="logout" method="post">
            				 <input type = "submit" value="Logout" class="logout-button">
            			</form>
						<a href="userdashboard.jsp">DashBoard</a>
					</div>
				</div>
			</li>
			<li><a href="#">About us</a></li>
			<li><a href="cart.jsp"><i class="fas fa-shopping-cart"></i></a></li>
		</ul>
	</nav>
</body>
</html>