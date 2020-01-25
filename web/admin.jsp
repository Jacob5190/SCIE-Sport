<%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2019/12/26
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin page</title>
    <link rel="icon" href="resources/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="resources/favicon.ico" type="image/x-icon"/>
    <script src="jquery-3.4.1.min.js"></script>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="resources/js/bootstrap.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand navbar-light bg-light">
    <a class="navbar-brand" href="#">任务管理系统</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarContent">
        <ul class="navbar-nav mr-auto">
            <li class="active"><a class="nav-link" href="http://111.230.183.9:8080">主页</a></li>
            <li><a class="nav-link" href="#">管理员页面</a></li>
            <li><a class="nav-link" href="http://111.230.183.9">视频转GIF</a></li>
        </ul>
    </div>
</nav>
<div class="container-fluid bg-light" style="padding: 20px; border-radius: 5px; margin: 5px;">
    <div class="input-group mb-3">
        <div class="input-group-prepend">
            <span class="input-group-text">Task ID</span>
        </div>
        <select name="id" class="form-control" id="select" aria-label="Task ID" aria-describedby="The task id of the delete task"></select>
    </div>
    <div class="input-group mb-3">
        <div class="input-group-prepend">
            <span class="input-group-text">Confirm Code</span>
        </div>
        <input type="password" id="password" class="form-control" aria-label="Code" aria-describedby="The confirm code of task delete">
    </div>
    <button class="btn btn-warning" onclick="del()">Delete</button>
</div>
<script src="jquery-3.4.1.min.js"></script>
<script>
    function del() {
        var id = $("select[name='id']").val();
        var password = $("#password").val();
        var link = "admin";
        if (id == "null"){alert("Please select a task id.");return;}
        if (!confirm("Delete task id:" + id + "? This deletion is irreversible.")) {return;}
        $.get("admin", {ID: id, PW: password}, function (responseText, textStatus) {
            if(textStatus == "success") {
                if (responseText != 0){
                    alert("Confirm code incorrect!");
                }else {
                    alert("Task delete successfully.");
                    location.reload();
                }
            }
            if(textStatus == "error") {
                alert("An unknown error occurs, please try again later.");
            }
        }, "text");
    }
</script>
<script>
    $("#select").load("load_id.jsp");
</script>
</body>
</html>
