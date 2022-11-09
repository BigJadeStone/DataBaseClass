--문자열 함수
--lower(소문자), initcap(앞글자만 대문자), upper(대문자)
select 'abcDEF', lower('abcDEF'), upper('abcDEF'), initcap('abcDEF') from dual;

select last_name, lower(last_name), initcap(last_name), upper(last_name) from employees;

select * from employees where lower(last_name) = 'king';

--length(길이), instr(문자 찾기)
select first_name, length(first_name), instr(first_name, 'a') from employees;

--substr(문자열 자르기), concat(문자연결)
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

--LTRIM, RTRIM, TRIM (공백제거)
select LTRIM('   javascript_java') from dual; --좌측공백제거
select lTRIM('javascript_java', 'java') from dual; --좌측제거

select RTRIM('javascript_java   ') from dual; --우측공백제거
select RTRIM('javascript_java', 'java')from dual; --우측제거

select trim('   js   ') from dual;--양쪽공백제거

--replace
select REPLACE('my dream is a president','president','doctor') from dual;
select REPLACE('my dream is a president',' ','') from dual;

select replace(REPLACE('my dream is a president','president','doctor'),' ' ,'') from dual;

---------------------------------------------------------------------------------------
--문제 1.
--EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
--조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
--조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
select concat(first_name, last_name)as 이름, replace(hire_date, '/','') as 입사일자 from employees order by 이름 asc;

--문제 2.
--EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
--여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요
select concat( '(02)',substr(phone_number, 4, length(phone_number) )) 
from employees;

--문제 3. 
--EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
--이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
select RPAD(substr(First_name, 1, 3), length(First_name), '*') as name, 
LPAD(salary, 10, '*') as salary 
from employees 
where lower(JOB_ID) = 'it_prog';


