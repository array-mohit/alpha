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
            <h2>Recovery</h2>
            <form action="recovery" method="post">
                <input type="email" name="email" placeholder="Email">
                <select name="securityquestion" required>
                    <option value="what was your first car?">what was your first car?</option>
                    <option value="what is the name of youur first pet?">what is the name of youur first pet?</option>
                    <option value="what elementary school did you attend?">what elementary school did you attend?</option>
                    <option value="what is the name of the town where you were born?">what is the name of the town where you were born?</option>
                </select>
                <input type="text" name="answer" placeholder="Answer">
                <input type="password" name="newpassword" placeholder="New Password">
                <input type="password" name="cpassword" placeholder="Confirm Password">
                <input type="submit" value="save"><br>
                <span>
                    Go back to <a href="./login.jsp">Login</a>
                </span>
                <br>
                <%
			String msg = request.getParameter("msg");
			if("done".equals(msg)){
			%>
			<span class="valid">Password changed successfully</span>
			<%	
			}
			%>
			
			<%
			if("invalid".equals(msg)){
			%>
			<span class="invalid">Something went wrong</span>
			<%	
			}
			%>
			<%
			if("mismatch".equals(msg)){
			%>
			<span class="invalid">invalid credentials</span>
			<%	
			}
			%>
            </form>
        </div>
</body>
</html>