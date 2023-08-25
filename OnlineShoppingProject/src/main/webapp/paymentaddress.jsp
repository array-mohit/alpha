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
<title>Address</title>
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
	<div class="paymentAddressContainer">
		<div class="paymentAddressForm">
			<h1>Delivery Details</h1>
			<%
			String email = null;
            if(session.getAttribute("email")!=null){
				email = session.getAttribute("email").toString();
			}
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = ConnectionProvider.getCon();
				pstmt = conn.prepareStatement("Select * from users where email = ?");
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				while (rs.next()) {
			%>

			<form action="paymentAddressAction" method="post">
				<label for="fullName" class="addressFormLabel">Full Name:</label> 
				<input type="text" name="Name" class="addressFormInput" value="<%=rs.getString("name")%>" required>
				
				<label for="phoneNumber" class="addressFormLabel">Phone Number:</label>
				<input type="tel" onkeypress="allowOnlyNumbers(event)" name="phoneNumber"class="addressFormInput" maxlength="10" value="<%=rs.getString("mobilenumber")%>"  required> 
				
				<label for="addressLine1" class="addressFormLabel">Address:</label>
				<input type="text" id="addressLine1" name="address"class="addressFormInput" value="<%= (rs.getString("address") != null) ? rs.getString("address") : "" %>" required>

				<div class="form-group">
					<div>
						<label for="city" class="addressFormLabel">City:</label>
						 <input type="text" name="city" class="addressFormInput" value="<%= (rs.getString("city") != null) ? rs.getString("city") : "" %>"  required>
					</div>
					
					<div>
						<label for="state" class="addressFormLabel">State:</label> 
						<input type="text" name="state" class="addressFormInput" value="<%= (rs.getString("state") != null) ? rs.getString("state") : "" %>"  required>
					</div>
				</div>

				<label for="pinCode" class="addressFormLabel">Pincode:</label> 
				<input type="text" name="pinCode" inputmode="numeric" onkeypress="allowOnlyNumbers(event)" class="addressFormInput" maxlength="6" value="<%= (rs.getInt("pincode") != 0) ? rs.getInt("pincode") : "" %>" required> 
				<label for="country" class="addressFormLabel">Country:</label> 
				<select name="country" class="addressFormInput" required>
					<option value=""> Select Country</option>
					<option value="India"  <%= ("India".equals(rs.getString("country"))) ? "selected" : ""%>>India</option>
				</select>

				<button class="payment-button" type="submit">Submit</button>
			</form>
			<%
			}
			} catch (Exception e) {
			e.printStackTrace();
			} finally {
			DatabaseUtils.closeResultSet(rs);
			DatabaseUtils.closePreparedStatement(pstmt);
			DatabaseUtils.closeConnection(conn);
			}
			%>
		</div>
	</div>
	<script>
        function allowOnlyNumbers(event) {
            const charCode = event.which || event.keyCode;
            const char = String.fromCharCode(charCode);

            if (!/^\d$/.test(char)) {
                event.preventDefault();
            }
        }
    </script>

</body>
</html>