<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2019/12/27
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    ArrayList<Integer> id = new ArrayList<>();
    String  user = "root",
            password = "Aa*20021122",
            url = "jdbc:mysql://127.0.0.1:3306/SCIESport?user=root&serverTimezone=Hongkong",
            query = "select id from task;",
            val;
%>
<%=
"<option value=\"null\" selected>Please select task id</option>"%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    try(Connection conn = DriverManager.getConnection(url, user, password);) {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery(query);
        while(rs.next()){
        	val = rs.getString("id");
        	out.println("<option value=\""+ val +"\">"+ val +"</option>");
        }
        out.flush();
    }catch (Exception e){
    	out.println(e.getMessage());
    }
%>
