<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
	String user_userEmail = request.getParameter("userEmail");

	String url_mysql = "jdbc:mysql://localhost/AddressSwift?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
    String WhereDefault = "select l.user_userEmail, l.address_addressNo, a.addressName, a.addressPhone, a.addressEmail, a.addressText, a.addressBirth, a.addressImage from address a, AddressSwift.like l";
		String B = " where a.addressNo = l.address_addressNo And l.user_userEmail = '" + user_userEmail + "'";
    int count = 0;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        ResultSet rs = stmt_mysql.executeQuery(WhereDefault + B); // &quot;
%>
  	[ 
<%
        while (rs.next()) {
            if (count == 0) {

            }else{
%>
            , 
<%           
            }
            count++;                 
%>
			{
			"user_userEmail" : "<%=rs.getString(1) %>",
			"address_addressNo" : <%=rs.getInt(2) %>,
			"addressName" : "<%=rs.getString(3) %>",   
			"addressPhone" : "<%=rs.getString(4) %>", 
			"addressEmail" : "<%=rs.getString(5) %>",
			"addressText" : "<%=rs.getString(6) %>",
			"addressBirth" : "<%=rs.getString(7) %>",
			"addressImage" : "<%=rs.getString(8) %>"
			}
<%		
        }
%>
		  ]
<%		
        conn_mysql.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
	
%>
