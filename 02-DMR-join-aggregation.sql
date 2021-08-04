--------
-- Join
--------

--- 확인

DESC employees;
DESC departments;

--두 테이블로부터 모든 레코드 추출하기
SELECT *
FROM employees , departments
ORDER BY first_name;
-- 테이블 조건을 부여할 수 있다.
SELECT first_name, emp.department_id ,dept.department_id , department_name
FROM employees emp , departments dept
    WHERE emp.department_id = dept.department_id;
    
SELECT COUNT(*) FROM employees;    --107명

SELECT first_name, dept.department_id , department_name
FROM employees emp , departments dept
    WHERE emp.department_id = dept.department_id;
    
SELECT * FROM employees
WHERE department_id IS NULL;

-- using 은 조인할 컬럼을  명시해줌
SELECT first_name, department_name
FROM employees JOIN departments USING (department_id);

-- ON: Join 의 조건절

SELECT first_name, department_name
FROM employees emp JOIN departments dept 
                    ON (emp.department_id = dept.department_id);
    
--Natural join 
--조건 명시 없이 같은 이름을 가진 컬럼으로 조인
SELECT first_name, department_name
FROM employees NATURAL JOIN departments;
--잘못된 쿼리 주의 매니저id와 부서id가 두개가 중복되기 때문에.. 이상하게 나옴.


--theta join
--join 조건이 = 이 아닌 것

------
--outer join
-----

--조건이 만족하는 짝이 없는 튜플도 Null값을 포함하여 결과를 출력
--모든 레코드를 출력할 테이블의 위치에 따라 LEFT ,RIGHT,FULL OUTER JOIN

SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp , departments dept
WHERE emp.department_id = dept.department_id(+);

--ansi sql
SELECT emp.first_name,
    emp.department_id,
    dept.department_id,
    dept.department_name
FROM employees emp LEFT OUTER JOIN departments dept
                        ON emp.department_id = dept.department_id;
                        
                        
-- RIGHT OUTER JOIN: 짝이 없는 오른쪽 레코드도 NULL을 포함하여 출력
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp , departments dept
WHERE emp.department_id(+) = dept.department_id;

SELECT emp.first_name,
    emp.department_id,
    dept.department_id,
    dept.department_name
FROM employees emp RIGHT OUTER JOIN departments dept
                        ON emp.department_id = dept.department_id;

-- FULL OUTER JOIN 
-- 양쪽 테이블 레코드 전부를 짝이 없어도 출력에 참여
--SELECT emp.first_name,
--    emp.department_id,
--    dept.department_id,
--    department_name
--FROM employees emp , departments dept
--WHERE emp.department_id(+) = dept.department_id(+);

--ansi sql
SELECT emp.first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp FULL OUTER JOIN departments dept
                    ON emp.department_id = dept.department_id;
                    
                    
------
-- SELF JOIN
------
-- 자기 자신과 JOIN
-- 자기 자신을 두 번 이상 호출 -> alias를 사용할 수 밖에 없다.

SELECT * FROM employees; --107명

SELECT emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.employee_id,
    man.first_name
FROM employees emp JOIN employees man
                    ON emp.manager_id = man.employee_id
ORDER BY emp.employee_id;

-- 방법 2.
SELECT emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.employee_id,
    man.first_name
FROM employees emp , employees man
WHERE emp.manager_id = man.employee_id
ORDER BY emp.employee_id;
    

