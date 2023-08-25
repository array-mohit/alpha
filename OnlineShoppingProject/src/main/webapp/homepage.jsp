
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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


	<jsp:include page="navbar.jsp"></jsp:include>
	<section class="content">

		<h1>New Arrivals for Sports Lovers</h1>
		<p>Get the best quality product here</p>
		<button>shop now</button>
	</section>
	<h1 class="pheading">Our latest products</h1>
	<section class="sec">
		<div class="products">

			<% 
        	Connection conn = null;
        	Statement stmt = null;
        	ResultSet rs =  null;
        	
        	try{
        		conn = ConnectionProvider.getCon();
        		stmt =conn.createStatement();
        		rs = stmt.executeQuery("Select * from product where active ='Yes'");
        		while(rs.next()){
        			
        			  String path = "image/" + rs.getString("pimg");
        		
        %>
			<!-- card starts -->


			<div class="card">
				<a href="details.jsp?id=<%=rs.getInt("pid") %>" class="card-link">
					<div class="img">
						<img src="<%=path%>" alt="">
						<div class="desc"><%=rs.getString("pcat") %></div>
						<div class="title"><%=rs.getString("pname") %></div>
						<div class="box">
							₹ <%=rs.getDouble("pprice") %>
						</div>
					</div>
				</a>
			</div>

			<!-- card ends -->

			<% }}catch(Exception e){
        		 e.printStackTrace();
        	}
        	
        %>

		</div>
	</section>
	
	<jsp:include page="footer.jsp"></jsp:include>
	
	
</body>
</html>