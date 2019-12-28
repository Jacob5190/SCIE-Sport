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
</head>
<body>
<div>
    Delete task: <select name="id" id="select"></select>
    Confirm code: <input type="password" id="password">
    <button onclick="del()">Confirm</button>
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
