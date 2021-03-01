<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>        
<%
	request.setCharacterEncoding("utf-8");
	String userPw = request.getParameter("userPw");
	String userName = request.getParameter("userName");
	String userPhone = request.getParameter("userPhone");
	String userEmail = request.getParameter("userEmail");	
		
//------
	String url_mysql = "jdbc:mysql://localhost/AddressSwift?serverTimezone=Asia/Seoul&characterEncoding=utf8&useSSL=false";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";

	PreparedStatement ps = null;
	try{
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection conn_mysql = DriverManager.getConnection(url_mysql,id_mysql,pw_mysql);
	    Statement stmt_mysql = conn_mysql.createStatement();
	
	String A = "update user set userPw = ?, userName = ?, userPhone = ?";
        String B = " where userEmail = ?";
	
	    ps = conn_mysql.prepareStatement(A+B);
	    
	    ps.setString(1, userPw);
	    ps.setString(2, userName);
	    ps.setString(3, userPhone);
	    ps.setString(4, userEmail);
	    
	    ps.executeUpdate();
	
	    conn_mysql.close();
	} 
	
	catch (Exception e){
	    e.printStackTrace();
	}
	
%>

