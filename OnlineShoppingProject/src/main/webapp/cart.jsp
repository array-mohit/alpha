<%@page import="project.DatabaseUtils"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"  />
  <!--   integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" -->
   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" 
    integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="css/cart.css">
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
<%String productAdded =  request.getParameter("msg");%>
	 <div class="popup-container" id="popup">
        <p>Product added to cart successfully!</p>
    </div>
<jsp:include page="navbar.jsp"></jsp:include>
	<div class="cart-wrapper">
		<h1>YOUR CART</h1>
		<div class="cart-top">
			<button>CONTINUE SHOPPIING</button>
			<button>CHECKOUT</button>
		</div>
		<div class="cart-bottom">
			<div class="cart-info">
			
			
			<%
				int total = 0;
				String email = null;
				if(session.getAttribute("email")!=null){
					email = session.getAttribute("email").toString();
				}
				Connection conn = null;
				PreparedStatement pstmt = null,pstmt2 = null;
				ResultSet rs = null,rs2 = null;
				try{
					conn = ConnectionProvider.getCon();
					pstmt = conn.prepareStatement("select sum(total) from cart where email = ? and status is null");
					pstmt.setString(1, email);
					rs = pstmt.executeQuery();
					while(rs.next()){
						total = rs.getInt(1);
					}
					
					pstmt2 = conn.prepareStatement("select * from product inner join cart on product.pid = cart.product_id where cart.email=? and cart.status is null");
					pstmt2.setString(1, email);
					rs2 = pstmt2.executeQuery();
					while(rs2.next()){	
					%>
					
				<div class="cart-product">
					<div class="product-details">
						<div class="product-img">
						<img src="image/<%=rs2.getString("pimg") %>" alt=""> 
						</div>
						<span><b>Product: <br>
						</b> <%=rs2.getString("pname") %></span>
						<div class="total-product">
							<b style="font-size:20px;">Quantity:</b><br>
							<div class="product-amount">
							<i class="fa-solid fa-minus quantity-symbol" onclick="incdec('dec',<%=rs2.getInt("product_id")%>,<%=rs2.getInt("quantity")%>)"></i>
									&nbsp;<%=rs2.getString("quantity")%>&nbsp;
							<i class="fa-sharp fa-solid fa-plus quantity-symbol" onclick="incdec('inc',<%=rs2.getInt("product_id")%>,<%=rs2.getInt("quantity")%>)"></i>
							</div>
						</div>
					</div>
					<div class="product-price">
						<b>Price:</b>₹ <%=rs2.getDouble("pprice") %>
						<div class="remove-btn">
						<form action="removeCartAction" method="post">
							<input type="hidden" value="<%=rs2.getInt("product_id")%>" name="productId">
							<button type="submit">Remove</button>
						</form>
						</div>
					</div>
				</div>
				<hr>
<%}
				}catch(Exception e){
					e.printStackTrace();
				}finally {
					DatabaseUtils.closeResultSet(rs2);
					DatabaseUtils.closeResultSet(rs);
					DatabaseUtils.closePreparedStatement(pstmt2);
					DatabaseUtils.closePreparedStatement(pstmt);
					DatabaseUtils.closeConnection(conn);
					}
				
				
			
			%>

			</div>

			<div class="cart-summary">
				<h3 class="summarty-title">ORDER SUMMARY</h3>
				<div class="summary-item">
					<span>Subtotal:</span> <span>₹<%= total%></span>
				</div>
				<div class="summary-item">
					<span>Estimated Shipping:</span> <span>$5.90</span>
				</div>
				<div class="summary-item">
					<span>Shipping Discount:</span> <span>$-5.90</span>
				</div>
				<div class="summary-item" style="font-weight: 500; font-size: 24px;">
					<span>Total:</span> <span>₹<%= total%></span>
				</div>
				<%if(total>0){ %>
				<button onclick="window.location.href='paymentaddress.jsp'">CHECKOUT NOW</button>
				<%} %>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
	<script>
        // JavaScript code for showing and hiding the popup
        function showPopup() {
            var popup = document.getElementById("popup");
            popup.style.display = "block";
            setTimeout(function() {
                popup.style.display = "none";
            }, 3000); // Popup will disappear after 3 seconds (adjust the time as needed)
        }
        

        <% if ("added".equals(productAdded)) { %>
        showPopup();
      <% } %>
      
      
      function incdec(change,id,quantity){
    	  if(quantity>0){
    		  window.location.href = "incDecAction?quan="+change+"&id="+id;
    	  }
      }
      
    </script>
</body>
</html>