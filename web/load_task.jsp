<%@ page import="java.sql.ResultSet" %>
<%@ page import="Utils.DBUtils" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %><%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2019/12/27
  Time: 20:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    Connection conn;
    Statement stm;
    ResultSet rs;
    String query, id, title, grade, gender, photo, report, ddl;
%>
<%
    query = "select * from task;";
    conn = DBUtils.getConn();
    stm = conn.createStatement();
    rs = stm.executeQuery(query);
    //Obtain every data record of task in the database and format it into table cells.
    while (rs.next()){
        id = rs.getString("id");
        title = rs.getString("title");
        grade = rs.getString("grade");
        gender = rs.getString("gender");
        photo = rs.getString("photo");
        report = rs.getString("report");
        ddl = rs.getString("ddl");
        out.println(
        		"<tr>" +
        		"<td>" + id + "</td>" +
                "<td>" + title + "</td>" +
                "<td>" + grade + "</td>" +
                "<td>" + gender + "</td>" +
                "<td>" + photo + "</td>" +
                "<td>" + report + "</td>" +
                "<td name=\"ddls\">" + ddl + "</td>" +
                "<td><input type=\"radio\" name=\"file_select\"></td>" +
                "</tr>"
        );
    }
%>