<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%!
    int id;
    String title, grade, gender, photo, report, ddl, url, user, password;
%>
<%
    //Obtain the data sent from clients
    id = Integer.parseInt(request.getParameter("id"));
    title = request.getParameter("title");
    grade = request.getParameter("grade");
    gender = request.getParameter("gender");
    photo = request.getParameter("photo");
    report = request.getParameter("report");
    ddl = request.getParameter("ddl");
%>
<td><%=id%></td>
<td><%=title%></td>
<td><%=grade%></td>
<td><%=gender%></td>
<td><%=photo%></td>
<td><%=report%></td>
<td><%=ddl%></td>
<td><input type="radio" name="file_select"></td>
<%
    url = "jdbc:mysql://127.0.0.1:3306/SCIESport?user=root&serverTimezone=Hongkong";
    user = "root";
    password = "Aa*20021122";
    //Format the query statement to inset the data
    String query =
            String.format(
            		"insert into task(id, title, grade, gender, photo, report, ddl) " +
                    "values(%d, \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\");",
                    id, title, grade, gender, photo, report, ddl);
    String query1 = "insert into files(id) values(" + id + ");";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    try(Connection conn = DriverManager.getConnection(url, user, password);){
        Statement stm = conn.createStatement();
        //Execute query and update the database
        stm.executeUpdate(query);
        stm.executeUpdate(query1);
    } catch (SQLException e){
        out.println(e.getMessage());
    }
%>