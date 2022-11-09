--���ڿ� �Լ�
--lower(�ҹ���), initcap(�ձ��ڸ� �빮��), upper(�빮��)
select 'abcDEF', lower('abcDEF'), upper('abcDEF'), initcap('abcDEF') from dual;

select last_name, lower(last_name), initcap(last_name), upper(last_name) from employees;

select * from employees where lower(last_name) = 'king';

--length(����), instr(���� ã��)
select first_name, length(first_name), instr(first_name, 'a') from employees;

--substr(���ڿ� �ڸ���), concat(���ڿ���)
select 'abcdef', substr('abcdef', 3), substr('abcdef', 1, 3) from dual;
select first_name, substr(first_name, 1, 3) from employees;

--
select 'abc' || 'def' from dual;
select concat('abc', 'def') from dual;
select concat(first_name, last_name) as name from employees;
select concat(concat(first_name, ' '), last_name) as name from employees;

--LPAD, RPAD
select LPAD('abc', 10,'*') from dual;
select RPAD('abc', 10, '*')from dual;
select lpad(first_name, 10, '-') from employees;

--LTRIM, RTRIM, TRIM (��������)
select LTRIM('   javascript_java') from dual; --������������
select lTRIM('javascript_java', 'java') from dual; --��������

select RTRIM('javascript_java   ') from dual; --������������
select RTRIM('javascript_java', 'java')from dual; --��������

select trim('   js   ') from dual;--���ʰ�������

--replace
select REPLACE('my dream is a president','president','doctor') from dual;
select REPLACE('my dream is a president',' ','') from dual;

select replace(REPLACE('my dream is a president','president','doctor'),' ' ,'') from dual;

---------------------------------------------------------------------------------------
--���� 1.
--EMPLOYEES ���̺� ���� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
--���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
--���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
select concat(first_name, last_name)as �̸�, replace(hire_date, '/','') as �Ի����� from employees order by �̸� asc;

--���� 2.
--EMPLOYEES ���̺� ���� phone_numbe�÷��� ###.###.####���·� ����Ǿ� �ִ�
--���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���
select concat( '(02)',substr(phone_number, 4, length(phone_number) )) 
from employees;

--���� 3. 
--EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
--���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
--���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
--�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
--���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
--�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
select RPAD(substr(First_name, 1, 3), length(First_name), '*') as name, 
LPAD(salary, 10, '*') as salary 
from employees 
where lower(JOB_ID) = 'it_prog';


