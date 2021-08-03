
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

--ORDER BY : 정렬
-- 오름차순: 작은 값 -> 큰 값 ASC(defalut)
-- 내림차순: 큰 값 -> 작은 값 DESC

--부서 번호를 오름차순 부서번호 급여 이름 출력

SELECT department_id,salary,first_name
FROM employees
ORDER BY department_id;

--조건 급여 10000이상 직원
--정렬 급여 내림차순
SELECT first_name,salary
FROM employees
WHERE salary >= 10000
ORDER BY salary DESC;

-- 출력: 부서 번호, 급여,이름
-- 정렬: 1차정렬 부서번호 오름 ,2차 급여 내림

SELECT first_name,department_id,salary
FROM employees
ORDER BY department_id,
    salary DESC;
-----------
--단일행 함수
-----------
--한 개의 레코드를 입력으로 받는 함수
--문자열 단일행 함수 연습
SELECT first_name, last_name,
    CONCAT(first_name, CONCAT(' ',last_name)),
    INITCAP(first_name || ' ' || last_name),
    LOWER(first_name),
    UPPER(first_name),
    LPAD(first_name,10,'*'),
    RPAD(first_name,10,'*')
FROM employees;

SELECT LTRIM('      ORACLE      '),
    RTRIM('      ORACLE      '),
    TRIM('*'FROM '******Database****'),
    SUBSTR('ORACLE database',8,4),
    SUBSTR('ORACLE database',7,2)
FROM employees;
    
-- 수치형 단일행 함수

SELECT ABS(-3.14), --절대값
    CEIL(3.14),    --소수점 올림
    FLOOR(3.14),   --소수점 버림
    MOD(7,3),      --나머지
    POWER(2,4),    --제곱 2의 4제곱
    ROUND(3.14),       --소수점 반올림
    ROUND(3.141592,3),  -- 소수점 3자리까지 반올림 표현
    TRUNC(3.5),         -- 소수점 버림
    TRUNC(3.141592,3),  --소수점 3자리까지 버림표현
    SIGN(-10)           --부호 혹은 0
FROM dual;
    
    
SELECT SYSDATE FROM dual;
SELECT SYSDATE FROM employees;

--날짜 관련 단일행 함수
SELECT sysdate,
    ADD_MONTHS(sysdate,2),
    LAST_DAY(sysdate),
    MONTHS_BETWEEN('99/12/31',sysdate),
    NEXT_DAY(sysdate,'금요일'),
    ROUND(sysdate, 'MONTH'),
    ROUND(sysdate, 'YEAR'),
    TRUNC(sysdate, 'MONTH'),
    TRUNC(sysdate, 'YEAR')
 FROM dual;


------------
--변환 함수
------------

-- TO_NUMBER(s.fmt) : 문자열을 포맷에 맞게 수치형으로 변환
-- TO_DAE(s, fmt) :문자열을 포맷에 맞게 날짜형으로 변환
-- TO_CHAR(o, fmt) : 숫자 OR 날짜를 포맷에 맞게 문자형으로 변환

-- TO_CHAR
SELECT first_name, hire_date,
    TO_CHAR(hire_date, 'YY-MM-DD'),
    TO_CHAR(sysdate, 'YY-MM-DD HH@$:MI:SS')    
FROM employees;

SELECT TO_CHAR(3000000,'L999,999,999') FROM dual;

SELECT first_name, TO_CHAR(salary*12,'$999,999,999.00') "SAL"
FROM employees;

-- TO_NUMBER: 문자형 -> 숫자형
SELECT TO_NUMBER('2021'),
    TO_NUMBER('$1,450.13','$999,999.99')
FROM dual;

-- TO_DATE:문자형 -> 날짜형
SELECT TO_DATE('1999-12-31 23;59:59','YYYY-MM-DD HH24:MI:SS')
FROM dual;

--날짜 연산 
-- Date +(-) Number : 날짜에 일수 더하기 (빼기)
-- Date - Date : 두 Date 사이의 차이 일수
-- Date +(-) Number / 24: 날짜에 시간 더하기

SELECT TO_CHAR(sysdate, 'YY/MM/DD HH24:MI'),
    SYSDATE +1, -- 1일 뒤
    SYSDATE -1, -- 하루전
    SYSDATE - TO_DATE('19991231'),
    TO_CHAR(SYSDATE + 13/24,'YY/MM/DD HH24:MI') -- 13시간 후
FROM dual;


-------
--NULL
------

--NVL 함수

SELECT first_name,
    salary,
    commission_pct,
    salary *nvl(commission_pct,0) commission
FROM employees;

-- NVL2 함수
SELECT first_name,
    salary,
    commission_pct,
    salary *nvl2(commission_pct,salary*commission_pct,0) commission
FROM employees;

-- CASE 함수
-- AD 관련 직원에게는 20%,SA 관련 직원에게는 10%,
-- IT 관련 직원에게는 8%, 나머지는 5%
SELECT first_name,job_id, salary,SUBSTR(job_id, 1,2),
    CASE SUBSTR(job_id, 1,2) WHEN 'AD' THEN salary*0.2
                               WHEN 'SA' THEN salary*0.1
                               WHEN 'IT' THEN salary*0.8
                               ELSE salary * 0.5
            END bonus
FROM employees;

-- DECODE 함수

SELECT first_name,job_id,salary, SUBSTR(job_id, 1,2),
    DECODE (SUBSTR(job_id, 1,2),
            'AD', salary*0.2,
            'SA', salary*0.1,
            'IT', salary*0.08,
            salary * 0.05)
    bonus
FROM employees;


--연습문제
--직원의 이름,부서 ,팀을 출력
--팀
-- 부서코드 :10~30 ->A-Group
-- 부서코드 :40~50 ->B-Group
-- 부서코드 :60~100 ->C-Group
--  나미저: REMAINDER


SELECT first_name,department_id,
    CASE WHEN department_id <=30 THEN 'A-Group'
        WHEN department_id <=60 THEN 'B-Group'
        WHEN department_id <=100 THEN 'C-Group'
                         ELSE 'REMAINDER'
            END Team
FROM employees
ORDER BY department_id;
-- 1번
SELECT first_name||' '||last_name 이름,salary 월급,phone_number 전화번호,hire_date 입사일
FROM employees
ORDER BY hire_date;
-- 2번

SELECT job_id, job_title,max_salary
FROM jobs
ORDER BY max_salary DESC;

SELECT first_name,manager_id,commission_pct,salary
FROM employees
WHERE salary>=3000
       AND manager_id IS NOT NULL
       AND commission_pct IS NULL;

SELECT job_title,max_salary
FROM jobs
WHERE max_salary>10000
ORDER BY max_salary DESC;

SELECT first_name,nvl(commission_pct,0),salary
FROM employees
WHERE salary>=10000 AND salary<=14000
       AND commission_pct IS NULL
ORDER BY salary DESC;

SELECT first_name,
    salary,
    TO_CHAR(TO_DATE(hire_date,'YYYY-MM-DD'),'YYYY-MM-DD'),
    department_id
FROM employees
WHERE department_id = 10 OR
    department_id=90 OR
    department_id=100;
    
SELECT first_name,salary
FROM employees
WHERE first_name LIKE '%S%'
    OR first_name LIKE '%s%';
    
    
