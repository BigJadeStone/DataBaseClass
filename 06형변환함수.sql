--형변환함수
select to_char(sysdate, 'YYYY-MM-DD') from dual;
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS') from dual;
select to_char(sysdate, 'YY-MM-DD HH:MI:SS Month') from dual;

select first_name, to_char(hire_date, 'YYYY-MM-DD HH:MI:SS') from employees;
select first_name, to_char(hire_date, 'YYYY"일"MM"월"DD"일"') from employees;

--숫자를 문자로
select to_char(20000, '99999') || '원' from dual; --자리수
select to_char(20000, '9999') || '원' from dual; --자리수부족

select to_char(20000.14, '99999.99') from dual; --소수점
select to_char(20000.14, '99999') from dual;

select to_char(20000.14, '999,999,999') from dual;

select to_char(salary, '$999,999') as salary  from employees;
select to_char(salary, 'L999,999') as salary from employees;
--salary를 현재 환율에 맞춰서 한국돈으로 표현 1364
select to_char(salary * 1364, 'L999,999,999') from employees;

--to_number (문자를 숫자로)
select '2000' + 2000 from dual; --자동형변환
select to_number('20000') + 2000 from dual; --명시적 변환
select '$3,000' + 3000 from dual; --에러
select to_number('$3,000', '$9,999') + 3000 from dual; 

--to_date(문자를 날짜로)
select sysdate - '2022-08-01' from dual;
select sysdate - to_date('2022-08-01') from dual; -- ok
select sysdate - to_date('2022-08-01', 'YYYY-MM-DD') from dual; --ok
select TO_DATE('2020-03-31 12:23:03', 'YYYY-MM-DD HH:MI:SS') from dual;

-- xxxx년xx월xx일 문자열 형식으로 변환하세요
--문자를 date로 치환하고 바뀐 date값을 다시 형식에 맞게 문자로 바꿔주면됨.
select to_char(to_date('20050102', 'YYYY-MM-DD'), 'YYYY"년"MM"월"DD"일"') from dual;
select to_char(to_date('20050102'), 'YYYY"년"MM"월"DD"일"') from dual;

--NVL (null에 대한처리)
select NVL(null, 0) , NVL(3.14, 0) from dual;
SELECT NVL(commission_pct, 0) from employees; --commission_pct가 null이라면 0으로 바꿔줌.

--NVL2 (컬럼, null이 아닐경우 값, null일 경우 값)
select NVL2(null, '널아님', '널') from dual;
select first_name,
        salary,
        commission_pct,
        NVL2(commission_pct, salary+(salary*commission_pct), salary) 
from employees;

--DECODE(if~~)
select decode('a', 'a', 'a입니다', 'a가 아닙니다') from dual;

select DECODE('C', 'A', 'A입니다',
                    'B', 'B입니다',
                    'C', 'C입니다',
                    '전부 아닙니다') from dual;
                    
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
--문제 1.
--현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
--사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
--조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다
select  employee_id as 사원번호, 
        concat(first_name || ' ', last_name) as 사원명,
        hire_date as 입사일자,
        trunc((sysdate - hire_date)/365) as 근속년수 
from employees 
order by 근속년수 desc; --order by 는 앨리어스가 사용가능, 왜냐하면 select에서 조회가 끝난뒤에 정렬이 되기 때문.

--문제 2.
--EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
--100이라면 ‘사원’, 
--120이라면 ‘주임’
--121이라면 ‘대리’
--122라면 ‘과장’
--나머지는 ‘임원’ 으로 출력합니다.
--조건 1) Department_id가 50인 사람들을 대상으로만 조회합니다
select * from employees;
select  first_name,
        manager_id,
        case MANAGER_ID when 100 then '사원'
                        when 120 then '주임'
                        when 121 then '대리'
                        when 122 then '과장'
                        else '임원'
                    end as 직급
from employees where DEPARTMENT_id >= 50;        