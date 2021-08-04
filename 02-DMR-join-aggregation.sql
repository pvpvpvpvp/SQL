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
WHERE emp.manager_id = man.employee_id(+)
ORDER BY emp.employee_id;
    


--sql 문제
SELECT  emp.employee_id,
     dept.department_name
FROM employees emp , departments dept
ORDER BY dept.department_name
        , emp.employee_id;
        
        
---------
--집계 함수
---------

--여러 레코드로부터 데이터를 수집,하나의 결과 행을 반환

--count: 갯수 세기
SELECT COUNT(*) FROM employees; --특정 컬럼이 아닌 레코드의 갯수을 센다.

SELECT COUNT(commission_pct) FROM employees; -- 해당 컬럼이 null 이 아난 갯수

SELECT COUNT(*) FROM employees
WHERE commission_pct IS NOT NULL; 

-- sum 합계

-- 급여의 합계 
SELECT sum(salary) FROM employees;

-- avg 평균
-- 급여의 평균
SELECT avg(salary) FROM employees;
--avg는 null값은 집계에서 제외한다.
--사원들의 평균 커미션비율
SELECT avg(commission_pct) FROM employees;
    
SELECT avg(nvl(commission_pct,0)) FROM employees;     --통계사용시 null값 주의

--min max 

SELECT max(salary),min(salary),avg(salary),MEDIAN(salary)  FROM employees;


--일반적 오류 
SELECT department_id, AVG(salary) --107개 와 단일 이므로 오류
FROM employees;

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;


-- 집계 함수를 사용한 SELECT 문의 컬럼 목록에는
-- Group by에 참여한 필드, 집계 함수만 올 수 있다.

-- 부서별 평균 급여를 출력,
-- 평균 급여가 7000 이상인 부서만 뽑아봅시다.

SELECT department_id, AVG(salary)
FROM employees
WHERE AVG(salary)>=7000
GROUP BY department_id; --에러
--집계 함수 실행 이전 where절을 검사하기 떄문에 
--집계 함수는 사용 불가능

--HAVING사용해야됨
SELECT department_id, ROUND(AVG(salary),2)
FROM employees
HAVING AVG(salary)>=7000
GROUP BY department_id; --에러


--분석 함수

--ROLLUP
--그룹핑된 결과에 대한 상세 요약을 제공하는 기능
-- 일정의 ITEM TOTAL

SELECT department_id,
            job_id,
            sum(salary)
FROM employees
GROUP BY ROLLUP (department_id, job_id);

--CUBE 함수
--Cross table에 대한 summary를 함께 추출
--Rollup 함수에서 추출되는 item total과 함께
--column total 값을 함께 추출
SELECT department_id , job_id, SUM(salary)
FROM employees
GROUP BY CUBE (department_id, job_id)
ORDER BY department_id;


--연습문제 조인
--1번
SELECT employee_id,
    first_name || ' ' || last_name,
    department_name
FROM employees emp JOIN departments dept
                    ON emp.department_id = dept.department_id
ORDER BY  dept.department_name, emp.employee_id DESC;
--2번
SELECT employee_id,
    first_name || ' ' || last_name,
    salary,
    job_title,
    department_name
FROM employees emp JOIN departments dept
                    ON emp.department_id = dept.department_id
                    JOIN jobs jd
                    ON emp.job_id=jd.job_id
ORDER BY  emp.employee_id;
--2-1번
SELECT employee_id,
    first_name || ' ' || last_name,
    salary,
    job_title,
    department_name
FROM employees emp JOIN departments dept
                    ON emp.department_id = dept.department_id(+)
                    JOIN jobs jd
                    ON emp.job_id=jd.job_id
ORDER BY  emp.employee_id;
--3번 
SELECT lo.location_id,
    lo.city,
    dept.department_name,
    dept.department_id
FROM   departments dept JOIN locations lo
                    ON lo.location_id = dept.location_id
ORDER BY  lo.location_id;
--3-1번
SELECT lo.location_id,
    lo.city,
    dept.department_name,
    dept.department_id
FROM   departments dept JOIN locations lo
                    ON lo.location_id = dept.location_id(+)
ORDER BY  lo.location_id;
4번
SELECT region_name, co.country_id 
FROM countries co JOIN regions re
                ON co.region_id = re.region_id
ORDER BY region_name , country_name DESC;
5번
SELECT emp.employee_id,
    emp.first_name,
    emp.hire_date,
    mn.first_name,
    mn.hire_date
FROM employees emp JOIN employees mn
                    ON emp.manager_id = mn.employee_id
WHERE emp.hire_date<mn.hire_date;
--6번
SELECT co.country_name, co.country_id,
    lo.city,
    lo.location_id,
    dept.department_name,
    dept.department_id
FROM departments dept JOIN locations lo
                    ON dept.location_id = lo.location_id
                    JOIN countries co
                    ON lo.country_id = co.country_id
ORDER BY country_name;
7번
SELECT emp.employee_id,
     first_name || ' ' || last_name,
     emp.job_id,
     start_date,
     end_date
FROM employees emp JOIN job_history jh
                ON emp.job_id='AC_ACCOUNT' AND emp.job_id = jh.job_id;
8번
SELECT emp.department_id,
    dept.department_name,
    mn.first_name,
    city,
    country_name,
    region_name
FROM employees emp 
                    JOIN departments dept
                    ON emp.department_id = dept.department_id
                    JOIN employees mn
                    ON emp.employee_id = mn.employee_id AND emp.employee_id = dept.manager_id
                    JOIN locations lo
                    ON dept.location_id = lo.location_id
                    JOIN countries co
                    ON lo.country_id = co.country_id
                    JOIN regions re
                    ON co.region_id = re.region_id;
    
9번
SELECT emp.employee_id,
    emp.first_name,
    dept.department_name,
    mn.first_name
FROM employees emp  JOIN departments dept
                    ON emp.department_id = dept.department_id
                     JOIN employees mn
                     ON emp.employee_id = mn.employee_id;
--
--집계
--
SELECT *
FROM employees;
--1번
SELECT COUNT(manager_id) 
FROM employees;
--2번
SELECT max(salary) 최고임금,
    min(salary) 최저임금,
    max(salary)-min(salary) "최고임금-최저임금"
FROM employees ;
--3번
SELECT max(TO_CHAR(TO_DATE(hire_date,'YY-MM-DD'),'"20"YY"년 "MM"월 "DD"일"'))
FROM employees ;
--4번
SELECT ROUND(avg(salary),2),
    max(salary),
    min(salary),
    department_id
FROM employees 
GROUP BY department_id
ORDER BY department_id DESC;
--5번
SELECT ROUND(avg(salary),2),
    max(salary),
    min(salary),
    job_id
FROM employees 
GROUP BY job_id
ORDER BY min(salary) DESC,
        ROUND(avg(salary));
--6번 ??
SELECT min(TO_CHAR(TO_DATE(hire_date,'YY-MM-DD'),'"20"YY"년 "MM"월 "DD"일"'))
FROM employees ;
                        
