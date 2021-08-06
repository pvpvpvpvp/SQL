--Q 1
SELECT COUNT(*) 
FROM employees 
WHERE salary < (SELECT avg(salary) FROM employees);
--Q 2
SELECT employee_id, first_name, salary ,ROUND(t.avgSalary,2), t.maxSalary
FROM employees e , (SELECT AVG(salary) avgSalary,
                            MAX(salary) maxSalary
                            FROM employees) t
WHERE salary BETWEEN t.avgSalary AND t.maxSalary;
  
  
 --3번 나누어 보기
-- steven의 소속
SELECT department_id FROM employees WHERE first_name='Steven' AND last_name='King';
 
 -- 부서의 로케이션 아이디
 SELECT location_id FROM departments
 WHERE department_id = (SELECT department_id 
                    FROM employees 
                    WHERE first_name='Steven' 
                    AND last_name='King');
 
--3번
 SELECT location_id, street_address, postal_code, city,state_province,country_id
 FROM locations
 WHERE location_id = (SELECT location_id FROM departments
                        WHERE department_id = (SELECT department_id 
                                                 FROM employees 
                                                 WHERE first_name='Steven' 
                                                 AND last_name='King'));
   
4번의 부분
SELECT salary FROM employees WHERE job_id='ST_MAN';

--4번  
SELECT employee_id,first_name,salary 
FROM employees
WHERE salary < ANY (SELECT salary FROM employees WHERE job_id='ST_MAN');

5번 최고급여
SELECT department_id, max(salary) FROM employees 
GROUP BY department_id;
5번
SELECT employee_id , first_name, salary, department_id 
FROM employees
WHERE (department_id,salary) IN(SELECT department_id, max(salary) FROM employees 
GROUP BY department_id);
테이블 조인 버전
SELECT employee_id , first_name, t.salary, e.department_id 
FROM employees e ,(SELECT department_id, max(salary) salary FROM employees 
GROUP BY department_id) t
WHERE e.department_id = t.department_id AND e.salary = t.salary;

6번 부분
SELECT job_id , SUM(salary) FROM employees
GROUP BY job_id; 
6 번!
SELECT job_title, t.sumSalary
FROM jobs jd ,(SELECT job_id , SUM(salary) sumSalary FROM employees
GROUP BY job_id) t
WHERE jd.job_id = t.job_id;; 

7번
자신부서의 평균
SELECT department_id, AVG(salary) avgSalary FROM employees
GROUP BY department_id;
7번의 최종
SELECT e.employee_id, e.first_name , e.salary
FROM employees e,(SELECT department_id, AVG(salary) avgSalary FROM employees
                    GROUP BY department_id) t
WHERE e.salary > t.avgsalary AND e.department_id =t.department_id;
8번 문제~
SELECT ROWNUM
    employee_id,
    first_name,
    salary,
    hire_date
FROM employees
ORDER BY hire_date asc;
                
쿼리 2 
SELECT ROWNUM rn,
    employee_id,
    first_name,
    salary,
    hire_date
FROM (SELECT 
    employee_id,
    first_name,
    salary,
    hire_date
FROM employees
ORDER BY hire_date asc);

SELECT rn,
    employee_id,
    first_name,
    salary,
    hire_date
FROM (SELECT ROWNUM rn,
    employee_id,
    first_name,
    salary,
    hire_date
FROM (SELECT 
    employee_id,
    first_name,
    salary,
    hire_date
FROM employees
ORDER BY hire_date asc))
WHERE rn BETWEEN 11 AND 15;
