--��������
--�������� ����� ()�ȿ� �����, ������������ �������� 1�� ���Ͽ��� �մϴ�
--�������� ������ ���� ����� '�ϳ�' �ݵ�� ��� �����մϴ�.
--(������������ ���� �ؼ��ϸ� �˴ϴ�)

--nancy�� �޿�
select salary from employees where first_name = 'Nancy';

select * 
from employees 
where salary >= (select salary from employees where first_name = 'Nancy');

--employee_id�� 104���� ����� job)id�� ������ ����� �˻��ϴ� ����
select job_id from employees where employee_id = 104;

select * 
from employees 
where job_id = (select job_id 
                from employees 
                where employee_id = 104);
--------------------------------------------------------------------------------
--���������� ����� ������ ���, ������ �����ڸ� ����� �� ����.
--�̷� ���� ������ �������� �����ڸ� �̿��ؼ� ó���ؾ��մϴ�.
select Employee_id
from employees
where job_id = 'IT_PROG';

select *
from employees
where employee_id >= (select Employee_id from employees where job_id = 'IT_PROG');
--------------------------------------------------------------------------------
--������ �������� in, any, all
SELECT SALARY
FROM Employees
where First_name = 'David';

--IN
SELECT *
FROM employees
where Salary in (SELECT Salary From Employees where First_name = 'David');

--4800,6800,9500
--ANY - �ּҰ� ���� ū OR �ִ밪 ���� ����
SELECT *
FROM employees
where Salary < Any (select salary from employees where first_name = 'David');
                        
--ALL - �ִ밪 ���� ū OR �ּҰ� ���� ���� ���
SELECT *
FROM employees
Where Salary < All (Select salary From employees where first_name = 'David');

--First_name �� Steven�� ����� �޿����� ���� ���
select *
from employees where first_name = 'Steven';

Select *
from employees
where salary < ANY(select salary from employees where first_name = 'Steven');

------------------------------------------------------------------------------------
--��Į�� ��������(select ������ ���������� ���� ��, LEFT OUTER�����̶� ���� ���)
--
select first_name, department_name
from employees e
left outer join departments d on e.department_id = d.department_id
order by first_name asc;

SELECT FIRST_NAME,
        (SELECT Department_Name From departments D WHERE E.Department_ID = D.Department_ID) as DEPARTMENT_NAME,
        (SELECT LOCATION_ID From departments D WHERE E.Department_ID = D.Department_ID) as LOCATIONI_ID
FROM Employees E
ORDER BY FIRST_NAME ASC;

--
--�� �μ��� �Ŵ������� �̸�
--left join
select  d.*,
        e.first_name
from departments d
left outer join employees e
on d.manager_id = e.employee_id
order by d.manager_id;
--��Į��, ������ �Ǵ� ���̺��� ���� ���صΰ� �� ������ ��Į�� Ŀ������ �ۼ��ϱ�
select  d.*,
        (select first_name from employees e where d.manager_id = e.employee_id)
from departments d
order by d.manager_id;
----------------------------------------------------------------------------------------
--LEFT JOIN
SELECT  e1.*,
        d.department_name as �����Ǻμ�,
        e2.first_name as �Ŵ����̸�
FROM employees e1
left outer join employees e2 on e1.manager_id = e2.employee_id
left outer join departments d on e1.department_id = d.department_id;
--scalar
select  e1.*,
        (select department_name from departments d where e1.department_id = d.department_id) as �����Ǻμ�,
        (select first_name from employees e2 where e1.manager_id = e2.employee_id) as �Ŵ����̸�
From employees e1;
--�μ��� �����
select  department_id,
        count(*) 
from employees Group by Department_id --�̰� ��Į�� ������ �־��ָ��.
order by department_id asc;

select  d.*,
        (select count(*) from Employees e where d.Department_id =e.Department_id Group by department_id) as �μ��������
from Departments d;

