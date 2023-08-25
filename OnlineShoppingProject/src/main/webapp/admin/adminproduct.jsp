<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Alpha admin</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <link rel="stylesheet" href="adminhome.css">
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

    <div class="otherpages">
      <h2>Product records</h2>

      <%
      String msg = request.getParameter("msg"); 
      if("done".equals(msg)){
      %>
      <span style="color:green;">Product Added Successfully!</span>
      <%
      } if("wrong".equals(msg)){
      %>
      <span style="color:red;">Something Went Wrong! Try Again!</span>
      <%
      }
      if("update".equals(msg)){
      %>
      <span style="color:green;">Product Updated Successfully!</span>
      <%
      }
      %>
      <%
      if("deleted".equals(msg)){
      %>
      <span style="color:green;">Product Deleted Successfully!</span>
      <%
      }
      %>

      <div class="records">
        <a href="./createproduct.jsp"><button class="addProductButton">Add record</button></a>
        <div class="table-container">
          <table>
            <thead>
              <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Active</th>
                <th>Description</th>
                <th>Image</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <% try{
                Connection conn = ConnectionProvider.getCon();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("Select * from product");
                while(rs.next()){
              %>
              <tr>
                <td><%= rs.getInt(1) %></td>
                <td><%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
                <td><%= rs.getDouble(4) %></td>
                <td><%= rs.getString(5) %></td>
                <td><%= rs.getString(6) %></td>
                <td><%= rs.getString(7) %></td>
                <td>
                  <a href="./updateproduct.jsp?pid=<%=rs.getInt(1) %>">
                    <span class="updateicon"><i class="fa-solid fa-pen-to-square"></i></span>
                  </a> 
         
                    <span class="deleteicon" onclick="deleteProduct(<%=rs.getInt("pid")%>)"><i class="fa-solid fa-trash"></i></span>
                </td>
              </tr>
              <% }
                } catch(Exception e){
                  System.out.println(e);
                }
              %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
  	function deleteProduct(productId){
  		 if (confirm("Are you sure you want to delete this product?")) {
  	        window.location.href = "deleteProductAdmin?id=" + productId;
  	    }
  	}
  </script>
</body>
</html>
