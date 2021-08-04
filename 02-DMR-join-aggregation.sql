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
    
    
    