/*
Amar Gupta
Sudipto Bose
Cedric Li-Chay-Chung
*/

/* 1. Show number of stores in each city (STORE table) */

SELECT DISTINCT CITY, COUNT(CITY) AS COUNT
FROM STORE
GROUP BY CITY;

/* 2. Show suppliers in Toronto (SUPPLIER table) */

SELECT DISTINCT SUPPLIER_NAME, SUPPLIER.SUPPLIERID
FROM SUPPLIER
WHERE CITY = 'Toronto'
ORDER BY SUPPLIERID DESC;

/* 3. Show unique products (by type) (PRODUCT table) */

SELECT DISTINCT PRODUCT_TYPE
FROM PRODUCT
ORDER BY PRODUCT_TYPE ASC;

/* 4. List shipments where cost is greater than $1000 (SHIPMENT table) */

SELECT DISTINCT SHIPMENT.SHIPMENTID, SHIPMENT.PRODUCTID, QUANTITY, UNIT_PRICE, QUANTITY * UNIT_PRICE AS TOTAL_COST
FROM SHIPMENT
WHERE QUANTITY * UNIT_PRICE > 1000
ORDER BY SHIPMENTID ASC;

/* 5. Show employees that have salary greater than $50,000 (EMPLOYEE table) */

SELECT DISTINCT EMPLOYEE.EMPLOYEEID, EMPLOYEE_NAME, EMPLOYEE_SALARY
FROM EMPLOYEE
WHERE EMPLOYEE_SALARY > 50000
ORDER BY EMPLOYEE.EMPLOYEEID ASC;

/* 6. Show distinct departments (DEPARTMENT table) */

SELECT DISTINCT DEPARTMENT_NAME
FROM DEPARTMENT
ORDER BY DEPARTMENT_NAME ASC;

/* 7. Show the number of sales (excluding refunds) per day (SALE table) */

SELECT SALE_DATE, COUNT(SALEID) AS COUNT
FROM SALE
WHERE SALE_TYPE = 'SALE'
GROUP BY SALE_DATE
ORDER BY SALE_DATE ASC;

/* 8. Show number of products in each sales and refunds (PRODUCT_IN_SALE table) */

SELECT SALEID, SUM(PRODUCT_IN_SALE.QUANTITY) AS PRODUCTS
FROM PRODUCT_IN_SALE
GROUP BY SALEID
ORDER BY SALEID ASC;

/* 9. Show number of cashiers per department (CASHIER table) */

SELECT DEPARTMENT_NAME, COUNT(CASHIER.EMPLOYEEID) AS CASHIERS
FROM DEPARTMENT, CASHIER
WHERE CASHIER.DEPARTMENTID = DEPARTMENT.DEPARTMENTID
GROUP BY DEPARTMENT_NAME
ORDER BY DEPARTMENT_NAME;

/* 10. Show number of different products in each department (DEPARTMENT table) */

SELECT DEPARTMENT_NAME, COUNT(PRODUCT.PRODUCTID) AS COUNT
FROM DEPARTMENT, PRODUCT
WHERE DEPARTMENT.DEPARTMENTID = PRODUCT.DEPARTMENTID
GROUP BY DEPARTMENT_NAME
ORDER BY DEPARTMENT_NAME ASC;

/* 11. Show managers number of departments managed by manager (MANAGER table) */

SELECT EMPLOYEE_NAME AS MANAGER_NAME, COUNT(DEPARTMENT.DEPARTMENTID) AS DEPARTMENTS
FROM MANAGER, DEPARTMENT, EMPLOYEE
WHERE DEPARTMENT.EMPLOYEEID = MANAGER.EMPLOYEEID AND EMPLOYEE.EMPLOYEEID = MANAGER.EMPLOYEEID
GROUP BY EMPLOYEE_NAME
ORDER BY EMPLOYEE_NAME ASC;

/* 12. Show the distinct names of each customer that have done return and when (CUSTOMER table) */

SELECT DISTINCT CUSTOMER_NAME, SALE_DATE
FROM CUSTOMER, SALE
WHERE SALE.CUSTOMERID = CUSTOMER.CUSTOMERID AND SALE_TYPE = 'REFUND'
ORDER BY CUSTOMER_NAME ASC;
