#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "USERNAME/PASSWORD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.cs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

CREATE TABLE STORE (
    STOREID INT PRIMARY KEY,
    CITY VARCHAR2(30) NOT NULL,
    STREET VARCHAR2(60),
    ZIPCODE VARCHAR2(10),
    UNIT_NUM INT
);

CREATE TABLE SUPPLIER (
    SUPPLIERID INT PRIMARY KEY,
    SUPPLIER_NAME VARCHAR2(30) NOT NULL,
    CITY VARCHAR2(30) NOT NULL
);

CREATE TABLE CUSTOMER (
    CUSTOMERID INT PRIMARY KEY,
    CUSTOMER_NAME VARCHAR2(30)
);

CREATE TABLE EMPLOYEE (
    EMPLOYEEID INT PRIMARY KEY,
    EMPLOYEE_NAME VARCHAR2(30) NOT NULL,
    EMPLOYEE_SALARY INT NOT NULL,
    EMPLOYEE_DATE_OF_BIRTH DATE NOT NULL
);

CREATE TABLE MANAGER (
    EMPLOYEEID INT PRIMARY KEY REFERENCES EMPLOYEE(EMPLOYEEID)
);

CREATE TABLE DEPARTMENT (
    DEPARTMENTID INT PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR2(30) NOT NULL,
    STOREID INT NOT NULL REFERENCES STORE(STOREID),
    EMPLOYEEID INT NOT NULL REFERENCES MANAGER(EMPLOYEEID) /*THIS IS FOR MANAGER OF DEPARTMENT*/
);

CREATE TABLE PRODUCT (
    PRODUCTID INT PRIMARY KEY,
    PRODUCT_TYPE VARCHAR2(15) NOT NULL,
    PRODUCT_STOCK INT DEFAULT(0),
    PRODUCT_BRAND VARCHAR2(15) NOT NULL,
    DEPARTMENTID INT NOT NULL REFERENCES DEPARTMENT(DEPARTMENTID)
);

CREATE TABLE CASHIER (
    EMPLOYEEID INT PRIMARY KEY REFERENCES EMPLOYEE(EMPLOYEEID),
    DEPARTMENTID INT NOT NULL REFERENCES DEPARTMENT(DEPARTMENTID)
);

CREATE TABLE SALE (
    SALEID INT PRIMARY KEY,
    EMPLOYEEID INT NOT NULL REFERENCES CASHIER(EMPLOYEEID),
    CUSTOMERID INT NOT NULL REFERENCES CUSTOMER(CUSTOMERID),
    SALE_DATE DATE NOT NULL,
    SALE_TYPE VARCHAR2(30) NOT NULL /*INDICATES WHETHER SALE OR RETURN*/
);

CREATE TABLE SHIPMENT (
    SHIPMENTID INT PRIMARY KEY,
    SUPPLIERID INT NOT NULL REFERENCES SUPPLIER(SUPPLIERID),
    STOREID INT NOT NULL REFERENCES STORE(STOREID),
    PRODUCTID INT NOT NULL REFERENCES PRODUCT(PRODUCTID),
    QUANTITY INT NOT NULL,
    UNIT_PRICE INT NOT NULL,
    SHIPMENT_DATE DATE NOT NULL,
    FULFILLED VARCHAR2(5) DEFAULT ('NO') /*THIS INDICATES IF THE SHIPMENT HAS BEEN FULFILLED OR NOT*/
);

CREATE TABLE PRODUCT_IN_SALE (
    SALEID INT NOT NULL REFERENCES SALE(SALEID),
    PRODUCTID INT NOT NULL REFERENCES PRODUCT(PRODUCTID),
    QUANTITY INT NOT NULL,
    UNIT_PRICE INT NOT NULL,
    PRIMARY KEY (SALEID, PRODUCTID)
);
exit;
EOF
