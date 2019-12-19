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
    <script src="jquery-3.4.1.min.js"></script>
    <style>
        body{
            width: 99%;
            height: auto;
            background-color: #eeeeee;
            min-height: 550px;
        }
        div#box{
            height: auto;
            width: auto;
            margin: 0 auto;
            min-width: 1000px;
            max-width: 1500px;
        }
        div#top{
            height: 10%;
            width: auto;
            border-radius: 10px;
            background-color: #149bdf;
        }
        div.upload, div.download{
            padding: 20px 0 10px 0;
            background-color: #cfcfcf;
            margin: 10px auto;
            width: 45%;
            height: 45%;
            border-radius: 5px;
        }
        img{
            width: 40%;
            height: 40%;
            margin: 10px;
        }
        .title{
            font-size: 18px;
        }
        .btn{
            width: 40%;
            background-color: #4CAF50;
            color: white;
            padding: 12px 18px;
            margin: 25px 0 0 0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover{
            background-color: #45a049;
        }
        .input_button{
            cursor: pointer;
        }
        .bar_wrap{
            width: 80%;
            height: 4%;
            background-color: #dddddd;
            overflow: hidden;
            border-radius: 50px;
            padding: 4px 7px;
            margin: 0 auto;
        }
        .progress_bar{
            height: 100%;
            width: 0;
            border-radius: 40px;
            background-color: #00aa00;
        }
    </style>
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
            if (file == null){
                alert("Please select a file!");
                return;
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
                complete: function () {
                    $.ajax({
                        url: ("load_uploadFile.jsp?id=" + id),
                        success: function (data) {
                            $("#main").html(data);
                        }
                    });
                },
                xhr: xhrOnProgress(function (e) {
                    var percent = 100 * (e.loaded / e.total);
                    $("#bar_" + identifier).css({width: (percent + "%")});
                    console.log(percent + "%");
                })
            });
        }
    </script>
    <script>
        function del(identifier){
            if(!confirm("Are you sure to delete this file?")){
                return;
            }
            $.ajax({
                url: "delete",
                type: "GET",
                data: {"id": id, "f_id": identifier},
                complete: function () {
                    $.ajax({
                        url: ("load_uploadFile.jsp?id=" + id),
                        success: function (data) {
                            $("#main").html(data);
                        }
                    });
                }
            })
        }
    </script>
    <script>
        var xhrOnProgress=function(fun) {
            xhrOnProgress.onprogress = fun;
            return function() {
                var xhr = $.ajaxSettings.xhr();
                if (typeof xhrOnProgress.onprogress !== 'function')
                    return xhr;
                if (xhrOnProgress.onprogress && xhr.upload) {
                    xhr.upload.onprogress = xhrOnProgress.onprogress;
                }
                return xhr;
            }
        }
    </script>
</head>
<body>
<div id="box">
    <%!
        int id;
    %>
    <%
        id = Integer.parseInt(request.getParameter("id"));
    %>
    <div id="top">

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
</div>
</body>
</html>
