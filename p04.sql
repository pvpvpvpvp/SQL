SELECT COUNT(*) 
FROM employees 
WHERE salary < (SELECT avg(salary) FROM employees);

SELECT employee_id, first_name, salary
FROM employees e
WHERE salary >= (SELECT avg(salary) FROM employees)
        AND salary <= (SELECT max(salary) FROM employees)
        ORDER BY salary;
        
 SELECT lo.location_id, street_address, postal_code, city,state_province,country_id
 FROM locations lo
 WHERE 'Steven' = (SELECT first_name FROM employees e,departments d WHERE e.department_id = d.department_id)
     AND 'king' = (SELECT last_name FROM employees e,departments d WHERE e.department_id = d.department_id);
                
                