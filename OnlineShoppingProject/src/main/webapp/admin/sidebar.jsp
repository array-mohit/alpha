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
<link rel="stylesheet" href="adminhome.css">
</head>
<body>
	<div class="sidebar">
		<div class="sidebarWrapper">
			<div class="sidebarMenu">
				<h3 class="sidebarTitle">Dashboard</h3>
				<ul class="sidebarList">
					<a href="./adminhome.jsp">
						<li class="sidebarListItem"><i class="fa-solid fa-user"></i>
							Users</li>
					</a>
					<a href="./adminproduct.jsp">
						<li class="sidebarListItem"><i class="fa-solid fa-box-open"></i>
							Products</li>
					</a>
					<a href="./adminorder.jsp">
						<li class="sidebarListItem">
						<i class="fa-solid fa-bag-shopping"></i> Orders</li>
					</a>
					<a href="./adminorderdelivered.jsp">
						<li class="sidebarListItem"><i class="fa-solid fa-truck"></i> Order Delivered</li>
					</a>
					<a href="./adminordercancelled.jsp">
						<li class="sidebarListItem"><i class="fa-solid fa-ban"></i> Order Cancelled</li>
					</a>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>