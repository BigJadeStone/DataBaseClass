--�����Լ�
--ROUND(�ݿø�)
select ROUND(45.923,1), ROUND(45.923, 0 ), ROUND(45.923, -1) from dual;
--TRUNC(����)
select trunc(45.923,1), trunc(45.923, 0), trunc(45.923, -1) from dual;

--abs, ceil, floor
select abs(-24), ceil(3.14), floor(3.14) from dual;

--mod(������)
select mod(10, 3) as ������,
        10/3 as ��
from dual;

--��¥�Լ�
select sysdate from dual; --�����
select SYSTIMESTAMP from dual; --����Ͻú���

--��¥���� (����� �ϼ�)
select first_name, sysdate - hire_date from employees;
select first_name, (sysdate - hire_date)/7 as week from employees;
select first_name, (sysdate - hire_date)/365 as week from employees;

--trunc, round
select round(sysdate) from dual; --���� ��¥���� 12�ñ��� �ݿø�
select round(sysdate, 'year') from dual; --�� ���� �ݿø�
select round(sysdate, 'month') from dual; --�� ���� �ݿø�
select round(sysdate, 'day') from dual; --�ش� ���� �Ͽ���

select trunc(sysdate) from dual; -- ���糯¥���� ����
select trunc(sysdate, 'year') from dual; --�� ���� ����
select trunc(sysdate, 'month') from dual;--�� ���� ����
select trunc(sysdate, 'day') from dual; --�� ���� �Ͽ���

select * from employees where salary >= '5000';
