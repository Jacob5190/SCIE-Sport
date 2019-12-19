<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2019/12/11
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>File Upload Page</title>
    <style>
        div.upload, div.download{
            padding: 10px;
            background-color: #cccccc;
            margin: 10px 0;
            width: 45%;
            height: 45%;
            border-style: dot-dash;
            border-color: greenyellow;
            border-width: 5px;
            border-radius: 5px;
        }
        img{
            width: 40%;
            margin: 10px;
        }
        span.title{
            margin: 15px;
            padding: 15px;
            font-size: 18px;
        }
    </style>
    <script src="jquery-3.4.1.min.js"></script>
    <script>
        if(window.XMLHttpRequest){
            var xmlhttp=new XMLHttpRequest();
        }
        else{
            var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
    </script>
    <script>
        function upload(identifier) {
            var format, fileName, file;
            var formData = new FormData();
            if(identifier == 1) {
                file = document.getElementById("input_f1").files[0];
                fileName = "report";
            }
            else if(identifier == 2) {
                file = document.getElementById("input_f2").files[0];
                fileName = "r_video";
            }
            else if(identifier == 3) {
                file = document.getElementById("input_f3").files[0];
                fileName = "e_video";
            }
            else if(identifier == 4) {
                file = document.getElementById("input_f4").files[0];
                fileName = "g_file";
            }
            format = file.name.substring(file.name.lastIndexOf("."));
            fileName = fileName + id + format;
            formData.append("identifier", identifier);
            formData.append("fileName", fileName);
            formData.append("file", file);
            $.ajax({
                url: "receive",
                type: "POST",
                data: formData,
                dataType: "text",
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    console.log(data);
                },
                error: function (response) {
                    console.log(response);
                },
                /*
                xhr: function () {
                    Xhr = $.ajaxSettings.xhr();
                    if(Xhr.upload){
                        Xhr.upload.addEventListener("progress", progressHandling, false);
                    }
                    return Xhr;
                }*/
            });
        }
    </script>
</head>
<body>
<%!
    int id;
%>
<%
    id = Integer.parseInt(request.getParameter("id"));
%>
<div id="top" style="height: 10%">
    <p>Some tool bars and some titles...</p>
</div>
<div id="main" style="text-align: center; width: 50%; height: 80%; margin: auto">
</div>
<script>
    xmlhttp.onreadystatechange=function () {
        if(xmlhttp.readyState==4 && xmlhttp.status==200){
            document.getElementById("main").innerHTML = xmlhttp.responseText;
        }
    };
    var id = <%=id%>;
    xmlhttp.open("GET", "load_uploadFile.jsp?id="+id,true);
    xmlhttp.send();
</script>
</body>
</html>
