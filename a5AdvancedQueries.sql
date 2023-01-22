/*
Amar Gupta
Sudipto Bose
Cedric Li-Chay-Chung
*/

/* 1. Find MIN, MAX, RANGE, and AVERAGE of all sales*/
SELECT MIN(X.SALE_REV) AS MINIMUM, MAX(X.SALE_REV) AS MAXIMUM, MAX(X.SALE_REV) - MIN(X.SALE_REV) AS RANGE, ROUND(AVG(X.SALE_REV), 2) AS AVERAGE, ROUND(VARIANCE(X.SALE_REV), 2) AS VARIANCE, ROUND(STDDEV(X.SALE_REV), 2) AS STDDEV 
FROM (SELECT SALE.SALEID, SUM(PRODUCT_IN_SALE.QUANTITY * PRODUCT_IN_SALE.UNIT_PRICE) AS SALE_REV
        FROM SALE, PRODUCT_IN_SALE 
        WHERE SALE.SALEID = PRODUCT_IN_SALE.SALEID AND SALE.SALE_TYPE = 'SALE'
        GROUP BY SALE.SALEID) X;


/* 2. Select all product in the footwear department that have revenue over $200*/
SELECT P.*
FROM PRODUCT P, DEPARTMENT D
WHERE P.DEPARTMENTID = D.DEPARTMENTID AND D.DEPARTMENT_NAME = 'Footwear'
AND EXISTS
(SELECT P2.PRODUCTID, SUM(PS.QUANTITY*PS.UNIT_PRICE)
FROM PRODUCT P2, PRODUCT_IN_SALE PS
WHERE P2.PRODUCTID = PS.PRODUCTID AND P2.PRODUCTID = P.PRODUCTID
GROUP BY P2.PRODUCTID
HAVING SUM(PS.QUANTITY*PS.UNIT_PRICE) > 200
);


/* 3. List all products that are sunglasses or part of the footwear department*/
SELECT * FROM PRODUCT
WHERE PRODUCT_TYPE = 'Sunglass'
UNION
(SELECT P.*
FROM PRODUCT P, DEPARTMENT D
WHERE P.DEPARTMENTID = D.DEPARTMENTID AND D.DEPARTMENT_NAME = 'Footwear'
);


/* 4. All products not supplied bu supplier 3*/
(SELECT *
FROM PRODUCT)
MINUS (
SELECT P.*
FROM SHIPMENT S, PRODUCT P
WHERE S.PRODUCTID = P.PRODUCTID AND S.SUPPLIERID = 3);


/* 5. List all products that have not had a shipment since SEPT 1ST*/
SELECT * FROM PRODUCT
MINUS 
(SELECT P.*
FROM PRODUCT P, SHIPMENT S
WHERE P.PRODUCTID = S.PRODUCTID AND S.SHIPMENT_DATE > TO_DATE('2022-09-01','YYYY-MM-DD')
);

/* 6. Show sales per employee who have done more than 1 */

SELECT EMPLOYEE_NAME, COUNT(SALEID) AS SALE_COUNT
FROM EMPLOYEE, SALE
WHERE EMPLOYEE.EMPLOYEEID = SALE.EMPLOYEEID
GROUP BY EMPLOYEE_NAME
HAVING COUNT(SALEID) > 1
ORDER BY SALE_COUNT DESC;

/*Folowing are advanced queries from A4p2*/

/* 7. Show sales per product grouped by type and brand in descending order*/

SELECT PRODUCT_TYPE, PRODUCT_BRAND, COUNT(SALE.SALEID) AS SALE_COUNT
FROM PRODUCT, SALE, PRODUCT_IN_SALE
WHERE PRODUCT.PRODUCTID = PRODUCT_IN_SALE.PRODUCTID AND PRODUCT_IN_SALE.SALEID = SALE.SALEID
GROUP BY PRODUCT_TYPE, PRODUCT_BRAND
ORDER BY PRODUCT_TYPE, SALE_COUNT DESC;

/* 8. Show relevant product and supplier information for all shipments*/

SELECT SHIPMENT.SHIPMENTID, SUPPLIER_NAME,PRODUCT_TYPE, PRODUCT_BRAND, QUANTITY, SHIPMENT_DATE, FULFILLED
FROM PRODUCT, SHIPMENT, SUPPLIER
WHERE SHIPMENT.PRODUCTID = PRODUCT.PRODUCTID AND SHIPMENT.SUPPLIERID = SUPPLIER.SUPPLIERID
ORDER BY SHIPMENTID;

/* 9. Show how many cashiers each manager supervises */

SELECT MANAGER.EMPLOYEEID, EMPLOYEE.EMPLOYEE_NAME AS MANAGER_NAME, COUNT(CASHIER.EMPLOYEEID) AS CASHIERS
FROM MANAGER, DEPARTMENT, EMPLOYEE, CASHIER
WHERE DEPARTMENT.EMPLOYEEID = MANAGER.EMPLOYEEID AND EMPLOYEE.EMPLOYEEID = MANAGER.EMPLOYEEID AND CASHIER.DEPARTMENTID = DEPARTMENT.DEPARTMENTID
GROUP BY MANAGER.EMPLOYEEID, EMPLOYEE.EMPLOYEE_NAME
ORDER BY MANAGER.EMPLOYEEID ASC;

/* 10. Show number of products bought by each customer */

SELECT CUSTOMER_NAME, COUNT(PRODUCT_IN_SALE.QUANTITY) AS COUNT
FROM CUSTOMER, PRODUCT_IN_SALE, SALE
WHERE CUSTOMER.CUSTOMERID = SALE.CUSTOMERID AND SALE.SALE_TYPE = 'SALE' AND SALE.SALEID = PRODUCT_IN_SALE.SALEID
GROUP BY CUSTOMER_NAME
ORDER BY CUSTOMER_NAME ASC;

/* 11. Show number of products sold for each product type and brand */

SELECT PRODUCT.PRODUCTID, PRODUCT_TYPE, PRODUCT_BRAND, SUM(PRODUCT_IN_SALE.QUANTITY) AS SALES
FROM PRODUCT, PRODUCT_IN_SALE, SALE
WHERE PRODUCT.PRODUCTID = PRODUCT_IN_SALE.PRODUCTID AND SALE.SALE_TYPE = 'SALE' AND SALE.SALEID = PRODUCT_IN_SALE.SALEID
GROUP BY PRODUCT.PRODUCTID, PRODUCT_TYPE, PRODUCT_BRAND
ORDER BY PRODUCT.PRODUCTID ASC;
