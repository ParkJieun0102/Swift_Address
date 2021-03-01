<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>        

<%
	request.setCharacterEncoding("utf-8");
	String address_addressNo = request.getParameter("address_addressNo");

//------

	String url_mysql = "jdbc:mysql://localhost/AddressSwift?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";

	PreparedStatement ps = null;

	try{
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn_mysql = DriverManager.getConnection(url_mysql,id_mysql,pw_mysql);
	    Statement stmt_mysql = conn_mysql.createStatement();
	
		String A = "delete from AddressSwift.like ";
		String B = "where address_addressNo = ?";


	    ps = conn_mysql.prepareStatement(A+B);

        ps.setString(1, address_addressNo);
 
	    ps.executeUpdate();
	
	    conn_mysql.close();

	} 

	catch (Exception e){
	    e.printStackTrace();

	}

%>
