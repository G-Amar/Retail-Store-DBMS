<head>
	<title>Clothing Retail DBMS</title>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<link rel="icon" type="image/x-icon" href="./favicon.ico">
</head>
<body style="margin-left:1.5%;font-family:cursive">
<h3>Clothing Retail DBMS</h2>
<h6>Database Administrators: Amar Gupta, Sudipto Bose, and Cedric Li-Chay-Chung</h6><br>

<h4>Table Functions:</h4>
<small>(You can print table(s), delete table(s), and create/populate tables)</small>
<br><br>
<form action="" method="post">
	<label>Select Action: &nbsp</label>
	<select name="action"/>
		<option value="NOTHING">Nothing</option>
		<option value="PRINT">Print</option>
        	<option value="DELETE">Delete</option>
		<option value="CREATE">Create Tables</option>
		<option value="POPULATE">Populate Tables</option>
    	</select>

	<label>&nbsp&nbspSelect Table: &nbsp</label>
	<select name="table"/>
        	<option value="ALL">All Tables</option>
		<option value="SUPPLIER">SUPPLIER</option>
        	<option value="STORE">STORE</option>
        	<option value="SHIPMENT">SHIPMENT</option>
        	<option value="SALE">SALE</option>
        	<option value="PRODUCT_IN_SALE">PRODUCT_IN_SALE</option>
        	<option value="PRODUCT">PRODUCT</option>
        	<option value="MANAGER">MANAGER</option>
        	<option value="EMPLOYEE">EMPLOYEE</option>
        	<option value="DEPARTMENT">DEPARTMENT</option>
        	<option value="CUSTOMER">CUSTOMER</option>
        	<option value="CASHIER">CASHIER</option>
    	</select>&nbsp
	<input type="submit" class="btn btn-outline-success" value="Submit">
</form>


<h4>Record Functions:</h4>
<small>(You can search for a record, update a record, and delete a record) Note: single quotes are required for comparison or assignment strings, and semicolons should not be added.</small>
<br><br>
<form action="" method="post">
	<input type="hidden" name="action" value="SELECT">
	SELECT <input type="text" name="columns" placeholder="a, b...">
	FROM <input type="text" name="table" placeholder="table1, table2...">
	WHERE <input type="text" name="conditions" placeholder="column1='b' AND column2=2...">

	<input type="submit" class="btn btn-outline-primary" value="Submit">
</form>

<form action="" method="post">
	<input type="hidden" name="action" value="UPDATE">
	UPDATE <input type="text" name="table" placeholder="table name">
	SET <input type="text" name="assignments" placeholder="column1='c', column2=3...">
	WHERE <input type="text" name="conditions" placeholder="column1='b' AND column2=2...">

	<input type="submit" class="btn btn-outline-info" value="Submit">
</form>

<form action="" method="post">
	<input type="hidden" name="action" value="DELETE_REC">
	DELETE FROM <input type="text" name="table" placeholder="table name">
	WHERE <input type="text" name="conditions" placeholder="column1='b' AND column2=2...">
	<input type="submit" class="btn btn-outline-danger" value="Submit">
</form>

<form action="" method="post" id="longform">
	<label>Enter a long query: </label>
	<input type="hidden" name="action" value="LONG_QUERY">
	<input type="submit" class="btn btn-outline-primary" value="Submit">
</form>

<textarea rows="5" cols="90" name="longquery" form="longform" placeholder="Some long query...(omit semicolon)"></textarea> <br><br><br>

</body>



<?php 

$tables = array("SUPPLIER", "STORE", "SHIPMENT", "SALE", "PRODUCT_IN_SALE", "PRODUCT", "MANAGER", "EMPLOYEE", "DEPARTMENT", "CUSTOMER", "CASHIER");

#### Requirements

require './clothingRetailFunctions.php';

$conn = oci_connect('', '', '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))');
if (!$conn) {
$m = oci_error();
echo $m['message'];
}

#### Functions

function dropAllTables($tables, $conn) {
	foreach ($tables as $t) {
		dropTable($t, $conn);
	}
}

function printAllTables($tables, $conn) {
	foreach ($tables as $t) {
		printTable($t, $conn);
	}
}

#### Body
$action = $_POST["action"];
$table = $_POST["table"];
$columns = $_POST["columns"];
$conditions = $_POST["conditions"];
$assignments = $_POST["assignments"];
$longQuery = $_POST["longquery"];

// default for where clause
if (empty($conditions)) {
	$conditions = "1=1";
}


if (strcmp($action, "PRINT") === 0) {
	echo "<b>Action:</b> $action";
	echo "&nbsp <b>Table:</b> $table";
	echo "<br><br><br>";

	if (strcmp($table, "ALL") === 0) {
		printAllTables($tables, $conn);
	} else {
		printTable($table, $conn);
	}
} 

elseif (strcmp($action, "DELETE") === 0) {
	echo "<b>Action:</b> $action";
	echo "&nbsp <b>Table:</b> $table";
	echo "<br><br><br>";

	if (strcmp($table, "ALL") === 0) {
		dropAllTables($tables, $conn);
	} else {
		dropTable($table, $conn);
	}

}

elseif (strcmp($action, "CREATE") === 0) {
	echo "<b>Action:</b> CREATE TABLES";
	echo "<br><br><br>";

	createTables($conn);
}

elseif (strcmp($action, "POPULATE") === 0) {
	echo "<b>Action:</b> POPULATE TABLES";
	echo "<br><br><br>";

	populateTables($conn);
} 

elseif (strcmp($action, "SELECT") === 0) {
	echo "<b>Action:</b> $action";
	echo "&nbsp <b>Columns:</b> $columns";
	echo "&nbsp <b>Table:</b> $table";
	echo "&nbsp <b>Conditions:</b> $conditions";
	echo "<br><br><br>";

	queryDatabase($table, $columns, $conditions, $conn);
}

elseif (strcmp($action, "UPDATE") === 0) {
	echo "<b>Action:</b> $action";
	echo "&nbsp <b>Table:</b> $table";
	echo "&nbsp <b>Assignments:</b> $assignments";
	echo "&nbsp <b>Conditions:</b> $conditions";
	echo "<br><br><br>";

	updateDatabase($table, $assignments, $conditions, $conn);

}

elseif (strcmp($action, "DELETE_REC") === 0) {
	echo "<b>Action:</b> $action";
	echo "&nbsp <b>Table:</b> $table";
	echo "&nbsp <b>Conditions:</b> $conditions";
	echo "<br><br><br>";

	deleteRecord($table, $conditions, $conn);

}

elseif (strcmp($action, "LONG_QUERY") === 0) {
	echo "<b>Action:</b> $action";
	echo "&nbsp <b>Query:</b> $longQuery";
	echo "<br><br><br>";

	longQuery($longQuery, $conn);

}


?>
