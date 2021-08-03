
--SELECT * FROM employees;

--DML: SELECT
-------------
-- SELECT FROM
--------------

--전체 데이터의 모든 컬럼 조회
-- 컬럼의 출력 순서는 정의에 따른다
SELECT *FROM employees;
SELECT*FROM departments;

--특정 컬럼만 선별 projection
-- 사원의 이름 (first_name) 입사일(hrie_date) 급여(salary)
SELECT first_name,
    hire_date,
    salary
    FROM employees;
    
-- 산술연산 기본적인 산술연산이 가능하다.
-- dual:  oracle의 가상 테이블
-- 특정 테이블에 속한 데이터가 아닌
-- 오라클 시스템에서 값을 구한다.

SELECT 10*10*3.141592 FROM dual; --결과 1개
SELECT 10*10*3.141592 FROM employees; -- 결과 테이블의 레코드 수만큼 나옴

SELECT first_name,job_id*12
FROM employees; -- 수치데이터 아니면 산술연산 오류
DESC employees;

SELECT first_name + ' '+last_name
FROM employees; -- first_name + ' '+last_name 은 문자열

--문자열 연결은 ||로 연결
SELECT first_name || ' ' || last_name
FROM employees;

--NULL
SELECT first_name, salary,salary*12
FROM employees;

SELECT first_name,salary,commission_pct
FROM employees;

SELECT first_name,
    salary,
    commission_pct,
    salary+salary*commission_pct
FROM employees; --NULL이 포함된 산술식의 결과값은 NULL입니다.

SELECT first_name,
    salary,
    commission_pct,
    salary+salary*NVL(commission_pct,0)
    -- commission_pct가 NULL이면 0으로 치환
FROM employees;

-- ALIAS : 별칭
SELECT first_name || ' '||last_name 이름,
    phone_number as 전화번호,
    salary "급 여"--공백문자 혹은 특수문자는 ""처리를 해야한다.
FROM employees;

--연습문제
SELECT first_name ||' '||last_name 이름,
    hire_date 입사일,
    phone_number 전화번호,
    salary 급여, --공백문자 혹은 특수문자는 ""처리를 해야한다.
    salary*12 연봉
FROM employees;

------------------
-- WHERE
------------------

--비교연산
--급여가 15000 이상인 사원의 목록을 출력
SELECT first_name,salary
FROM employees
WHERE salary>=15000;

SELECT first_name,hire_date
FROM employees
WHERE hire_date >='07/01/01';

SELECT first_name,hire_date
FROM employees
WHERE first_name ='Lex';

-- 논리 연산자
SELECT first_name,salary
FROM employees
WHERE salary <= 10000 OR salary>=17000;

--급여가 14000 이상 , 17000 이하 인 사원의 목록

SELECT first_name,salary
FROM employees
WHERE salary >= 14000 AND salary<=17000;


-- BERWEEN 동일!
SELECT first_name,salary
FROM employees
WHERE salary BETWEEN 14000 AND 17000;

--SELECT first_name,salary
--FROM employees
--WHERE salary BETWEEN ("14000","17000");

-- NULL 체크
-- = NUll, != NULL은 사용불가

-- 반드시 IS NULL, IS NOT NULL 사용
-- commission을 받지 않는 사원 목록

SELECT first_name,commission_pct
FROM employees
WHERE commission_pct IS NULL;

--연습문제
--담당 매니저가 없고, 커미션을 받지 않는 사원의 목록
SELECT first_name,commission_pct
FROM employees
WHERE commission_pct IS NULL AND ;

-- 집합연산자 :IN
-- 부서 번호가 10,20,30 인 사원들의 목록
SELECT first_name,department_id
FROM employees
WHERE department_id = 10 OR 
    department_id = 20 OR 
    department_id = 30;
    
-- IN
SELECT first_name,department_id
FROM employees
WHERE department_id IN (10,20,30);

-- ANY
SELECT first_name,department_id
FROM employees
WHERE department_id = ANY(10,20,30); 

-- ALL

SELECT first_name,salary
FROM employees
WHERE salary > ALL(12000,17000);

--LIKE  연산자: 부분검색
-- %: 0글자 이상의 정해지지 않은 문자열
-- _: 1글자 정해지지 않은 문자
-- 이름에 am을 포함한 사원의 이름과 급여를 출력
SELECT first_name,salary
FROM employees
WHERE first_name LIKE '%am%';

--연습문제
--이름의 두번째 글짜가 a인 사원의 이름 연봉
SELECT first_name,salary
FROM employees
WHERE first_name LIKE '_a%';

