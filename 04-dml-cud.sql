--
--CUD
--

--INSERT : 묵시적 방법
DESC author;

INSERT INTO author
VALUES (1, '박경리', '토지 작가');

--INSERT : 명시적 방법(컬럼명시)
INSERT INTO author (author_id, author_name)
VALUES (2, '김명하'); 
--생략은 NULL로 전달 됩니다.

-- 확인
SELECT * FROM author;

--DML은 트랜잭션의 대상
--취소: ROLLBACK
--변경사항 반영: COMMIT
ROLLBACK;
COMMIT;

--UPDATE
--기존 레코드의 내용 변경
UPDATE author
SET author_desc='소설가'; //조건절이 없는 UPDATE AND DELETE 는 위험하다.

SELECT * FROM author;
ROLLBACK;

--조건절 없으면 전체 레코드각 영향을 받는다.
UPDATE author
SET author_desc='소설가'
WHERE author_name='김명하';

COMMIT;

--연습
--HR.employees -> department_id가 10,20,30
--새 테이블 생성
CREATE TABLE emp123 AS
    SELECT * FROM HR.employees;
    
    DESC EMP123;
    
UPDATE emp123
SET salary = salary +salary*0.1
WHERE department_id = 30;

COMMIT;

-- DELETE : 테이블에서 레코드 삭제
SELECT * FROM emp123;


--JOB_ID MK_사원들 삭제

DELETE FROM emp123 
WHERE job_id LIKE 'MK_%';

-- 연습문제 현재 급여 평균보다 높은 사람 모두 삭제하기

DELETE FROM emp123
WHERE salary > (SELECT AVG(salary) FROM emp123);

SELECT * FROM emp123;

COMMIT;

--TRUNCATE 와 DELETE 
--DELETE는 ROLLBACK 의 대상
--TRUNCATE 는 ROLLBACK X

DELETE FROM emp123;
SELECT * FROM emp123;
ROLLBACK;

TRUNCATE * FROM emp123;