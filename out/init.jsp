<%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2019/12/11
  Time: 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Task Management System</title>
</head>
<style>
    body{
        font-size: 16px;
        font-family: "Calibri" ,serif;
    }
    input[type=text], input[type=date] {
        width: 90%;
        padding: 8px 10px;
        margin: 10px 0;
        display: inline-block;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input {
        margin: 10px 0;
    }
    button {
        width: 90%;
        background-color: #4CAF50;
        color: white;
        padding: 14px 20px;
        margin: 8px 0;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    input[type=submit]:hover {
        background-color: #45a049;
    }
    div.upload {
        width: 200px;
        border-radius: 5px;
        background-color: #f2f2f2;
        padding: 20px;
        float: right;
    }
    hr {
        border-top: 3px dashed;
        color: darkgray;
    }
    div.radio {

    }
    #ret {
        border-radius: 5px;
        background-color: #f2f2f2;
        padding: 20px;
        float: left;
    }
    table{
        width: 100%;
        border-collapse: collapse;
    }
    table, tr, th, td{
        border: 1px solid darkgray;
    }
    td, th{
        font-size: 16px;
        vertical-align: center;
        height: 40px;
        width: 100px;
        padding: 3px 10px;
    }
    th{
        text-align: center;
        font-size: 18px;
    }
</style>
<body>
<script>
    //Initialize Ajax.
    var xmlhttp;
    if(window.XMLHttpRequest){
        xmlhttp=new XMLHttpRequest();
    }
    else{
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    //Upload the data onto the server.
    function upload() {
        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState==4 && xmlhttp.status==200)
            {
                //Returned data is written onto the table.
                newRow = document.createElement("tr");
                newRow.innerHTML = xmlhttp.responseText;
                document.getElementById("table_body").appendChild(newRow);
            }
        };
        //Identify the next id to be used.
        var id_t = document.getElementById("table_body").lastElementChild;
        var id;
        if(id_t == null){
            id = 1;
        }else{
            id = parseInt(id_t.firstElementChild.innerHTML) + 1;
        }
        //Obtain the data values on the input textfields.
        var title = document.getElementById("title").value;
        var grade = getRadioVal("grade");
        var gender = getRadioVal("gender");
        var photo = document.getElementById("photo").value;
        var report = document.getElementById("report").value;
        var ddl = document.getElementById("ddl").value;
        if (title == "" || grade == null || gender == null || photo == "" || report == "" || ddl == ""){
            alert("Please complete the info.");
        }
        else {
            var str = "id=" + id + "&title=" + title + "&grade=" + grade
                + "&gender=" + gender + "&photo=" + photo
                + "&report=" + report + "&ddl=" + ddl;
            //Use ajax to upload the data onto the server.
            xmlhttp.open("GET", "respond.jsp?" + str, true);
            xmlhttp.send();
        }
    }

    //Obtain the value of the radio buttons.
    function getRadioVal(radioName){
        var radios = document.getElementsByName(radioName);
        for (var i = 0; i < radios.length; i++){
            if (radios[i].checked){
                return radios[i].value;
            }
        }
        return null;
    }

    //Go to the file upload page with file id.
    function uploadFile(){
        var row = document.getElementById("table_body").children;
        var id;
        for (var i = 0; i < row.length; i++){
            if (row[i].lastElementChild.lastElementChild.checked){
                id = row[i].firstElementChild.innerHTML;
            }
        }
        window.location.href = "uploadFile.jsp?id="+id;
    }


</script>
<div class="upload">
    <em><b>Title</b></em><br /><input type="text" id="title"><br /><hr />
    <div class="radio">
        <em><b>AL/GL</b></em><br />
        GL <input type="radio" name="grade" value="GL"><br />
        AL <input type="radio" name="grade" value="AL"><br />
        N/A <input type="radio" name="grade" value="N/A"><br /><hr />
    </div>
    <div class="radio">
        <em><b>B/G</b></em><br />
        BOY <input type="radio" name="gender" value="B"><br />
        GIRL <input type="radio" name="gender" value="G"><br />
        N/A <input type="radio" name="gender" value="N/A"><br /><hr />
    </div>
    <em><b>Photo</b></em><br /><input type="text" id="photo"><br /><hr />
    <em><b>Report</b></em><br /><input type="text" id="report"><br /><hr />
    <em><b>DDL</b></em><br /><input type="date" id="ddl"><br /><hr />
    <button onclick="upload()">Submit</button>
</div>
<div id="ret">
    <table id="info">
        <thead>
            <tr id="headRow">
                <th>No.</th>
                <th>Title</th>
                <th>Grade</th>
                <th>Gender</th>
                <th>Photo</th>
                <th>Report</th>
                <th>DDL</th>
                <th>Select</th>
            </tr>
        </thead>
        <tbody id="table_body">
        <%!int id; String url, user, password, title, grade, gender, photo, report, ddl;%>
        <%
            //initialize links to database
            url = "jdbc:mysql://127.0.0.1:3306/scie_sport?user=root&serverTimezone=Hongkong";
            user = "root";
            password = "admin";
            String query = "select * from task;";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            try(Connection conn = DriverManager.getConnection(url, user, password);){
                Statement stm = conn.createStatement();
                ResultSet rs = stm.executeQuery(query);
                while(rs != null && rs.next()){
                	id = rs.getInt("id");
                	title = rs.getString("title");
                	grade = rs.getString("grade");
                	gender = rs.getString("gender");
                	photo = rs.getString("photo");
                	report = rs.getString("report");
                	ddl = rs.getString("ddl");
                	if(title == null) continue;
                	//Obtain data from database and show the data.
                	out.println("<tr>");
                	out.println("<td>"+ id +"</td>");
                    out.println("<td>"+ title +"</td>");
                    out.println("<td>"+ grade +"</td>");
                    out.println("<td>"+ gender +"</td>");
                    out.println("<td>"+ photo +"</td>");
                    out.println("<td>"+ report +"</td>");
                    out.println("<td>"+ ddl +"</td>");
                    out.println("<td><input type=\"radio\" name=\"file_select\"></td>");
                    out.println("</tr>");
                }
            } catch (SQLException e){
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
    <button onclick="uploadFile()">Upload Files</button>
</div>
</body>
</html>
