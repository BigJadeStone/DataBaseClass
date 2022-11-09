--����ȯ�Լ�
select to_char(sysdate, 'YYYY-MM-DD') from dual;
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS') from dual;
select to_char(sysdate, 'YY-MM-DD HH:MI:SS Month') from dual;

select first_name, to_char(hire_date, 'YYYY-MM-DD HH:MI:SS') from employees;
select first_name, to_char(hire_date, 'YYYY"��"MM"��"DD"��"') from employees;

--���ڸ� ���ڷ�
select to_char(20000, '99999') || '��' from dual; --�ڸ���
select to_char(20000, '9999') || '��' from dual; --�ڸ�������

select to_char(20000.14, '99999.99') from dual; --�Ҽ���
select to_char(20000.14, '99999') from dual;

select to_char(20000.14, '999,999,999') from dual;

select to_char(salary, '$999,999') as salary  from employees;
select to_char(salary, 'L999,999') as salary from employees;
--salary�� ���� ȯ���� ���缭 �ѱ������� ǥ�� 1364
select to_char(salary * 1364, 'L999,999,999') from employees;

--to_number (���ڸ� ���ڷ�)
select '2000' + 2000 from dual; --�ڵ�����ȯ
select to_number('20000') + 2000 from dual; --����� ��ȯ
select '$3,000' + 3000 from dual; --����
select to_number('$3,000', '$9,999') + 3000 from dual; 

--to_date(���ڸ� ��¥��)
select sysdate - '2022-08-01' from dual;
select sysdate - to_date('2022-08-01') from dual; -- ok
select sysdate - to_date('2022-08-01', 'YYYY-MM-DD') from dual; --ok
select TO_DATE('2020-03-31 12:23:03', 'YYYY-MM-DD HH:MI:SS') from dual;

-- xxxx��xx��xx�� ���ڿ� �������� ��ȯ�ϼ���
--���ڸ� date�� ġȯ�ϰ� �ٲ� date���� �ٽ� ���Ŀ� �°� ���ڷ� �ٲ��ָ��.
select to_char(to_date('20050102', 'YYYY-MM-DD'), 'YYYY"��"MM"��"DD"��"') from dual;
select to_char(to_date('20050102'), 'YYYY"��"MM"��"DD"��"') from dual;

--NVL (null�� ����ó��)
select NVL(null, 0) , NVL(3.14, 0) from dual;
SELECT NVL(commission_pct, 0) from employees; --commission_pct�� null�̶�� 0���� �ٲ���.

--NVL2 (�÷�, null�� �ƴҰ�� ��, null�� ��� ��)
select NVL2(null, '�ξƴ�', '��') from dual;
select first_name,
        salary,
        commission_pct,
        NVL2(commission_pct, salary+(salary*commission_pct), salary) 
from employees;

--DECODE(if~~)
select decode('a', 'a', 'a�Դϴ�', 'a�� �ƴմϴ�') from dual;

select DECODE('C', 'A', 'A�Դϴ�',
                    'B', 'B�Դϴ�',
                    'C', 'C�Դϴ�',
                    '���� �ƴմϴ�') from dual;
                    
select job_id,
        salary,
        DECODE(job_id, 'IT_PROG', salary*1.1, 'FI_MGR', salary*1.2, 'AD_VP', salary*1.3, salary)
from employees;

--case when then else end
select job_id,
        salary,
        case job_id when 'IT_PROG' then salary*1.1
                    when 'FI_MGR'  then salary*1.2
                    when 'AD_VP'   then salary*1.3
                    else salary
        end as result
from employees;
--
select job_id,
        salary,
        case  when job_id = 'IT_PROG' then salary*1.1
              when job_id = 'FI_MGR'  then salary*1.2
              when job_id = 'AD_VP'   then salary*1.3
              else salary
        end as result
from employees;
-----------------------------------------------------------------------
--���� 1.
--�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 10�� �̻���
--����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
--���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�
select  employee_id as �����ȣ, 
        concat(first_name || ' ', last_name) as �����,
        hire_date as �Ի�����,
        trunc((sysdate - hire_date)/365) as �ټӳ�� 
from employees 
order by �ټӳ�� desc; --order by �� �ٸ���� ��밡��, �ֳ��ϸ� select���� ��ȸ�� �����ڿ� ������ �Ǳ� ����.

--���� 2.
--EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
--100�̶�� �������, 
--120�̶�� �����ӡ�
--121�̶�� ���븮��
--122��� �����塯
--�������� ���ӿ��� ���� ����մϴ�.
--���� 1) Department_id�� 50�� ������� ������θ� ��ȸ�մϴ�
select * from employees;
select  first_name,
        manager_id,
        case MANAGER_ID when 100 then '���'
                        when 120 then '����'
                        when 121 then '�븮'
                        when 122 then '����'
                        else '�ӿ�'
                    end as ����
from employees where DEPARTMENT_id >= 50;        