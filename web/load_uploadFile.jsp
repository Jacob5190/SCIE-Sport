<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2019/12/14
  Time: 21:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    int id;
    String url, user, password, f1_format, f2_format, f3_format, f4_format;
    boolean f1, f2, f3, f4;
%>
<%
    id = Integer.parseInt(request.getParameter("id"));
    url = "jdbc:mysql://127.0.0.1:3306/SCIESport?user=root&serverTimezone=Hongkong";
    user = "root";
    password = "Aa*20021122";
    String query = "select * from files where id=" + id;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    try(Connection conn = DriverManager.getConnection(url, user, password);){
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery(query);
        rs.next();
        f1 = rs.getBoolean("file_1");
        if (f1) f1_format = rs.getString("f1_format");
        f2 = rs.getBoolean("file_2");
        if (f2) f2_format = rs.getString("f2_format");
        f3 = rs.getBoolean("file_3");
        if (f3) f3_format = rs.getString("f3_format");
        f4 = rs.getBoolean("file_4");
        if (f4) f4_format = rs.getString("f4_format");
    } catch (SQLException e){
        out.println(e.getMessage());
    }
    PrintWriter pw = response.getWriter();
    if(!f1){
    	pw.println("<div id=\"upload_f1\" class=\"upload\" style=\"float: left\" >\n" +
                "        <span class=\"title\">Report</span><br />\n" +
                "        <label class=\"input_button\" for=\"input_f1\"><img src=\"resources/shangchuan1.svg\" alt=\"上传\" ></label><br />\n" +
                "        <input type=\"file\" id=\"input_f1\" accept=\".docx\" style=\"position:absolute;clip:rect(0 0 0 0);\">\n" +
                "        <div class=\"bar_wrap\"><div class=\"progress_bar\" id=\"bar_1\"></div></div>\n" +
                "        <button type=\"button\" id=\"f1_upload_button\" onclick=\"upload(1)\" class=\"btn\">Upload</button>\n" +
                "    </div>");
    }
    else{
        pw.println("<div id=\"file_f1\" class=\"download\" style=\"float: left\" >\n" +
                "        <span class=\"title\">Report "+ id +"</span><br />\n" +
                "        <a href=\"files/report/report" + id + f1_format + "\" id=\"download_f1\">" +
                "        <img src=\"resources/Shapecopy.svg\" alt=\"文件\" class=\"file_pic\"></a><br />\n" +
                "        <button id=\"f1_delete_button\" class=\"btn\" onclick=\"del(1)\">Delete</button>\n" +
                "    </div>");
    }
    pw.flush();
    if(!f2){
        pw.println("<div id=\"upload_f2\" class=\"upload\" style=\"float: right\" >\n" +
                "        <span class=\"title\">Raw video</span><br />\n" +
                "        <label class=\"input_button\" for=\"input_f2\"><img src=\"resources/shangchuan1.svg\" alt=\"上传\"></label><br />\n" +
                "        <input type=\"file\" id=\"input_f2\" style=\"position:absolute;clip:rect(0 0 0 0);\">\n" +
                "        <div class=\"bar_wrap\"><div class=\"progress_bar\" id=\"bar_2\"></div></div>\n" +
                "        <button type=\"button\" id=\"f2_upload_button\" onclick=\"upload(2)\" class=\"btn\">Upload</button>\n" +
                "    </div>");
    }
    else{
        pw.println("<div id=\"file_f2\" class=\"download\" style=\"float: right\" >\n" +
                "        <span class=\"title\">Raw video "+ id +"</span><br />\n" +
                "        <a href=\"files/r_video/r_video" + id + f2_format + "\" id=\"download_f2\">" +
                "        <img src=\"resources/Shapecopy.svg\" alt=\"文件\" class=\"file_pic\"></a><br />\n" +
                "        <button id=\"f2_delete_button\" class=\"btn\" onclick=\"del(2)\">Delete</button>\n" +
                "    </div>");
    }
    pw.flush();
    if(!f3){
        pw.println("<div id=\"upload_f3\" class=\"upload\" style=\"float: left\" >\n" +
                "        <span class=\"title\">Edited video</span><br />\n" +
                "        <label class=\"input_button\" for=\"input_f3\"><img src=\"resources/shangchuan1.svg\" alt=\"上传\"></label><br />\n" +
                "        <input type=\"file\" id=\"input_f3\" style=\"position:absolute;clip:rect(0 0 0 0);\">\n" +
                "        <div class=\"bar_wrap\"><div class=\"progress_bar\" id=\"bar_3\"></div></div>\n" +
                "        <button type=\"button\" id=\"f3_upload_button\" onclick=\"upload(3)\" class=\"btn\">Upload</button>\n" +
                "    </div>");
    }
    else{
        pw.println("<div id=\"file_f3\" class=\"download\" style=\"float: left\" >\n" +
                "        <span class=\"title\">Edited video "+ id +"</span><br />\n" +
                "        <a href=\"files/e_video/e_video" + id + f3_format + "\" id=\"download_f3\">" +
                "        <img src=\"resources/Shapecopy.svg\" alt=\"文件\" class=\"file_pic\"></a><br />\n" +
                "        <button id=\"f3_delete_button\" class=\"btn\" onclick=\"del(3)\">Delete</button>\n" +
                "    </div>");
    }
    pw.flush();
    if(!f4){
        pw.println("<div id=\"upload_f4\" class=\"upload\" style=\"float: right\" >\n" +
                "        <span class=\"title\">GIF file</span><br />\n" +
                "        <label class=\"input_button\" for=\"input_f4\"><img src=\"resources/shangchuan1.svg\" alt=\"上传\"></label><br />\n" +
                "        <input type=\"file\" id=\"input_f4\" accept=\".gif\" style=\"position:absolute;clip:rect(0 0 0 0);\">\n" +
                "        <div class=\"bar_wrap\"><div class=\"progress_bar\" id=\"bar_4\"></div></div>\n" +
                "        <button type=\"button\" id=\"f4_upload_button\" onclick=\"upload(4)\" class=\"btn\">Upload</button>\n" +
                "   </div>");
    }
    else{
        pw.println("<div id=\"file_f4\" class=\"download\" style=\"float: right\" >\n" +
                "        <span class=\"title\">GIF file "+ id +"</span><br />\n" +
                "        <a href=\"files/g_file/g_file" + id + f4_format + "\" id=\"download_f4\">" +
                "        <img src=\"resources/Shapecopy.svg\" alt=\"文件\" class=\"file_pic\"></a><br />\n" +
                "        <button id=\"f4_delete_button\" class=\"btn\" onclick=\"del(4)\">Delete</button>\n" +
                "    </div>");
    }
    pw.flush();
    pw.close();
%>