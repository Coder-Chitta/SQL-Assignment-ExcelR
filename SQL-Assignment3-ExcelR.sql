-- 1. Write a stored procedure that accepts the month and year as inputs and prints the ordernumber, orderdate and status of the orders placed in that month. 
-- Example:  call order_status(2005, 11);

DELIMITER //

CREATE PROCEDURE order_status(IN p_year INT, IN p_month INT)
BEGIN
    SELECT ordernumber, orderdate, status
    FROM orders
    WHERE YEAR(orderdate) = p_year AND MONTH(orderdate) = p_month;
END //

DELIMITER ;

CALL order_status(2005, 5);



# 2. a. Write function that takes the customernumber as input and returns the purchase_status based on the following criteria . [table:Payments]
-- if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold
-- if amount > 50000 Platinum


DELIMITER //

DELIMITER //

CREATE FUNCTION get_purchase_status(customer_num INT) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE total_purchase_amount DECIMAL(10, 2);
    DECLARE purchase_status VARCHAR(50);
    
    SELECT SUM(amount) INTO total_purchase_amount
    FROM Payments
    WHERE customerNumber = customer_num;
    
    IF total_purchase_amount < 25000 THEN
        SET purchase_status = 'Silver';
    ELSEIF total_purchase_amount >= 25000 AND total_purchase_amount <= 50000 THEN
        SET purchase_status = 'Gold';
    ELSE
        SET purchase_status = 'Platinum';
    END IF;
    
    RETURN purchase_status;
END //

DELIMITER ;

-- b. Write a query that displays customerNumber, customername and purchase_status from customers table.
SELECT customerNumber, customerName, get_purchase_status(customerNumber) AS purchase_status
FROM customers;

# 3. Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables. Note: Both tables - movies and rentals - don't have primary or foreign keys. Use only triggers to implement the above.
DELIMITER //
CREATE TRIGGER movies_cascade_delete
BEFORE DELETE ON movies
FOR EACH ROW
BEGIN
    DELETE FROM rentals
    WHERE movieid = OLD.id;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER movies_cascade_update
AFTER UPDATE ON movies
FOR EACH ROW
BEGIN
    UPDATE rentals
    SET movieid = NEW.id
    WHERE movieid = OLD.id;
END //
DELIMITER ;


# 4. Select the first name of the employee who gets the third highest salary. [table: employee]

SELECT fname, salary
FROM employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

# 5. Assign a rank to each employee  based on their salary. The person having the highest salary has rank 1. [table: employee]

SELECT fname, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employee;
