<%@page import="project.DatabaseUtils"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Details</title>
<link rel="stylesheet" href="css/details.css">
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
<%
int id;
String idParam= request.getParameter("id");
if(idParam != null && !idParam.isEmpty()){
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
try{
	id = Integer.parseInt(idParam);
	conn = ConnectionProvider.getCon();
	pstmt = conn.prepareStatement("select * from product where pid = ?");
	pstmt.setInt(1, id);
	rs = pstmt.executeQuery();
	while(rs.next()){
	%>
	
	
		<div class="detail-container">
	
		<div class="img-container">
			<img src="image/<%=rs.getString("pimg")%>" alt="">
		</div>
		<div class="product-details">
			<h1><%= rs.getString("pname") %></h1>
			<br>
			<h3>Description:</h3>
			<p><%=rs.getString("pdesc")%></p>
			<span>₹ <%=rs.getString("pprice")%></span>
			<div class="details-btn">
				<form action="addToCart" method="post">
					<input type="hidden" value="<%=rs.getInt("pid") %>" name="pid"/>
					<input type="submit" value="Add to cart" class="btn">
				</form>
			</div>
		</div>
		</div>
		<%	}

}catch(Exception e){
	e.printStackTrace();
}finally{
	DatabaseUtils.closeResultSet(rs);
	DatabaseUtils.closePreparedStatement(pstmt);
	DatabaseUtils.closeConnection(conn);
}
}
%>
 <jsp:include page="footer.jsp"></jsp:include>
 
</body>
</html>