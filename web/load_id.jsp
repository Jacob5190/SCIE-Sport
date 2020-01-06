<%@ page import="java.sql.*" %>
<%@ page import="Utils.DBUtils" %><%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2019/12/27
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    Connection conn;
    Statement stm;
    ResultSet rs;
    String query = "select id from task;", val;
%>
<%=
"<option value=\"null\" selected>Please select task id</option>"%>
<%
    conn = DBUtils.getConn();
    stm = conn.createStatement();
    rs = stm.executeQuery(query);
    //Obtain every available id in the database and print out as an option in <select>.
    if (rs != null) {
        while (rs.next()) {
            val = rs.getString("id");
            out.println("<option value=\"" + val + "\">" + val + "</option>");
        }
        out.flush();
    }
%>
