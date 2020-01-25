<%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2019/12/11
  Time: 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <link rel="icon" href="resources/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="resources/favicon.ico" type="image/x-icon"/>
    <meta charset="UTF-8">
    <title>Task Management System</title>
</head>
<style>
    b{
        font-size: 18px;
    }
    body{
        font-size: 16px;
        font-family: "Calibri" ,serif;
        min-width: 1280px;
        background-color: #222222;
    }
    input[type=text], input[type=date] {
        width: 90%;
        padding: 8px 10px;
        margin: 10px 0;
        display: inline-block;
        border: 2px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }
    input {
        margin: 10px 3px;
    }
    button {
        width: 90%;
        background-color: #4CAF50;
        color: white;
        padding: 14px 20px;
        margin: 8px 3px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    button:hover {
        background-color: #46a14a;
    }
    div.upload {
        margin: 10px;
        width: 180px;
        border-radius: 5px;
        background-color: #f2f2f2;
        padding: 20px;
        float: right;
    }
    hr {
        border-top: 3px dashed;
        color: darkgray;
    }
    #ret {
        margin: 10px;
        width: auto;
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
        border: 2px solid darkgray;
    }
    td, th{
        font-size: 16px;
        vertical-align: center;
        height: 40px;
        width: 100px;
        padding: 3px 10px;
        white-space: nowrap;
    }
    th{
        text-align: center;
        font-size: 18px;
    }
</style>
<body>
<script src="jquery-3.4.1.min.js"></script>
<script>
    function upload() {
        //Identify the next id to be used.
        var id_t = document.getElementById("table_body").lastElementChild;
        var id;
        if(id_t == null){
            id = 1;
        }else{
            id = parseInt(id_t.firstElementChild.innerHTML) + 1;
        }
        //Obtain the data values on the input text fields.
        var title = document.getElementById("title").value;
        var grade = getRadioVal("grade");
        var gender = getRadioVal("gender");
        var photo = document.getElementById("photo").value;
        var report = document.getElementById("report").value;
        var ddl = document.getElementById("ddl").value;
        if (title == "" || grade == null || gender == null || photo == "" || report == "" || ddl == ""){
            alert("Please complete the table.");
        }
        else {
            //Upload the data onto the server.
            $.ajax({
                url: "createTask",
                data: {
                    id : id,
                    title : title,
                    grade : grade,
                    gender : gender,
                    photo : photo,
                    report : report,
                    ddl : ddl
                },
                method: "GET",
                //If success, reload the table with new data.
                success: function (responseText) {
                    if (responseText == 0){
                        $("#table_body").load("load_task.jsp", function () {
                            checkDDL();
                        });
                    }else {
                        alert("Error occurs");
                    }
                    $("#info_form")[0].reset();
                }
            })
        }
    }
    //Check if the deadline is reached and change the color of the corresponding table cells.
    function checkDDL() {
        var now = new Date();
        var ddl;
        $("td[name='ddls']").each(function (){
            ddl = new Date(Date.parse($(this).text()));
            if (now > ddl){
                $(this).css("background-color", "#E34C4C");
            } else if(parseInt(Math.abs(ddl - now) / 1000 / 60 / 60 /24) < 3){
                $(this).css("background-color", "#FFC31F");
            }
        })
    }

    //Obtain the value of the radio buttons.
    function getRadioVal(radioName){
        var val = $("input[name="+radioName+"]:checked").val();
        if (val != null && val != ""){
            return val;
        }else {
            return null;
        }
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
        if(id == null){
            alert("Please select a task for file upload.");
            return;
        }
        window.location.href = "uploadFile.jsp?id="+id;
    }
</script>
<script>
    //Load the page while checking the deadlines.
    $(function () {
        $("#table_body").load("load_task.jsp", function () {
            checkDDL();
        });
    })
</script>
<div class="upload" id="main">
    <form id="info_form">
    <em><b>Title</b></em><br /><input type="text" id="title"><br /><hr />
    <div class="radio">
        <em><b>AL/GL</b></em><br />
        GL <input type="radio" name="grade" value="GL"><br />
        AL <input type="radio" name="grade" value="AL"><br />
        N/A <input type="radio" name="grade" value="N/A"><br /><hr />
    </div>
    <div class="radio">
        <em><b>B/G</b></em><br />
        BOY <input type="radio" name="gender" value="B" class="radios"><br />
        GIRL <input type="radio" name="gender" value="G" class="radios"><br />
        N/A <input type="radio" name="gender" value="N/A" class="radios"><br /><hr />
    </div>
    <em><b>Photographer</b></em><br /><input type="text" id="photo" class="radios"><br /><hr />
    <em><b>Reporter</b></em><br /><input type="text" id="report" class="radios"><br /><hr />
    <em><b>Deadline</b></em><br /><input type="date" id="ddl" class="radios"><br /><hr />
    </form>
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
                <th>Photographer</th>
                <th>Reporter</th>
                <th>Deadline</th>
                <th>Select</th>
            </tr>
        </thead>
        <tbody id="table_body">
        </tbody>
    </table>
    <button onclick="uploadFile()">Upload Files</button>
</div>
</body>
</html>
