<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String url_mysql = "jdbc:mysql://localhost/AddressSwift?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";


	String user_userEmail = request.getParameter("user_userEmail");
	String address_addressNo = request.getParameter("address_addressNo");

    String WhereDefault = "select count(*) from AddressSwift.like where user_userEmail = ? and address_addressNo = ? ";
    int count = 0;

	PreparedStatement ps = null;
	ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        ps = conn_mysql.prepareStatement(WhereDefault);
	ps.setString(1, user_userEmail);
	ps.setString(2, address_addressNo);
	rs = ps.executeQuery();
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
			"result" : <%=rs.getString(1) %>
			
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
