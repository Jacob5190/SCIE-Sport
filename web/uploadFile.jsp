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
        body{
            min-height: 550px;
            background-color: #222222;
        }
        div#box{
            min-width: 1000px;
        }
        div.bar_wrap{
            width: 70%;
            height: 3%;
            margin: 5px auto;
            background-color: #eeeeee;
            border-radius: 40px;
            padding: 5px 8px;
        }
        div.progress_bar{
            height: 100%;
            background-color: #00aa00;
            border-radius: 45px;
            width: 0;
        }
        div.upload, div.download{
            padding: 10px 0 0 0;
            background-color: #cccccc;
            margin: 15px auto;
            width: 47%;
            height: 50%;
            border-radius: 7px;
        }
        img{
            width: 40%;
            height: 45%;
            margin: 10px 0 0 0;
        }
        img.file_pic{
            margin: 15px 0;
        }
        .input_button{
            cursor: pointer;
        }
        span.title{
            margin: 15px;
            padding: 15px;
            font-size: 18px;
        }
        .btn{
            width: 60%;
            background-color: #4CAF50;
            color: white;
            padding: 12px 18px;
            margin: 8px 0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            bottom: 10px;
        }
        .btn:hover{
            background-color: #45a049;
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
            var format, fileName, file, upload_status=false;
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
                alert("Please select a file.\n(Click on the picture to select files)");
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
                    upload_status = true;
                },
                error: function (response) {
                    console.log(response);
                    upload_status = false;
                },
                complete: function () {
                    if (upload_status) {
                        $.ajax({
                            url: "load_uploadFile.jsp",
                            data: {id: id},
                            success: function (resp) {
                                $("#main").html(resp);
                                alert("File upload successfully.");
                            }
                        });
                    }else{
                        alert("An unknown error has occurred during file upload process.");
                    }
                },
                xhr: xhrOnProgress(function (e) {
                    var percent = Math.floor(e.loaded / e.total * 100) + "%";
                    $("#bar_"+identifier).css({width: percent});
                })
            });
        }
    </script>
    <script>
        function del(identifier){
            if (!confirm("Are you sure to delete this file?"))return;
            $.ajax({
                url: "delete",
                type: "GET",
                data: {id : id, fId : identifier},
                success: function () {
                    $.ajax({
                        url: "load_uploadFile.jsp",
                        type: "GET",
                        data: {id: id},
                        success: function (resp) {
                            $("#main").html(resp);
                            alert("File delete successfully.");
                        }
                    });
                }
            });
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
<%!
    int id;
%>
<%
    id = Integer.parseInt(request.getParameter("id"));
%>
<div id="box">
    <div id="main" style="text-align: center; width: 50%; height: 80%; margin: auto">
    </div>
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
