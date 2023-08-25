<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="project.ConnectionProvider"%>
<%
Connection connection= null;
Statement statement=null;
try{
	connection= ConnectionProvider.getCon();
	statement= connection.createStatement();
	String qry="create table users(name varchar(100),email varchar(100)primary key, mobilenumber bigint,securityQuestion varchar(200),answer varchar(200),password varchar(100),address varchar(500),city varchar(100),state varchar(100),country varchar(100))";
	String qry2="create table cart(email varchar(100),product_id int primary key,quantity int,price int,total int,pimg varchar(255),address varchar(500),city varchar(100),state varchar(100),country varchar(100),mobileNumber bigint,orderDate varchar(100),deliveryDate varchar(100),paymentMethod varchar(100),transactionId varchar(100),status varchar(10)) ";
	System.out.print(qry);
	System.out.print(qry2);
	//statement.execute(qry);
	statement.execute(qry2);
	System.out.print("Table Created");
	
}catch(Exception e){
	System.out.print(e);
}finally{
	connection.close();
	statement.close();
}
%>