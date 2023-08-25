<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>signup</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
        <div class="wrapper">
            <h2>Signup</h2>
            <form action="signupaction" method="post">
                <input type="text" name="name" placeholder="Full Name" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="text" name="mno" placeholder="Mobile Number" pattern="[0-9]{10}" onkeypress="allowOnlyNumbers(event)"
                	title="Please enter a valid mobile number with 10 digits"
                required>
                <select name="securityquestion" required>
                    <option value="what was your first car?">what was your first car?</option>
                    <option value="what is the name of youur first pet?">what is the name of youur first pet?</option>
                    <option value="what elementary school did you attend?">what elementary school did you attend?</option>
                    <option value="what is the name of the town where you were born?">what is the name of the town where you were born?</option>
                </select>
                <input type="text" name="answer" placeholder="Answer">
                <input type="password" name="password" placeholder="Password" required>
                <input type="password" name="cpassword" placeholder="Confirm Password" required>
                <input type="submit" value="Sign up">
                <%
                String msg = request.getParameter("msg");
                if("valid".equals(msg)){
                %>
                	<span class = "valid">Account registered successfully</span><br>
                <%
                }if("invalid".equals(msg)){
                %>
                <span class = "invalid">Something went Wrong! Try Again!</span><br>
                <%} %>
                <span>
                    Already a member? <a href="./login.jsp">Login here</a>
                </span>
            </form>
        </div>
        <script type="text/javascript">
        function allowOnlyNumbers(event) {
            const key = event.keyCode || event.which;
            const keyChar = String.fromCharCode(key);
            const pattern = /^\d+$/;

            if (!pattern.test(keyChar)) {
                event.preventDefault();
            }
        }
        //function validatePhoneNumber(phoneNumber) {
          //  return phoneNumber.length === 12;
        //}
        

        </script>
</body>
</html>