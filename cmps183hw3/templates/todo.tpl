<!DOCTYPE html>
<html>

<head>
<title>CMPS183 Homework 2</title>

<style>
#welcome {
        background-color: #0000DD;
        border-radius: 5px;
        height: 50px;
}

#welcomeText {
        position: relative;
        left: 10px;
        top: 32%;
        color: white;
}

.header {
        font-size: 18px;

}


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

nav {
    display: flex;
    justify-content: center;
    margin: 0 auto;
    padding: 1em;
}

nav ul {
    list-style-type: none;
    padding: 0;
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
  <a href="https://www.w3schools.com/jsref/event_onclick.asp">Buttons</a>
  <a href="https://www.w3schools.com/howto/howto_js_display_checkbox_text.asp">Checkboxes</a>
  <a href="https://stackoverflow.com/questions/13299024/hiding-a-check-box-in-html">Hiding checkboxes</a>
  <a href="https://bottlepy.org/docs/dev/tutorial_app.html">Bottle Neck Tutorial</a>
</div>

<div class="container">

<span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; Sidebar</span>

<header>
   <h1>CMPS183: Homework 3</h1>
</header>

<nav>
        <a href="/index">Home</a>
        <a href="/todo">To Do List</a>
        <a href="/edit/1">To Do Form</a>
</nav>

%#template to generate a HTML table from a list of tuples (or list of lists, or tuple of tuples or ...)
<table id="tInput" cellpadding="10">
    <tr>
        <th class="header"><b>Task Number</b></th>
        <th class="header"><b>Task</b></th>
        <th class="header"><b>Notes</b></th>
        <th class="header"><b>Posted</b></th>
        <th class="header"><b>Due Date</b></th>
        <th class="header"><b>Date Modified</b></th>
        <th class="header"><b>Status</b></th>
        <th class="sorter">
            <select id="sort" name="sort">
                <option>Posted Date</option>
                <option>Last Updated</option>
                <option>Due Date</option>
            </select>
        </th>
        <th>
            <select id="ascending-or-descending" name="ascending-or-descending">
                <option>Ascending</option>
                <option>Descending</option>
            </select>
        </th>
        <th>
            <select id="showing" name="showing">
                <option>Show All</option>
                <option>Show Completed</option>
                <option>Show To Do</option>
            </select>

    </tr>
		<tr>
		%for row in rows:
		<button name="edit{{row[0]}}" value="Edit Row{{row[0]}}" onclick="editB({{row[0]}})">Edit {{row[0]}}</button>
		<button name="delete{{row[0]}}" value="Delete Row{{row[0]}}" onclick="deleteB({{row[0]}})">Delete {{row[0]}}</button>
		 	<tr>
		  		%for col in row:
		  		%count+=1
		    	<td>
		    		{{col}}
		    		<!-- %if count % 7 == 0:
		    		<button>HELP</button> -->
		    	</td>

		  		%end
		  	</tr>
		%end
</table>
		</tr>
</table>


<p>Add a new task to the ToDo list:</p>
<form action="/new" method="GET">
  <input type="text" name="task" placeholder="Task Name">
  <input type="text" size="100" maxlength="50" name="notes" placeholder="Description">
  <text id="tDate" name="dateS" value = "toDate()">
  <input type="date" name="due">
  <input type="submit" name="save" value="save">
</form>


<footer>
  <li><a href="#">About Us</a></li>
  <li><a href="#">Contact</a></li>
  <li><a href="#">Privacy</a></li>
  <li><a href="#">Credits</a></li>
</footer>

<script type="text/javascript">

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

    function tDate() {
        var UserDate = document.getElementById("dateF").value;
        var UsDate = parseDate(UserDate);
        var uDate = UsDate.getTime();
        var ToDate = Date.now();

        if (uDate + 86399999 <= ToDate || uDate > 2528006400000) {
            alert("Invalid date")
            return false;
        }
        return true;
    }

    // parse a date in yyyy-mm-dd format
    function parseDate(i) {
        var parts = i.match(/(\d+)/g);
        // new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
        return new Date(parts[0], parts[1]-1, parts[2]); // months are 0-based
    }


	function openNav() {
	    document.getElementById("mySidenav").style.width = "250px";
	}

	function closeNav() {
	    document.getElementById("mySidenav").style.width = "0";
	}

	function editB(id){
		window.location.href = "/edit/" + id;
		console.log("A")
	}

	function deleteB(id){
		window.location.href = "/delete/" + id;
		console.log("b")
	}


</script>   


</body>
</html>