--���̺����
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
--������ ����            
CREATE SEQUENCE SEQ_INFO;            
CREATE SEQUENCE SEQ_AUTH;
--������ ����            
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'java', 'java is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'jsp', 'jsp is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'spring', 'spring is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'oracle', 'oracle is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'mysql', 'mysql is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'c', 'c is');             

INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '���ο�', 'developer');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, 'ȫ����', 'DBA');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '�̼���', 'designer');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '��浿', 'scientist');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '���ο�', 'teacher');
------------------
select * from info;
select * from auth;

--INNER JOIN
SELECT * FROM info INNER JOIN auth on info.auth_id = auth.auth_id;
SELECT * FROM info LEFT OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM info RIGHT OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM info FULL OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM INFO CROSS JOIN AUTH;

--auth_id�� ���� ���̺� �����ϱ� ������ ���̺�.�÷������� ��Ī�ؾ� �մϴ�.
SELECT id, title, info.auth_id, name, job
From info INNER JOIN auth on info.auth_id = auth.auth_id;

--���̺� ������� �̿��� ���� 
select  i.title,
        i.regdate,
        i.auth_id,
        a.name
FROM info i INNER JOIN auth a ON i.auth_id = a.auth_id;

--����
SELECT *
FROM info i INNER JOIN auth a on i.auth_id = a.auth_id
WHERE i.auth_id = 1;

--using (Ű)�� ���� ����
SELECt *
FROM info i INNER JOIN auth a using(auth_id);

--���� ���̺� ����
select * from employees;
select * from departments;
select * from locations;

SELECT *
FROM employees e
LEFT OUTER JOIN departments d ON e.department_id = d.department_id
LEFT OUTER JOIN LOCATIONS l on d.location_id = l.location_id;

--SELF JOIN (�ϳ��� ���̺�� ����)
SELECT  NVL(E2.FIRST_NAME,'����') AS ���,
        E1.FIRST_NAME AS ����
from employees e1 left outer join employees e2 on e1.manager_id = e2.employee_id
order by e1.employee_id;


--���� 1.
---EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
---EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
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

--���� 2.
---EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT  concat(first_name||' ', last_name),
        d.Department_name
from Employees e
INNER JOIN Departments d ON e.Department_id = d.Department_id
where Employee_id = 200;

--���� 3.
---EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
select *
from employees;

select*
from jobs;

select  concat(first_name||' ', last_name) as �̸�,
        e.job_id,
        j.job_title
from Employees e
INNER JOIN JOBS j ON e.job_id = j.job_id
order by �̸� asc;

--���� 4.
----JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
select *
from JOBS;

select *
from JOB_HISTORY;

select *
from Jobs j
LEFT OUTER JOIN JOB_HISTORY h ON j.JOB_ID = h.JOB_ID;

--���� 5. ��
----Steven King�� �μ����� ����ϼ���.
select  concat(first_name||' ', last_name) as �̸�,
        Department_id,
        Department_title
from Employees e
LEFT OUTER JOIN Departments d on 
where First_name||last_name = 'StevenKing';

--���� 6.
----EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
select  e.last_name,
        e.first_name,
        e.department_id,
        d.department_name
from Employees e
CROSS JOIN Departments d;

--���� 7.
----EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
select *
from departments;

select  e.employee_id as �����ȣ,
        concat(e.first_name||' ', e.last_name) as �̸�,
        e.salary as �޿�,
        d.Department_id as �μ���,
        d.location_id as �ٹ���,
        l.street_address
from Employees e
LEFT JOIN Departments d ON e.department_id = d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id
where e.Job_id = 'SA_MAN';

--���� 8.��
---- employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.
select Employee_id, first_name, last_nmae, job_title
from employees e
INNER join Jobs j ON e.job_id = j.job_id
and job_title IN ('Stock Manager', 'Stock Clerk');

--���� 9. 
---- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
select *
from departments d
LEFT OUTER JOIN Employees e 
ON  d.Department_id = e.Department_id
where e.Employee_id is null;


--���� 10. 
---join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
select  concat(e2.first_name||' ', e2.last_name) as �Ŵ����̸�,
        concat(e.first_name||' ', e.last_name) as ����̸�
from Employees e
join Employees e2 ON  e.manager_id = e2.employee_id;

--���� 11. 
----6. EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
----�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
select *
from employees;

select  concat(e1.first_name||' ', e1.last_name) as ����̸�,
        concat(e2.first_name||' ', e2.last_name) as ������,
        e2.salary as �Ŵ����޿�
from Employees e1
LEFT OUTER JOIN Employees e2 
ON e1.manager_id = e2.Employee_id
where e1.Manager_id is not null
order by e2.salary desc;

--�̹��� ����.
--self join 2��, case when then  / ���-�Ʒ�-�Ʒ� ���

---------------------------------------------------------------------------------------------
--����Ŭ ����(����Ŭ�� ����ϴ� ����)
--inner
select * from employees e, departments d --�������̺�
where e.department_id = d.department_id; --����Ű
--LEFT OUTER
select * from employees e, departments d --�������̺�
where e.department_id = d.department_id(+); --����Ű, ���� ���̺� �����ΰ� �����ʿ� �ִ°� ���̰ڴ�.
--LIGHT OUTER
select * from employees e, departments d --�������̺�
where e.department_id(+) = d.department_id; --����Ű, ������ ���̺� �����ΰ� ���ʿ� �ִ°� ���̰ڴ�.

--�����ִ� ����Ŭ ����
select * from employees e, departments d --�������̺�
where e.department_id(+) = d.department_id; --����Ű
and first_name = 'Pat'; --����
---------------------------------------------------------------------------------------------
