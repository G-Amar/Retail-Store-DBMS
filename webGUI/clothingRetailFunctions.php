<?php 

#### These functions are used in main website


// selects specific record(s)
function queryDatabase($table, $columns, $conditions, $conn) {
	$query = oci_parse($conn, "select $columns from $table where $conditions");
	oci_execute($query);
	displayQuery($query);
}


// updates specific record(s)
function updateDatabase($table, $assignments, $conditions, $conn) {
	$query = oci_parse($conn, "update $table set $assignments where $conditions");
	oci_execute($query, OCI_COMMIT_ON_SUCCESS);
	printTable(product, $conn);
}


// handles a long query
function longQuery($longQuery, $conn) {
	$query = oci_parse($conn, $longQuery);
	oci_execute($query, OCI_COMMIT_ON_SUCCESS);
	displayQuery($query);
}

// deletes specific record(s)
function deleteRecord($table, $conditions, $conn) {
	$query = oci_parse($conn, "delete from $table where $conditions");
	oci_execute($query, OCI_COMMIT_ON_SUCCESS);
	printTable($table, $conn);
}


// prints a table
function printTable($table, $conn) {
	echo "<p style=\"text-align:center;\"><big><b><u>TABLE: $table</b></u></big><br></p>";
	$query = oci_parse($conn, "select * from $table");
	oci_execute($query);
	displayQuery($query);
}


// display query
function displayQuery($query) {
	echo "<table style=\"text-align:center;\"class=\"table table-hover\">";
	$columns = oci_num_fields($query);
	echo "<thead><tr>";
	for ($i = 1; $i <= $columns ; ++$i) {
		$column = oci_field_name($query, $i);
		echo "<th scope=\"col\">$column</th>";
	}
	echo "</tr></thead><tbody>";
	while (($row = oci_fetch_assoc($query)) != false) {
		echo "<tr>";
		foreach ($row as $r) {
			echo "<td>$r</td>";
		}
		echo "</tr>";
	}
	echo "</tbody></table><br><br>";
}


// drops a table
function dropTable($table, $conn) {
	$query = oci_parse($conn, "drop table $table cascade constraints");
	oci_execute($query);
}


// populates tables from inserts.txt
function populateTables($conn){
	if ($file = fopen("inserts.txt", "r")) {
    		while(!feof($file)) {
        		$line = fgets($file);
        		$query = oci_parse($conn, $line);
			oci_execute($query);
    		}
    	fclose($file);
	}
}


// creates tables
function createTables($conn) {
	$query = oci_parse($conn, 'CREATE TABLE STORE (
    	STOREID INT PRIMARY KEY,
    	CITY VARCHAR2(30) NOT NULL,
    	STREET VARCHAR2(60),
    	ZIPCODE VARCHAR2(10),
    	UNIT_NUM INT)');
	oci_execute($query);

	$query = oci_parse($conn, 'CREATE TABLE SUPPLIER (
    	SUPPLIERID INT PRIMARY KEY,
    	SUPPLIER_NAME VARCHAR2(30) NOT NULL,
    	CITY VARCHAR2(30) NOT NULL)');
	oci_execute($query);

	$query = oci_parse($conn, 'CREATE TABLE CUSTOMER (
    	CUSTOMERID INT PRIMARY KEY,
    	CUSTOMER_NAME VARCHAR2(30))');
	oci_execute($query);

	$query = oci_parse($conn, 'CREATE TABLE EMPLOYEE (
    	EMPLOYEEID INT PRIMARY KEY,
    	EMPLOYEE_NAME VARCHAR2(30) NOT NULL,
    	EMPLOYEE_SALARY INT NOT NULL,
    	EMPLOYEE_DATE_OF_BIRTH DATE NOT NULL)');
	oci_execute($query);

	$query = oci_parse($conn, 'CREATE TABLE MANAGER (
    	EMPLOYEEID INT PRIMARY KEY REFERENCES EMPLOYEE(EMPLOYEEID) ON DELETE CASCADE)');
	oci_execute($query);

	$query = oci_parse($conn, 'CREATE TABLE DEPARTMENT (
    	DEPARTMENTID INT PRIMARY KEY,
    	DEPARTMENT_NAME VARCHAR2(30) NOT NULL,
    	STOREID INT NOT NULL REFERENCES STORE(STOREID) ON DELETE CASCADE,
    	EMPLOYEEID INT NOT NULL REFERENCES MANAGER(EMPLOYEEID) ON DELETE CASCADE)');
	oci_execute($query);

	$query = oci_parse($conn, 'CREATE TABLE PRODUCT (
    	PRODUCTID INT PRIMARY KEY,
    	PRODUCT_TYPE VARCHAR2(15) NOT NULL,
   	PRODUCT_STOCK INT DEFAULT(0),
    	PRODUCT_BRAND VARCHAR2(15) NOT NULL,
    	DEPARTMENTID INT NOT NULL REFERENCES DEPARTMENT(DEPARTMENTID) ON DELETE CASCADE)');
	oci_execute($query);

	$query = oci_parse($conn, 'CREATE TABLE CASHIER (
    	EMPLOYEEID INT PRIMARY KEY REFERENCES EMPLOYEE(EMPLOYEEID),
    	DEPARTMENTID INT NOT NULL REFERENCES DEPARTMENT(DEPARTMENTID) ON DELETE CASCADE)');
	oci_execute($query);

	$query = oci_parse($conn, 'CREATE TABLE SALE (
    	SALEID INT PRIMARY KEY,
    	EMPLOYEEID INT NOT NULL REFERENCES CASHIER(EMPLOYEEID) ON DELETE CASCADE,
    	CUSTOMERID INT NOT NULL REFERENCES CUSTOMER(CUSTOMERID) ON DELETE CASCADE,
    	SALE_DATE DATE NOT NULL,
    	SALE_TYPE VARCHAR2(30) NOT NULL)');
	oci_execute($query);

	$query = oci_parse($conn, 'CREATE TABLE SHIPMENT (
    	SHIPMENTID INT PRIMARY KEY,
    	SUPPLIERID INT NOT NULL REFERENCES SUPPLIER(SUPPLIERID) ON DELETE CASCADE,
    	STOREID INT NOT NULL REFERENCES STORE(STOREID),
    	PRODUCTID INT NOT NULL REFERENCES PRODUCT(PRODUCTID) ON DELETE CASCADE,
    	QUANTITY INT NOT NULL,
    	UNIT_PRICE INT NOT NULL,
    	SHIPMENT_DATE DATE NOT NULL,
    	FULFILLED VARCHAR2(5))');
	oci_execute($query);

	$query = oci_parse($conn, 'CREATE TABLE PRODUCT_IN_SALE (
    	SALEID INT NOT NULL REFERENCES SALE(SALEID) ON DELETE CASCADE,
    	PRODUCTID INT NOT NULL REFERENCES PRODUCT(PRODUCTID) ON DELETE CASCADE,
    	QUANTITY INT NOT NULL,
    	UNIT_PRICE INT NOT NULL,
    	PRIMARY KEY (SALEID, PRODUCTID))');
	oci_execute($query);
}


?>
