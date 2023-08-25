<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<div class="sidebar">
		<div class="sidebarWrapper">
			<div class="sidebarMenu">
				<h3 class="sidebarTitle">Dashboard</h3>
				<ul class="sidebarList">
					<a href="./userdashboard.jsp">
						<li class="sidebarListItem"><i class="fa-solid fa-user"></i>
							Users</li>
					</a>
					<a href="./userorders.jsp">
						<li class="sidebarListItem"><i
						class="fa-solid fa-bag-shopping"></i> Orders</li>
					</a>
					<a href="./changepassword.jsp">
						<li class="sidebarListItem"><i class="fa-solid fa-pen-to-square"></i>
							Change Password</li>
					</a>
					<a href="./changequestion.jsp">
						<li class="sidebarListItem"><i class="fa-solid fa-pen-to-square"></i>
							Change security question</li>
					</a>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>