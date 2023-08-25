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
<title>Card</title>
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
    <div class="paymentCardContainer">
        <div class="cardFormContainer">
            <div class="paymentCardForm">
                <h2>Payment Details</h2>
                <form method="post" action="paymentServlet" id="paymentForm">
                	<input type ="hidden" name="paymentType" value="Card">
                    <div class="payment-group">
                        <label for="cardNumber" class="paymentCardLabel">Card Number:</label>
                        <input type="text" class="paymentCardInput" id="cardNumber" onkeypress="allowOnlyNumbers(event)"
                            maxlength="16"  autocomplete="off" required>
                        <span id="cardNumberError" class="error-message"></span>
                    </div>
                    <div class="payment-group">
                        <label for="cardName" class="paymentCardLabel">Cardholder Name:</label>
                        <input type="text" class="paymentCardInput" id="cardName" autocomplete="off"  required>
                    </div>
                    <div class="form-row">
                        <div class="payment-group2">
                            <label for="expiryDate" class="paymentCardLabel">Expiry Date:</label><br>
                            <input type="text" id="expiryDate" class="paymentCardInput" name="expiryDate"
                                placeholder="mm/yy"
                                onkeypress="allowOnlyNumbers(event); formatExpiryDate(event);"
                                maxlength="5" required>
                            <span id="expiryDateError" class="error-message"></span>
                        </div>
                        <div class="payment-group2">
                            <label for="cvv" class="paymentCardLabel">CVV:</label><br>
                            <input type="password" class="paymentCardInput" onkeypress="allowOnlyNumbers(event)" id="cvv"
                                maxlength="3" required>
                            <span id="cvvError" class="error-message"></span>
                        </div>
                    </div>
                    <button type="submit" id="paymentCardButton" class="paymentCardButton">Pay
                        Now</button>
                </form>
                <div class="cashOnDeliveryForm">
                    <h2>
                        <hr>OR
                        <hr>
                    </h2>
                    <form action="paymentServlet" method="post">
						<input type ="hidden" name="paymentType" value="COD">
                        <button type="submit"
                            onclick="return confirm('Are you sure you want to proceed with Cash on Delivery?');"
                            class="paymentCardButton">Cash On Delivery</button>
                    </form>
                </div>
            </div>

        </div>
        
        <%
        String email = null;
        if(session.getAttribute("email")!=null){
			email = session.getAttribute("email").toString();
		}
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        double total = 0;
        int quantity= 0;
        try{
        	conn = ConnectionProvider.getCon();
        	pstmt = conn.prepareStatement("Select sum(total),sum(quantity) from cart where email = ? and status is null");
        	pstmt.setString(1, email);
        	rs = pstmt.executeQuery();
        	if(rs.next()){
        		total = rs.getInt(1);
            	quantity = rs.getInt(2);
        	}
        	
        }catch(Exception e){
        	e.printStackTrace();
        }finally{
        	DatabaseUtils.closeResultSet(rs);
        	DatabaseUtils.closePreparedStatement(pstmt);
        	DatabaseUtils.closeConnection(conn);
        }
        
        
        
        %>

        <div class="cart-summary">
            <h3 class="summary-title" style="font-weight:bold;font-size: 24px;"> ORDER SUMMARY</h3>
            <div class="summary-item">
                <span><b>Subtotal:</b></span>
                <span><%= total %></span>
            </div>
            <div class="summary-item">
                <span><b>Number of items:</b></span>
                <span><%= quantity %></span>
            </div>
            <div class="summary-item">
                <span><b>Estimated Shipping:</b></span>
                <span>$5.90</span>
            </div>
            <div class="summary-item">
                <span><b>Discount:</b></span>
                <span>$-5.90</span>
            </div>
            <div class="summary-item" style="font-weight:500;font-size: 24px;">
                <span>Total:</span>
                <span><%=total %></span>
            </div>
        </div>
    </div>
    <script>
    if(window.history.forward(1)!=null){
    	window.history.forward(1);
    }
        function allowOnlyNumbers(event) {
            const key = event.keyCode || event.which;
            const keyChar = String.fromCharCode(key);
            const pattern = /^\d+$/;

            if (!pattern.test(keyChar)) {
                event.preventDefault();
            }
        }

        function formatExpiryDate(event) {
            const input = event.target;
            const inputValue = input.value;

            if (inputValue.length === 2 && inputValue.indexOf("/") === -1) {
                input.value = inputValue + "/";
            }
        }
        function validateFields() {
            var cardNumber = document.getElementById('cardNumber').value;
            var expiryDate = document.getElementById('expiryDate').value;
            var cvv = document.getElementById('cvv').value;

            var cardNumberError = document.getElementById('cardNumberError');
            var expiryDateError = document.getElementById('expiryDateError');
            var cvvError = document.getElementById('cvvError');

            var isValid = true;
            // Validate card number and update error message
            if (!validateCardNumber(cardNumber)) {
                isValid = false;
                cardNumberError.textContent = 'Card number must be 12 digits';
            } else {
                cardNumberError.textContent = '';
            }

            // Validate expiry date and update error message
            if (!validateExpiryDate(expiryDate)) {
                isValid = false;
                expiryDateError.textContent = 'Please enter a valid expiration date';
            } else {
                expiryDateError.textContent = '';
            }

            // Validate CVV and update error message
            if (!validateCVV(cvv)) {
                isValid = false;
                cvvError.textContent = 'CVV must be 3 digits';
            } else {
                cvvError.textContent = '';
            }

            return isValid;
        }

        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('paymentForm').addEventListener('submit', function (event) {
                event.preventDefault();

                if (validateFields()) {
                	if(confirm('Are you sure you want to proceed with Debit Card?')){
                		document.getElementById('paymentForm').submit();	
                	}
                }
            });
        });

        function validateCardNumber(cardNumber) {
            return cardNumber.length === 16;
        }

        function validateExpiryDate(expiryDate) {
            var parts = expiryDate.split('/');
            var enteredMonth = parseInt(parts[0], 10);
            var enteredYear = parseInt(parts[1], 10);

            var today = new Date();
            var currentMonth = today.getMonth() + 1;
            var currentYear = today.getFullYear() % 100;

            
            return (
                enteredMonth >= 1 && enteredMonth <= 12 &&
                enteredYear >= currentYear && (enteredYear > currentYear || enteredMonth >= currentMonth)
            );
        }

        function validateCVV(cvv) {
            return cvv.length === 3;
        }
    </script>
</body>
</html>