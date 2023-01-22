#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "USERNAME/PASSWORD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.cs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
drop table SUPPLIER cascade constraints;
drop table STORE cascade constraints;
drop table SHIPMENT cascade constraints;
drop table SALE cascade constraints;
drop table PRODUCT_IN_SALE cascade constraints;
drop table PRODUCT cascade constraints;
drop table MANAGER cascade constraints;
drop table EMPLOYEE cascade constraints;
drop table DEPARTMENT cascade constraints;
drop table CUSTOMER cascade constraints;
drop table CASHIER cascade constraints;
exit;
EOF
