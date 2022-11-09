select*
from employees;

select*
from departments;

select employee_id, first_name, last_name from employees;
select email, phone_number, hire_date,salary from employees;
--null
select employee_id, commission_pct from employees;

select employee_id, commission_pct, salary, salary + salary*0.5 from employees;


select employee_id as ���̵�,
        commission_pct as Ŀ�̼�,
        salary as �⺻�޿�,
        salary + salary * 0.5 as �޿�
from employees;

--���ڿ� ���� ||
SELECT first_name || ' ' || last_name || '''s salary is $' || salary AS ���
FROM employees;

--distinctŰ����
select department_id from employees;
select distinct department_id from employees; --�ߺ�����

--rownum(��ȸ�Ǵ� ���� ��ȣ), rowid(�������� �ּ�)
select rownum, rowid, employee_id from employees;

--where
--job_id = 'it_prog'
select employee_id, job_id from employees where job_id = 'IT_PROG';
select * from employees where department_id = 90;
select * from employees where salary >= 12000;
select * from employees where hire_date = '04/10/01'; --��¥
select * from employees where hire_date >= '04/10/01'; --��¥
select * from employees where department_id <>90; -- ���� �ʴ�

--between~and~
select * from employees where salary between 15000 and 20000;
--�Ի��� 03��
select * from employees where hire_date between '03/01/01' and '03/12/31';

--in
select * from employees where manager_id in (101, 102, 103, 104);
select first_name, last_name, job_id, department_id FROM employees WHERE job_id IN('IT_PROG', 'FI_MGR', 'AD_VP');

--like (�˻���Ȱ��)
select * FROM employees where job_id like 'IT%';
select * FROM employees WHERE job_id LIKE '%PROG';
SELECT * FROM employees where job_id LIKE '%IT%'; -- IT�� ���Ե�

select * from employees where hire_date like '03%'; --03���� �����ϴ�
select * from employees where hire_date like '%15'; --15�� ������
select * from employees where hire_date like '%05%'; --05�� ���Ե�
select * from employees where hire_date like '___05%';--05�� (����ٴ� ��ġ)

--null ������ ��ȸ
select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

--and, or
select * from employees where job_id = 'IT_PROG' or salary >= 5000;
select * from employees where job_id = 'IT_PROG' and salary >= 5000;
-- and�� or���� �켱������ ����
select * from employees where (job_id = 'IT_PROG' or job_id = 'FI_MGR') and salary >= 6000;

--������ ���� ( ������ ������ )
select * from employees ORDER BY hire_date asc;
select * from employees ORDER BY hire_date desc;
--jo_id = it_prog�� ����� �̸� desc
select * from employees where job_id = 'IT_PROG' ORDER BY first_name desc;
--manager_id �� 120 �̻��� ����� �� salary ��������
select * from employees where manager_id >= 120 ORDER BY salary desc;
--�����÷� ����
select * from employees order by department_id desc, manager_id asc;
--����������� ����, ���߿� ������ ���������� �ȵǴ� ��쵵����.
select employee_id, salary*12 as ���� from employees order by ���� desc;