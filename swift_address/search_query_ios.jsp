<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");
    String search = request.getParameter("search");

	String url_mysql = "jdbc:mysql://localhost/AddressSwift?serverTimezone=Asia/Seoul&characterEncoding=utf8&useSSL=false";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";

     String WhereDefault = "select addressNo, addressName, addressPhone, addressEmail, addressText, addressBirth, addressImage from address order by addressName asc";

    int count = 0;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();
        
        ResultSet rs = stmt_mysql.executeQuery(WhereDefault); // &quot;
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
                "addressNo" : "<%=rs.getString(1) %>", 
                "addressName" : "<%=rs.getString(2) %>",
                "addressPhone" : "<%=rs.getString(3) %>", 
                "addressEmail" : "<%=rs.getString(4) %>",  
                "addressText" : "<%=rs.getString(5) %>",
	        "addressBirth" : "<%=rs.getString(6) %>",
		"addressImage" : "<%=rs.getString(7) %>"		
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


