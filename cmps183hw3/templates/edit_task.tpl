<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>

.sidenav {
    height: 100%;
    width: 0;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    background-color: #111;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 60px;
}

.sidenav a {
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    font-size: 25px;
    color: #818181;
    display: block;
    transition: 0.3s;
}

.sidenav a:hover {
    color: #f1f1f1;
}

.sidenav .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 50px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}

div.container {
    width: 100%;
    border: 1px solid gray;
}


table {
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

header, footer {
    position:relative;
    display:block;
    max-width:100%;
    height:100%;
    margin:0 auto;
    padding:1rem 5rem;
    background:black;
    color:#fff;
    text-align: center;
    list-style-type: none;
}

header h1{
    line-height: 45px;
    font-size: 2rem;
    margin: 0;
    display:inline;
}

article {
    margin-left: auto;
    margin-right: auto;
    padding: 1em;
    overflow: hidden;
}

</style>
</head>
<body>

<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="https://www.w3schools.com/howto/howto_js_sidenav.asp">Sidebar Tutorial</a>
  <a href="https://www.w3schools.com/w3css/w3css_containers.asp">Container for header and footer</a>
  <a href="https://www.w3schools.com/js/js_date_formats.asp">Date format</a>
  <a href="#">Based off an example the professor showed in class</a>
  <a href="https://stackoverflow.com/questions/492994/compare-two-dates-with-javascript">Check date</a>
  <a href="https://www.w3schools.com/html/html_tables.asp">Tables</a>
  <a href="https://www.w3schools.com/html/html5_webstorage.asp">Web Storage</a>
  <a href="https://bottlepy.org/docs/dev/tutorial_app.html">Bottle Neck Tutorial</a>
</div>


<div class="container">

<span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; Sidebar</span>
<title>CMPS183 Homework 3</title>
<header>
   <h1>CMPS183: Homework 3</h1>
</header>

<nav>
        <a href="/index">Home</a>
        <a href="/todo">To Do List</a>
        <a href="/edit/1">To Do Form</a>
</nav>

<body>

%#template for editing a task
%#the template expects to receive a value for "no" as well a "old", the text of the selected ToDo item
<p>Edit the task with ID = {{no}}</p>
<form action="/edit/{{no}}" method="get">
  <input type="text" name="task" value="{{tasks[0]}}" size="50" maxlength="100">
  <input type="text" name="notes" value="{{notess[0]}}" size="50" maxlength="100">
  <input type="text" name="posted" value="{{posteds[0]}}" readonly>
  <input type="date" name="due" value="{{duess[0]}}">
  <input type="text" name="modified" value = "{{mdate[0]}}" readonly>

  <select name="status">
    <option>Done</option>
    <option>In Progress</option>
  </select>
  <br>
  <input type="submit" name="save" value="save">
</form>
<footer>
  <li><a href="#">About Us</a></li>
  <li><a href="#">Contact</a></li>
  <li><a href="#">Privacy</a></li>
  <li><a href="#">Credits</a></li>
</footer>

</div>

<script>
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
}

function TDate() {
    var UserDate = document.getElementById("iDate").value;
    var UsDate = parseDate(UserDate);
    var uDate = UsDate.getTime();

    var ToDate = Date.now();
    console.log(uDate);
    if (uDate + 86399999 <= ToDate || uDate > 2528006400000) {
        alert("Invalid date")
        return false;
    }
    alert("Valid date")
    return true;
}

// parse a date in yyyy-mm-dd format
function parseDate(input) {
  var parts = input.match(/(\d+)/g);
  // new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
  return new Date(parts[0], parts[1]-1, parts[2]); // months are 0-based
}

function toDate(){
        var today = new Date();
        var mm = today.getMonth() + 1;
        var dd = today.getDate();
        var yyyy = today.getFullYear();

        if(dd<10){
            dd='0'+dd;
        } 
        if(mm<10){
            mm='0'+mm;
        } 
        var today = yyyy+'/'+mm+'/'+dd;
        return today;
}

</script>
     
</body>
</html>