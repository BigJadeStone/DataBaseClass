select*
from employees;

select*
from departments;

select employee_id, first_name, last_name from employees;
select email, phone_number, hire_date,salary from employees;
--null
select employee_id, commission_pct from employees;

select employee_id, commission_pct, salary, salary + salary*0.5 from employees;


select employee_id as 아이디,
        commission_pct as 커미션,
        salary as 기본급여,
        salary + salary * 0.5 as 급여
from employees;

--문자열 연결 ||
SELECT first_name || ' ' || last_name || '''s salary is $' || salary AS 결과
FROM employees;

--distinct키워드
select department_id from employees;
select distinct department_id from employees; --중복제거

--rownum(조회되는 행의 번호), rowid(데이터의 주소)
select rownum, rowid, employee_id from employees;

--where
--job_id = 'it_prog'
select employee_id, job_id from employees where job_id = 'IT_PROG';
select * from employees where department_id = 90;
select * from employees where salary >= 12000;
select * from employees where hire_date = '04/10/01'; --날짜
select * from employees where hire_date >= '04/10/01'; --날짜
select * from employees where department_id <>90; -- 같지 않다

--between~and~
select * from employees where salary between 15000 and 20000;
--입사일 03년
select * from employees where hire_date between '03/01/01' and '03/12/31';

--in
select * from employees where manager_id in (101, 102, 103, 104);
select first_name, last_name, job_id, department_id FROM employees WHERE job_id IN('IT_PROG', 'FI_MGR', 'AD_VP');

--like (검색에활용)
select * FROM employees where job_id like 'IT%';
select * FROM employees WHERE job_id LIKE '%PROG';
SELECT * FROM employees where job_id LIKE '%IT%'; -- IT가 포함된

select * from employees where hire_date like '03%'; --03으로 시작하는
select * from employees where hire_date like '%15'; --15로 끝나는
select * from employees where hire_date like '%05%'; --05가 포함된
select * from employees where hire_date like '___05%';--05월 (언더바는 위치)

--null 데이터 조회
select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

--and, or
select * from employees where job_id = 'IT_PROG' or salary >= 5000;
select * from employees where job_id = 'IT_PROG' and salary >= 5000;
-- and가 or보다 우선순위가 빠름
select * from employees where (job_id = 'IT_PROG' or job_id = 'FI_MGR') and salary >= 6000;

--데이터 정렬 ( 구문의 마지막 )
select * from employees ORDER BY hire_date asc;
select * from employees ORDER BY hire_date desc;
--jo_id = it_prog인 사람들 이름 desc
select * from employees where job_id = 'IT_PROG' ORDER BY first_name desc;
--manager_id 가 120 이상인 사람들 중 salary 내림차순
select * from employees where manager_id >= 120 ORDER BY salary desc;
--여러컬럼 정렬
select * from employees order by department_id desc, manager_id asc;
--엘리어스명으로 정렬, 나중에 구문이 복잡해지면 안되는 경우도있음.
select employee_id, salary*12 as 연봉 from employees order by 연봉 desc;