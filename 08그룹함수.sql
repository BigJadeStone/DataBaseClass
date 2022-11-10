--�׷� �Լ� AVG, MAX, MIN, SUM, COUNT
select AVG(salary), MAX(salary), MIN(salary), SUM(salary), count(*) from employees;

SELECT max(hire_Date), min(hire_date) from employees; --��¥���� ����

--count(*), count(�÷�)
select count(*) from employees; --�� �� �������� ��
select count(commission_pct), count(manager_id) from employees; --null�� �ƴ� ���� ��

--������ ��: �׷��Լ��� �Ϲ� �÷��� ���ÿ� ��� �Ұ�.
--SELECT employee_id, sum(salary) from employees;

---------------------------------------------------------------------------
--�μ��� �޿����
select department_id, avg(salary) from employees group by department_id;

--group���� ������ ���� �÷��� select���� ���Ұ� (�����ͺ��̽����� �ٸ�)
select job_id, deparyment_id from employees group by department_id;

--2�� �̻��� �׷���
select department_id, job_id, sum(salary)
from employees 
group by department_id, job_id 
order by department_id desc;

select  department_id,
        job_id,
        sum(salary),
        count(*), --�׷캰 ��
        count(*) over() -- ��ü��� ,�߸����� sql�� �������� ������ ����.
from employees
group by department_id, job_id
order by department_id desc;

select  department_id,
        job_id,
        count(*) over() --��ü�� �� (�׷���� ��밡��)
from employees;

--where���� �׷��Լ� ���Ұ�
select deparyment_id
from employees
where sum(salary) >= 5000 
GROUP by deparyment_id;

---------------------------------------------------------------------------------------------------
--having (�׷��� ����)
select deparyment_id, sum(salary)
from employees
group by deparyment_id
having sum(salary) > 100000;

select job_id, count(*)
from employees
group by job_id
having count(*) >= 20;

--�μ� ���̵� 50�̻��� �͵��� �׷�ȭ ��Ű��, �׷� ����� 5000�̻� ��ȸ, ���� ��ճ�������
select department_id, trunc(avg(salary))
from employees
where department_id >=50
GROUP BY department_id
having avg(salary)>=5000
order by avg(salary) desc;

--���� SA�� ���Ե� �������� �׷캰 �����, �׷캰 �޿���, �������ֱ�, �׷����� job_id��
select job_id, count(*) as �����, sum(salary) as �޿���
from employees
where job_id like 'SA%'
group by job_id
order by sum(salary) asc;

--------------------------------------------------------------------------------
--�Ѿ� - �ֱ׷��� ��Ż
--�׷��� 1�� -> �Ѱ����
select department_id,
        sum(salary)
from employees
group by rollup(department_id)
order by department_id;

--�׷��� 2�� -> �Ѱ�� �ֱ׷��� ��Ż
select department_id, job_id, avg(salary), count(salary)
from employees
group by rollup(department_id, Job_id)
order by department_id, job_id;

--ť�� - ����׷������ ��Ż (���� �� �ִ� �����)
select department_id, job_id, avg(salary), count(salary)
from employees
group by cube(department_id, Job_id)
order by department_id, job_id;

--GROUPING-
select  department_id, 
        DECODE (GROUPING(JOB_ID), 1, '�Ұ�', job_id),
        avg(salary), 
        count(salary),
        Grouping(Department_id),
        Grouping(JOB_ID)
from employees
group by ROLLUP(department_id, Job_id)
order by department_id, job_id;

--------------------------------------------------------------------------------
--���� 1.
--��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
--��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���
select  Job_id, 
        count(*) as �����, 
        avg(salary) �������
from employees
GROUP BY JOB_ID
ORDER BY avg(salary) desc;

--���� 2.
--��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
select  to_char(hire_date, 'YY'),
        count(*) �����
from employees
GROUP BY to_char(hire_date, 'YY')
order by to_char(hire_date, 'YY') asc;

--���� 3.
--�޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 2000�̻��� �μ��� ���
select  department_id,
        avg(salary)
from employees
where salary >= 1000
GROUP BY department_id
HAVING avg(salary) >= 2000
order by avg(salary) desc;

--���� 4.
--��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
--department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
--���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
--���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
select  department_id,
        trunc(avg(salary+salary*commission_pct),2),
        sum(salary + salary*commission_pct),
        count(*)
from employees
where commission_pct is not null
group by department_id;


--���� 5.
--������ ������, ���հ踦 ����ϼ���
select  DECODE(GROUPING(job_id), 1, '�հ�', JOB_ID), 
        sum(salary)
from employees
GROUP BY ROLLUP(Job_Id);

--���� 6.�μ���, JOB_ID�� �׷��� �Ͽ� ��Ż, �հ踦 ����ϼ���.
--GROUPING() �� �̿��Ͽ� �Ұ� �հ踦 ǥ���ϼ���.
select  DECODE (GROUPING(department_id), 1, '�հ�', department_id) as Department_id,
        DECODE (GROUPING(JOB_ID), 1, '�Ұ�', job_id) as job_id,
        count(*) as TOTAL,
        sum(salary) as sum
from employees
GROUP By RollUP(Department_id, Job_id)
order by sum asc;



