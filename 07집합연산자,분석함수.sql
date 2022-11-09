--���տ����� (�� �Ʒ� column������ ��Ȯ�� ��ġ�ؾ� ��)
--union(������ �ߺ�x), union all(������ �ߺ�o), intersect(������), minus(������)

select employee_id, first_name from employees where hire_date like '04%'
union
select employee_id, first_name from employees where department_id = 20;

select employee_id, first_name from employees where hire_date like '04%'
union all
select employee_id, first_name from employees where department_id = 20;

select employee_id, first_name from employees where hire_date like '04%'
intersect
select employee_id, first_name from employees where department_id = 20;

select employee_id, first_name from employees where hire_date like '04%'
minus
select employee_id, first_name from employees where department_id = 20;

----
select employee_id, first_name, salary from employees where department_id = 20
union all
select employee_id, first_name, salary from employees where salary > 10000
union all
select 300, 'hong', 20000 from dual;

------------------------------------------------------------------
-- �м��Լ�() over(����)
SELECT  EMPLOYEE_ID,
        DEPARTMENT_ID,
        SALARY,
        RANK() OVER(ORDER BY SALARY DESC) AS �ߺ�����O,
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS �ߺ�����X,
        ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS �Ϸù�ȣ,
        rownum as ��ȸ�ȼ��� -- rownum�� ��ȸ�� ����
FROM EMPLOYEES
ORDER BY SALARY DESC; 
