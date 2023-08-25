<!DOCTYPE html>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />    
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
		int id=1;
		try{
			Connection con = ConnectionProvider.getCon();
			Statement stmt=con.createStatement();
			ResultSet rs = stmt.executeQuery("select max(pid) from product");
			while(rs.next()){
				id= rs.getInt(1);
				id = id+1;
			}
			
		}catch(Exception e){
			System.out.println(e);
		}
		String msg = request.getParameter("msg");
		
		%>

        <div class="otherpages">
            <h2>Add new Product</h2>
            <%
            if("done".equals(msg)){
            %>
            <span style="color:green;">Product Added Successfully!</span>
            <%
            } if("wrong".equals(msg)){
            %>
            <span style="color:red;">Something Went Wrong! Try Again!</span>
            <%
            }
            %>
            <span>Product id: <% out.println(id); %>
            </span>
            <form action="addNewProduct" method="post" class="updateProduct" enctype="multipart/form-data">
            <input type="hidden" name="pid" value=<% out.println(id); %>>
                <div class="productUpdateItems">
                    <label for="">Sports:</label><br>
                    <select name="pcat" id="">
                        <option value="cricket">Cricket</option>
                        <option value="football">Football</option>
                        <option value="volleyball">Volleyball</option>
                        <option value="baseball">Baseball</option>
                    </select>
                </div>
                <div class="productUpdateItems">
                    <label for="">Product Name:</label><br>
                    <input type="text" name="pname" id="" >
                </div>
                <div class="productUpdateItems">
                    <label for="">Product Price:</label><br>
                    <input type="number" name="pprice" id="" placeholder="">
                </div>
                <div class="productUpdateItems">
                    <label for="">Product description:</label><br>
                    <textarea name="pdesc" id="" cols="30" rows="5"></textarea>
                </div>
                <div class="productUpdateItems">
                    <label for="">Active:</label><br>
                    <select name="active" id="">
                        <option value="Yes">Yes</option>
                        <option value="No">No</option>
                    </select>
                </div>
                <div class="productUpdateItems">
                    <label for="">Product image:</label><br>
                    <input type="file" name="pimg" id="" >
                </div>
                <div class="productUpdateItems">
                    <input type="submit" value="Add">
                </div>
                
            </form>
        </div>
        
    </div>
</body>
</html>