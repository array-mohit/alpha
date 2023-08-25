<!DOCTYPE html>
<%@page import="project.DatabaseUtils"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alpha admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" ></script>
    <link rel="stylesheet" href="updateproduct.css">
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");


if(session.getAttribute("email")==null){
	response.sendRedirect("../login.jsp");
}
%>
    <jsp:include page="topbar.jsp"></jsp:include>
	<div class="admin-container">
		<jsp:include page="sidebar.jsp"></jsp:include>
		
		<%
		int id;
		String idParam= request.getParameter("pid");
		if(idParam != null && !idParam.isEmpty()){
		Connection con = null;
		Statement stmt =  null;
		ResultSet rs = null;
		id = Integer.parseInt(idParam);
		System.out.println(id);
		try{
			con = ConnectionProvider.getCon();
			stmt = con.createStatement();
			rs = stmt.executeQuery("Select * from product where pid ='"+id+"'");
			while(rs.next()){
		
		%>
		
        <div class="otherpages">
            <h2>Update Product details:</h2>
            <span>Product id:<%= rs.getString(1) %>
            </span>
            <form action="updateProduct" method="post" class="updateProduct" enctype="multipart/form-data">
				<input type="hidden" name="pid" value=<% out.println(id); %>>
                <div class="productUpdateItems">
                    <label for="">Sports:</label><br>
                    <select name="pcat" id="">
                        <option value="cricket" <%= (rs.getString("pcat").equals("cricket")) ? "selected" : "" %>>Cricket</option>
                        <option value="football" <%= (rs.getString("pcat").equals("football")) ? "selected" : "" %> >Football</option>
                        <option value="volleyball" <%= (rs.getString("pcat").equals("volleyball")) ? "selected" : "" %>>Volleyball</option>
                        <option value="baseball" <%= (rs.getString("pcat").equals("baseball")) ? "selected" : "" %>>Baseball</option>
                    </select>
                </div>
                <div class="productUpdateItems">
                    <label for="">Product Name:</label><br>
                    <input type="text" name="pname" id="" value="<%= rs.getString(2) %>" >
                </div>
                <div class="productUpdateItems">
                    <label for="">Product Price:</label><br>
                    <input type="number" name="pprice" id="" value="<%= rs.getDouble(4) %>">
                </div>
                <div class="productUpdateItems">
                    <label for="">Product description:</label><br>
                    <textarea name="pdesc" id="" cols="30" rows="5"><%= rs.getString(6) %></textarea>
                </div>
                <div class="productUpdateItems">
                    <label for="">Active:</label><br>
                    <select name="active" id="">
                        <option value="Yes" <%= (rs.getString("active").equals("Yes")) ? "selected" : "" %>>Yes</option>
                        <option value="No" <%= (rs.getString("active").equals("No")) ? "selected" : "" %>>No</option>
                    </select>
                </div>
                <div class="productUpdateItems">
                    <label for="">Product image:</label><br>
                     <img src="C:/Users/mohit bhange/Documents/javaproject/OnlineShoppingProject/image/<%=rs.getString("pimg")%>" alt="<%=rs.getString("pimg")%>" width="100" height="100"><br>
                    <input type="file" name="pimg" id="">
                </div>
                <div class="productUpdateItems">
                    <input type="submit" value="update">
                </div>
                
            </form>
        </div>
        <%}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DatabaseUtils.closeResultSet(rs);
			if(stmt!=null){
				try{
					stmt.close();
				}catch(Exception e){
					e.printStackTrace();
				}
				
			}
			DatabaseUtils.closeConnection(con);
		}
		}
        %>
        
    </div>
</body>
</html>