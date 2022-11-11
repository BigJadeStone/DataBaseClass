--테이블생성
CREATE TABLE INFO 
(
  ID NUMBER NOT NULL 
, TITLE VARCHAR2(100) 
, CONTENT VARCHAR2(100) 
, REGDATE DATE DEFAULT sysdate NOT NULL 
, CONSTRAINT INFO_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);
   
CREATE TABLE auth 
(
  AUTH_ID NUMBER NOT NULL 
, NAME VARCHAR2(30) 
, JOB VARCHAR2(30) 
, CONSTRAINT TABLE1_PK PRIMARY KEY 
  (
    AUTH_ID 
  )
  ENABLE 
);            
--시퀀스 생성            
CREATE SEQUENCE SEQ_INFO;            
CREATE SEQUENCE SEQ_AUTH;
--데이터 삽입            
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'java', 'java is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'jsp', 'jsp is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'spring', 'spring is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'oracle', 'oracle is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'mysql', 'mysql is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'c', 'c is');             

INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '박인욱', 'developer');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '홍길자', 'DBA');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '이순신', 'designer');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '고길동', 'scientist');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '박인욱', 'teacher');
------------------
select * from info;
select * from auth;

--INNER JOIN
SELECT * FROM info INNER JOIN auth on info.auth_id = auth.auth_id;
SELECT * FROM info LEFT OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM info RIGHT OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM info FULL OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM INFO CROSS JOIN AUTH;

--auth_id는 양쪽 테이블에 존재하기 때문에 테이블.컬럼명으로 지칭해야 합니다.
SELECT id, title, info.auth_id, name, job
From info INNER JOIN auth on info.auth_id = auth.auth_id;

--테이블 엘리어스를 이용한 조인 
select  i.title,
        i.regdate,
        i.auth_id,
        a.name
FROM info i INNER JOIN auth a ON i.auth_id = a.auth_id;

--조건
SELECT *
FROM info i INNER JOIN auth a on i.auth_id = a.auth_id
WHERE i.auth_id = 1;

--using (키)를 통한 조인
SELECt *
FROM info i INNER JOIN auth a using(auth_id);

--여러 테이블 조인
select * from employees;
select * from departments;
select * from locations;

SELECT *
FROM employees e
LEFT OUTER JOIN departments d ON e.department_id = d.department_id
LEFT OUTER JOIN LOCATIONS l on d.location_id = l.location_id;

--SELF JOIN (하나의 테이블로 조인)
SELECT  NVL(E2.FIRST_NAME,'없음') AS 상사,
        E1.FIRST_NAME AS 직원
from employees e1 left outer join employees e2 on e1.manager_id = e2.employee_id
order by e1.employee_id;


--문제 1.
---EMPLOYEES 테이블과, DEPARTMENTS 테이블은 DEPARTMENT_ID로 연결되어 있습니다.
---EMPLOYEES, DEPARTMENTS 테이블을 엘리어스를 이용해서
--각각 INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER 조인 하세요. (달라지는 행의 개수 확인)
SELECT *
from Employees e
INNER JOIN Departments d on e.Department_id = d.Department_id; 

SELECT *
from Employees e
LEFT OUTER JOIN Departments d on e.Department_id = d.Department_id;

SELECT *
from Employees e
RIGHT OUTER JOIN Departments d on e.Department_id = d.Department_id;

SELECT *
from Employees e
FULL OUTER JOIN Departments d ON e.Department_id = d.Department_id;

--문제 2.
---EMPLOYEES, DEPARTMENTS 테이블을 INNER JOIN하세요
--조건)employee_id가 200인 사람의 이름, department_id를 출력하세요
--조건)이름 컬럼은 first_name과 last_name을 합쳐서 출력합니다
SELECT  concat(first_name||' ', last_name),
        d.Department_name
from Employees e
INNER JOIN Departments d ON e.Department_id = d.Department_id
where Employee_id = 200;

--문제 3.
---EMPLOYEES, JOBS테이블을 INNER JOIN하세요
--조건) 모든 사원의 이름과 직무아이디, 직무 타이틀을 출력하고, 이름 기준으로 오름차순 정렬
--HINT) 어떤 컬럼으로 서로 연결되 있는지 확인
select *
from employees;

select*
from jobs;

select  concat(first_name||' ', last_name) as 이름,
        e.job_id,
        j.job_title
from Employees e
INNER JOIN JOBS j ON e.job_id = j.job_id
order by 이름 asc;

--문제 4.
----JOBS테이블과 JOB_HISTORY테이블을 LEFT_OUTER JOIN 하세요.
select *
from JOBS;

select *
from JOB_HISTORY;

select *
from Jobs j
LEFT OUTER JOIN JOB_HISTORY h ON j.JOB_ID = h.JOB_ID;

--문제 5. ★
----Steven King의 부서명을 출력하세요.
select  concat(first_name||' ', last_name) as 이름,
        Department_id,
        Department_title
from Employees e
LEFT OUTER JOIN Departments d on 
where First_name||last_name = 'StevenKing';

--문제 6.
----EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian Product(Cross join)처리하세요
select  e.last_name,
        e.first_name,
        e.department_id,
        d.department_name
from Employees e
CROSS JOIN Departments d;

--문제 7.
----EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호, 이름, 
--급여, 부서명, 근무지를 출력하세요. (Alias를 사용)
select *
from departments;

select  e.employee_id as 사원번호,
        concat(e.first_name||' ', e.last_name) as 이름,
        e.salary as 급여,
        d.Department_id as 부서명,
        d.location_id as 근무지,
        l.street_address
from Employees e
LEFT JOIN Departments d ON e.department_id = d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id
where e.Job_id = 'SA_MAN';

--문제 8.★
---- employees, jobs 테이블을 조인 지정하고 job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보만
--출력하세요.
select Employee_id, first_name, last_nmae, job_title
from employees e
INNER join Jobs j ON e.job_id = j.job_id
and job_title IN ('Stock Manager', 'Stock Clerk');

--문제 9. 
---- departments 테이블에서 직원이 없는 부서를 찾아 출력하세요. LEFT OUTER JOIN 사용
select *
from departments d
LEFT OUTER JOIN Employees e 
ON  d.Department_id = e.Department_id
where e.Employee_id is null;


--문제 10. 
---join을 이용해서 사원의 이름과 그 사원의 매니저 이름을 출력하세요
--힌트) EMPLOYEES 테이블과 EMPLOYEES 테이블을 조인하세요.
select  concat(e2.first_name||' ', e2.last_name) as 매니저이름,
        concat(e.first_name||' ', e.last_name) as 사원이름
from Employees e
join Employees e2 ON  e.manager_id = e2.employee_id;

--문제 11. 
----6. EMPLOYEES 테이블에서 left join하여 관리자(매니저)와, 매니저의 이름, 매니저의 급여 까지 출력하세요
----매니저 아이디가 없는 사람은 배제하고 급여는 역순으로 출력하세요
select *
from employees;

select  concat(e1.first_name||' ', e1.last_name) as 사원이름,
        concat(e2.first_name||' ', e2.last_name) as 관리자,
        e2.salary as 매니저급여
from Employees e1
LEFT OUTER JOIN Employees e2 
ON e1.manager_id = e2.Employee_id
where e1.Manager_id is not null
order by e2.salary desc;

--이번주 숙제.
--self join 2번, case when then  / 상사-아래-아래 출력

---------------------------------------------------------------------------------------------
--오라클 조인(오라클만 사용하는 문법)
--inner
select * from employees e, departments d --조인테이블
where e.department_id = d.department_id; --조인키
--LEFT OUTER
select * from employees e, departments d --조인테이블
where e.department_id = d.department_id(+); --조인키, 왼쪽 테이블 세워두고 오른쪽에 있는걸 붙이겠다.
--LIGHT OUTER
select * from employees e, departments d --조인테이블
where e.department_id(+) = d.department_id; --조인키, 오른쪽 테이블 세워두고 왼쪽에 있는걸 붙이겠다.

--조건있는 오라클 조인
select * from employees e, departments d --조인테이블
where e.department_id(+) = d.department_id; --조인키
and first_name = 'Pat'; --조건
---------------------------------------------------------------------------------------------
