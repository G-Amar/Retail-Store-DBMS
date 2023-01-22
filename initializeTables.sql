/*
Group:
Amar Gupta 500987921
Sudipto Bose 501015177
Cedric Li-Chay-Chung 501024081
*/

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
    PRODUCT_TYPE VARCHAR2(30) NOT NULL,
    PRODUCT_STOCK INT DEFAULT(0),
    PRODUCT_BRAND VARCHAR2(30) NOT NULL,
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

/*SET PRODUCT PRICES AND UPDATE PRODUCT_IN_SALE ACCORDINGLY*/

/*store(storeID, CITY, STREET, ZIPCODE, UNIT_NUM)*/
INSERT INTO STORE VALUES (1, 'Toronto', '10 Something St', 'A1A1A1', 4);
INSERT INTO STORE VALUES (2, 'Ottawa', '20 Something St', 'B2B2B2', NULL);

/*--------------------------------------------------------------------------------------------------*/

/*supplier(supplierID, supplier_name, city)*/
INSERT INTO SUPPLIER VALUES (1, 'Nike', 'Toronto');
INSERT INTO SUPPLIER VALUES (2, 'Adidas', 'Ottawa');
INSERT INTO SUPPLIER VALUES (3, 'Under Armour', 'Toronto');

/*--------------------------------------------------------------------------------------------------*/

/*customer(customerID, customer_name)*/
INSERT INTO CUSTOMER VALUES (1, 'Layla-Mae Medrano');
INSERT INTO CUSTOMER VALUES (2, 'Cillian Camacho');
INSERT INTO CUSTOMER VALUES (3, 'Sachin Hayward');
INSERT INTO CUSTOMER VALUES (4, 'Lynn Davey');
INSERT INTO CUSTOMER VALUES (5, 'Shanay Kavanagh');

/*--------------------------------------------------------------------------------------------------*/

/*employee(employeeID, employee_name, salary, date_of_birth)*/
INSERT INTO EMPLOYEE VALUES (1, 'Maegan Decker', 75000, '1993-11-03');
INSERT INTO EMPLOYEE VALUES (2, 'Rodrigo Thornton', 71000, '1989-05-07');
INSERT INTO EMPLOYEE VALUES (3, 'Eric Potter', 69000, '1976-08-24');
INSERT INTO EMPLOYEE VALUES (4, 'Carley Mccarty', 35000, '1992-03-17');
INSERT INTO EMPLOYEE VALUES (5, 'Loui Eastwood', 33000, '1991-06-26');
INSERT INTO EMPLOYEE VALUES (6, 'Hajrah Hutchings', 41000, '1996-03-12');
INSERT INTO EMPLOYEE VALUES (7, 'Judy Olsen', 32000, '1995-05-05');
INSERT INTO EMPLOYEE VALUES (8, 'Aamina Hanson', 33000, '1967-10-17');
INSERT INTO EMPLOYEE VALUES (9, 'Joan Rosales', 55000, '1985-07-23');
INSERT INTO EMPLOYEE VALUES (10, 'Atticus Simmons', 37000, '1999-06-04');

/*--------------------------------------------------------------------------------------------------*/

/*manager(employeeID)*/

/*1 and 2 are in Toronto, 3 is in Ottawa*/

INSERT INTO MANAGER VALUES (1);
INSERT INTO MANAGER VALUES (2);
INSERT INTO MANAGER VALUES (3);

/*--------------------------------------------------------------------------------------------------*/

/*department(departmentID, department_name, storeID, employeeID (manager))*/

/*1, 2, 3 are in Toronto, 4, 5 are in Ottawa*/

INSERT INTO DEPARTMENT VALUES (1, 'Footwear', 1, 1);
INSERT INTO DEPARTMENT VALUES (2, 'Clothing', 1, 1);
INSERT INTO DEPARTMENT VALUES (3, 'Accessories', 1, 2);
INSERT INTO DEPARTMENT VALUES (4, 'Footwear', 2, 3);
INSERT INTO DEPARTMENT VALUES (5, 'Clothing', 2, 3);

/*--------------------------------------------------------------------------------------------------*/

/*product(productID, product_type, stock, brand, departmentID)*/

/*Toronto products: 1, 2, 3, 6, 7, 11, 12, 13*/
/*Ottawa products: 4, 5, 8, 9, 10, 14, 15, 16*/

/*FOOTWEAR*/

/*Toronto*/
INSERT INTO PRODUCT VALUES (1, 'Slipper', 25, 'Adidas', 1);
INSERT INTO PRODUCT VALUES (2, 'Sneaker', 30, 'Under Armour', 1);
INSERT INTO PRODUCT VALUES (3, 'Sneaker', 35, 'Nike', 1);

/*Ottawa*/
INSERT INTO PRODUCT VALUES (4, 'Boot', 25, 'Nike', 4);
INSERT INTO PRODUCT VALUES (5, 'Sneaker', 20, 'Under Armour', 4);

/*CLOTHING*/

/*Toronto*/
INSERT INTO PRODUCT VALUES (6, 'Pant', 55, 'Nike', 2);
INSERT INTO PRODUCT VALUES (7, 'Shirt', 20, 'Nike', 2);

/*Ottawa*/
INSERT INTO PRODUCT VALUES (8, 'Pant', 15, 'Adidas', 5);
INSERT INTO PRODUCT VALUES (9, 'Jacket', 55, 'Under Armour', 5);
INSERT INTO PRODUCT VALUES (10, 'Shirt', 35, 'Nike', 5);

/*ACCESSORIES*/

/*Toronto*/
INSERT INTO PRODUCT VALUES (11, 'Sunglass', 15, 'Nike', 3);
INSERT INTO PRODUCT VALUES (12, 'Hat', 20, 'Under Armour', 3);
INSERT INTO PRODUCT VALUES (13, 'Sunglass', 30, 'Adidas', 3);

/*--------------------------------------------------------------------------------------------------*/

/*cashier(employee ID, departmentID)*/

/*4, 5, 6, 7 are in Toronto, 8, 9, 10 are in Ottawa*/

INSERT INTO CASHIER VALUES (4, 1);
INSERT INTO CASHIER VALUES (5, 1);
INSERT INTO CASHIER VALUES (6, 2);
INSERT INTO CASHIER VALUES (7, 3);
INSERT INTO CASHIER VALUES (8, 4);
INSERT INTO CASHIER VALUES (9, 5);
INSERT INTO CASHIER VALUES (10, 5);

/*--------------------------------------------------------------------------------------------------*/

/*Sale 1, 2, 3, 4 are in Toronto, 5, 6, 7 are in Ottawa*/
/*Refund 8 is in Toronto, 9 is in Ottawa*/

/*sale(saleID, employeeID, customerID, sale_date, sale_type)*/

INSERT INTO SALE VALUES (1, 4, 1, '2022-09-28', 'SALE');
INSERT INTO SALE VALUES (2, 4, 1, '2022-09-30', 'SALE');
INSERT INTO SALE VALUES (3, 6, 2, '2022-09-28', 'SALE');
INSERT INTO SALE VALUES (4, 7, 3, '2022-09-16', 'SALE');

INSERT INTO SALE VALUES (5, 8, 4, '2022-10-01', 'SALE');
INSERT INTO SALE VALUES (6, 9, 5, '2022-10-01', 'SALE');
INSERT INTO SALE VALUES (7, 10, 2, '2022-10-03', 'SALE');

INSERT INTO SALE VALUES (8, 4, 1, '2022-10-02', 'REFUND');
INSERT INTO SALE VALUES (9, 10, 2, '2022-09-30', 'REFUND');

/*--------------------------------------------------------------------------------------------------*/

/*shipment(shipmentID, supplierID, storeID, productID, quantity, unit_price, shipment_date, fulfilled)*/
/*Adidas: 1, 5, 8, 13*/
/*Nike: 3, 4, 6, 7, 10, 11*/
/*Under Armour: 2, 5, 9, 12*/

/*Nike 1, Adidas 2, Under Armour 3*/
/*Toronto products: 1, 2, 3, 6, 7, 11, 12, 13*/

INSERT INTO SHIPMENT VALUES (1, 3, 1, 2, 15, 80, '2022-07-11', 'YES');
INSERT INTO SHIPMENT VALUES (2, 1, 1, 3, 10, 100, '2022-09-28', 'YES');
INSERT INTO SHIPMENT VALUES (3, 2, 1, 1, 5, 50, '2022-09-28', 'YES');
INSERT INTO SHIPMENT VALUES (4, 1, 1, 6, 20, 60, '2022-08-12', 'YES');
INSERT INTO SHIPMENT VALUES (5, 1, 1, 7, 10, 40, '2022-08-12', 'YES');
INSERT INTO SHIPMENT VALUES (6, 1, 1, 11, 5, 30, '2022-08-05', 'YES');
INSERT INTO SHIPMENT VALUES (7, 3, 1, 12, 10, 20, '2022-09-13', 'YES');
INSERT INTO SHIPMENT VALUES (8, 2, 1, 13, 15, 10, '2022-07-12', 'YES');
INSERT INTO SHIPMENT VALUES (9, 1, 1, 11, 25, 80, '2022-08-11', 'NO');
INSERT INTO SHIPMENT VALUES (10, 2, 1, 13, 30, 10, '2022-09-20', 'NO');

/*Ottawa products: 4, 5, 8, 9, 10, 14, 15, 16*/

INSERT INTO SHIPMENT VALUES (11, 1, 2, 4, 15, 80, '2022-07-13', 'YES');
INSERT INTO SHIPMENT VALUES (12, 3, 2, 5, 10, 100, '2022-09-18', 'YES');
INSERT INTO SHIPMENT VALUES (13, 2, 2, 8, 5, 50, '2022-08-02', 'YES');
INSERT INTO SHIPMENT VALUES (14, 3, 2, 9, 20, 60, '2022-08-28', 'YES');
INSERT INTO SHIPMENT VALUES (15, 1, 2, 10, 10, 40, '2022-10-01', 'YES');
INSERT INTO SHIPMENT VALUES (16, 1, 2, 4, 25, 80, '2022-09-25', 'NO');

/*--------------------------------------------------------------------------------------------------*/

/*sale_product(saleID, productID, quantity, unit_price)*/
INSERT INTO PRODUCT_IN_SALE VALUES (1, 1, 2, 80);
INSERT INTO PRODUCT_IN_SALE VALUES (1, 3, 4, 70);
INSERT INTO PRODUCT_IN_SALE VALUES (2, 2, 3, 80);
INSERT INTO PRODUCT_IN_SALE VALUES (2, 6, 1, 70);
INSERT INTO PRODUCT_IN_SALE VALUES (3, 7, 2, 80);
INSERT INTO PRODUCT_IN_SALE VALUES (3, 6, 3, 70);
INSERT INTO PRODUCT_IN_SALE VALUES (3, 11, 5, 50);
INSERT INTO PRODUCT_IN_SALE VALUES (4, 12, 2, 80);
INSERT INTO PRODUCT_IN_SALE VALUES (4, 13, 3, 50);

INSERT INTO PRODUCT_IN_SALE VALUES (5, 4, 2, 80);
INSERT INTO PRODUCT_IN_SALE VALUES (5, 5, 1, 70);
INSERT INTO PRODUCT_IN_SALE VALUES (6, 8, 1, 80);
INSERT INTO PRODUCT_IN_SALE VALUES (6, 9, 3, 70);
INSERT INTO PRODUCT_IN_SALE VALUES (7, 10, 1, 80);

INSERT INTO PRODUCT_IN_SALE VALUES (8, 1, -2, 80);
INSERT INTO PRODUCT_IN_SALE VALUES (8, 3, -1, 70);
INSERT INTO PRODUCT_IN_SALE VALUES (9, 9, -2, 80);
INSERT INTO PRODUCT_IN_SALE VALUES (9, 10, -1, 70);