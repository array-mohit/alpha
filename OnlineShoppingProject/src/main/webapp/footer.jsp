<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<!-- footer -->
    <footer>
        <div class="left">
            <span class="logo">
                <h1>Alpha</h1>
            </span>
            <p class="description">
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est repudiandae velit nam! Molestiae placeat tempora distinctio illum eius? Laborum eaque enim reprehenderit iusto error ratione modi eius corporis ex. Tenetur.
            </p>
            <div class="socialcontainer">
                <div class="socialicon" style=" background-color: #3b5999 ;">
                    <i class="fa-brands fa-facebook-f"></i>
                </div>
                <div class="socialicon" style=" background-color: #e4405f ;">
                    <i class="fa-brands fa-instagram"></i>
                </div>
                <div class="socialicon" style=" background-color: #55acee;">
                    <i class="fa-brands fa-twitter"></i>
                </div>
                <div class="socialicon" style=" background-color: #e60023;">
                    <i class="fa-brands fa-square-pinterest"></i>
                </div>
            </div>
        </div>

        <div class="center">
            <h1>Useful Links</h1>
            <ul>
                <li>Home</li>
                <li>Cart</li>
                <li>About us</li>
                <li>Terms</li>

            </ul>
        </div>

        <div class="right">
            <h1>Contact</h1>
            <div class="contactitems">
                <i class="fa-solid fa-location-dot"></i>&nbsp;
                22 Baker Street , London , England
            </div>
            <div class="contactitems">
                <i class="fa-solid fa-phone"></i>&nbsp;
                020 86 573 73 529
            </div>
            <div class="contactitems">
                <i class="fa-solid fa-envelope"></i>&nbsp;
                contact@alpha.dev
            </div>
        </div>
</body>
</html>