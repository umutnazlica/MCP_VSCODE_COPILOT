-- Create the 'employees' table
CREATE TABLE employees (
    id INT,
    name VARCHAR(255),
    salary NUMBER(10, 2)
); 

-- Insert multiple records into the 'employees' table
INSERT INTO employees (id, name, salary) VALUES
    (1, 'John Doe', 50000.00),
    (2, 'Jane Smith', 60000.00),
    (3, 'Peter Jones', 70000.00),
    (4, 'Anna Maria', 12000.00),
    (5, 'Madhu Rao', 14000.00);  

commit;
