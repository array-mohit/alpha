<%@page import="project.DatabaseUtils"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>invoice page</title>
    <link rel="stylesheet" href="css/payment.css">
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
	<div class="invoice-container">
        <div class="invoice-header">
            <h1>Receipt:</h1>
            <h1 style="color: blue;">Alpha</h1>
        </div>
        <div class="invoice-details">
            <div class="invoice-address">
            <%
            String email = null;
            if(session.getAttribute("email")!=null){
				email = session.getAttribute("email").toString();
			}
            	Connection conn = null;
            	PreparedStatement pstmt = null,pstmt2=null,pstmt3=null;
            	ResultSet rs = null,rs2=null,rs3=null;
            	int subtotal = 0;
            	try{
            		conn = ConnectionProvider.getCon();
            		pstmt = conn.prepareStatement("Select sum(total) from cart where email=? and status='bill'");
            		pstmt.setString(1, email);
            		rs = pstmt.executeQuery();
            		if(rs.next()){
            			subtotal = rs.getInt(1);
            		}
            		pstmt2 = conn.prepareStatement("select * from cart where email=? and status='bill'");
            		pstmt2.setString(1, email);
            		rs2 = pstmt2.executeQuery();
            		if(rs2.next()){
            			
            		
            %>
                <p><strong>Bill To:</strong></p>
                <p><b>Name:</b> <%= rs2.getString("name")%></p>
                <p><b>Mobile No:</b> <%= rs2.getLong("mobileNumber") %></p>
                <p><b>Email:</b> <%= rs2.getString("email") %></p>
                <p><b>Address:</b> <%=rs2.getString("address") %>, <%=rs2.getString("city") %>,<%=rs2.getString("state") %>,
                <%=rs2.getInt("cpincode") %>, <%=rs2.getString("country") %></p>
            </div>
            <div class="invoice-payment">
                <p><strong>Payment Details:</strong></p>
                <p><b>Order Date:</b><%=rs2.getString("orderDate") %></p>
                <p><b>Delivery Date:</b><%=rs2.getString("deliveryDate") %></p>
                <p><b>Payment Method:</b> <%= rs2.getString("paymentMethod") %></p>
                <p><b>Transaction ID:</b> <%= rs2.getString("transactionId") %></p>
            </div>
       <%}%>
            	
        </div>
        **This is your order confirmation and receipt. Please keep this for your reference.**   
        <table class="invoice-products">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            
            	<%
            	pstmt3 = conn.prepareStatement("select * from product inner join cart on product.pid = cart.product_id where cart.email=? and cart.status='bill' ");
            	pstmt3.setString(1, email);
            	rs3 = pstmt3.executeQuery();
            	while(rs3.next()){
            		%>
            	
            <tbody>
                <tr>
                    <td><%=rs3.getString("product.pname") %></td>
                    <td><%=rs3.getString("product.pcat") %></td>
                    <td><%=rs3.getInt("product.pprice") %></td>
                    <td><%=rs3.getInt("cart.quantity") %></td>
                    <td><%=rs3.getInt("cart.total") %></td>
                </tr>
            </tbody>
            	<%
            	}
            	}catch(Exception e){
            		e.printStackTrace();
            	}finally{
            		DatabaseUtils.closeResultSet(rs3);
            		DatabaseUtils.closeResultSet(rs2);
            		DatabaseUtils.closeResultSet(rs);
            		DatabaseUtils.closePreparedStatement(pstmt3);
            		DatabaseUtils.closePreparedStatement(pstmt2);
            		DatabaseUtils.closePreparedStatement(pstmt);
            		DatabaseUtils.closeConnection(conn);
            	}
            	 %>  
            <tfoot>
                <tr>
                    <td colspan="4" style="text-align: right;"><strong>Total</strong></td>
                    <td><%=subtotal%></td>
                </tr>
            </tfoot>
        </table>
        <div class="button-container">
<form action="continueShoppingServlet" method="post" id="continueForm">
    <button class="continue-button" type="submit">Continue Shopping</button>
</form>
            <button class="print-button" onclick="window.print()">Print</button>
        </div> 
    </div>
</body>
</html>