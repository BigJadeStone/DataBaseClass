--숫자함수
--ROUND(반올림)
select ROUND(45.923,1), ROUND(45.923, 0 ), ROUND(45.923, -1) from dual;
--TRUNC(절삭)
select trunc(45.923,1), trunc(45.923, 0), trunc(45.923, -1) from dual;

--abs, ceil, floor
select abs(-24), ceil(3.14), floor(3.14) from dual;

--mod(나머지)
select mod(10, 3) as 나머지,
        10/3 as 몫
from dual;

--날짜함수
select sysdate from dual; --년월일
select SYSTIMESTAMP from dual; --년월일시분초

--날짜연산 (결과는 일수)
select first_name, sysdate - hire_date from employees;
select first_name, (sysdate - hire_date)/7 as week from employees;
select first_name, (sysdate - hire_date)/365 as week from employees;

--trunc, round
select round(sysdate) from dual; --현재 날짜에서 12시기준 반올림
select round(sysdate, 'year') from dual; --년 기준 반올림
select round(sysdate, 'month') from dual; --월 기준 반올림
select round(sysdate, 'day') from dual; --해당 주의 일요일

select trunc(sysdate) from dual; -- 현재날짜까지 절삭
select trunc(sysdate, 'year') from dual; --년 기준 절삭
select trunc(sysdate, 'month') from dual;--월 기준 절삭
select trunc(sysdate, 'day') from dual; --전 주의 일요일

select * from employees where salary >= '5000';
