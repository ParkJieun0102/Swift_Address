<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
	String userEmail = request.getParameter("userEmail");

	String url_mysql = "jdbc:mysql://localhost/AddressSwift?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
    String WhereDefault = "select addressNo, addressName, addressPhone, addressEmail, addressText, addressBirth, addressStar, addressImage from address order by addressName asc" +
		String B = " where userEmail = '" + userEmail + "'";
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
			"addressNo" : <%=rs.getInt(1) %>,
			"addressName" : "<%=rs.getString(2) %>",
			"addressPhone" : "<%=rs.getString(3) %>", 
                          "addressEmail" : "<%=rs.getString(4) %>", 
			"addressText" : "<%=rs.getString(5) %>",
			"addressBirth" : "<%=rs.getString(6) %>",
			"addressStar" : "<%=rs.getString(7) %>", 
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