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
	<nav class="topbar">
		<div class="topbarWrapper">
			<div class="topLeft">
				<span class="adminlogo">Alpha Admin</span>
			</div>
			<div class="topRight">
				<form action="logout" method="post">
					<input type="submit" value="Logout" class="logout-button">
				</form>
			</div>
		</div>
	</nav>
</body>
</html>