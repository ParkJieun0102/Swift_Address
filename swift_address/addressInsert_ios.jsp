<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@page import="java.sql.*"%> 
       
<%
	request.setCharacterEncoding("utf-8");
	
	String addressName = request.getParameter("addressName");
	String addressPhone = request.getParameter("addressPhone");
	String addressEmail = request.getParameter("addressEmail");
	String addressText = request.getParameter("addressText");
	String addressBirth = request.getParameter("addressBirth");
	String savePath = "/Library/Tomcat/webapps/ROOT/swift_address";
	int sizeLimit = 10 * 1024 * 1024;
	
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, new DefaultFileRenamePolicy());

	File file = multi.getFile("file");
	String name = multi.getParameter("name");	


	String url_mysql = "jdbc:mysql://localhost/AddressSwift?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";

	PreparedStatement ps = null;
	try{
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn_mysql = DriverManager.getConnection(url_mysql,id_mysql,pw_mysql);
	    Statement stmt_mysql = conn_mysql.createStatement();
	
	    String A = "insert into address (addressName, addressPhone, addressEmail, addressText, addressBirth, addressImage";
	    String B = ") VALUES(?,?,?,?,?,?)";
	
	    ps = conn_mysql.prepareStatement(A+B);
	    ps.setString(1, addressName);
	    ps.setString(2, addressPhone);
	    ps.setString(3, addressEmail);
	    ps.setString(4, addressText);
	    ps.setString(5, addressBirth);
	    ps.setString(6, file.getName());
	    
	    ps.executeUpdate();
	
	    conn_mysql.close();
	} 
	
	catch (Exception e){
	    e.printStackTrace();
	}

%>

