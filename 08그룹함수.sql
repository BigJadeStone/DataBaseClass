--그룹 함수 AVG, MAX, MIN, SUM, COUNT
select AVG(salary), MAX(salary), MIN(salary), SUM(salary), count(*) from employees;

SELECT max(hire_Date), min(hire_date) from employees; --날짜에도 가능

--count(*), count(컬럼)
select count(*) from employees; --총 행 데이터의 수
select count(commission_pct), count(manager_id) from employees; --null이 아닌 행의 수

--주의할 점: 그룹함수는 일반 컬럼과 동시에 출력 불가.
--SELECT employee_id, sum(salary) from employees;

---------------------------------------------------------------------------
--부서별 급여평균
select department_id, avg(salary) from employees group by department_id;

--group절에 묶이지 않은 컬럼은 select절에 사용불가 (데이터베이스별로 다름)
select job_id, deparyment_id from employees group by department_id;

--2개 이상의 그룹핑
select department_id, job_id, sum(salary)
from employees 
group by department_id, job_id 
order by department_id desc;

select  department_id,
        job_id,
        sum(salary),
        count(*), --그룹별 수
        count(*) over() -- 전체행수 ,잘못쓰면 sql이 느려지는 단점이 있음.
from employees
group by department_id, job_id
order by department_id desc;

select  department_id,
        job_id,
        count(*) over() --전체행 수 (그룹없이 사용가능)
from employees;

--where절에 그룹함수 사용불가
select deparyment_id
from employees
where sum(salary) >= 5000 
GROUP by deparyment_id;

---------------------------------------------------------------------------------------------------
--having (그룹의 조건)
select deparyment_id, sum(salary)
from employees
group by deparyment_id
having sum(salary) > 100000;

select job_id, count(*)
from employees
group by job_id
having count(*) >= 20;

--부서 아이디가 50이상인 것들을 그룹화 시키고, 그룹 평균중 5000이상만 조회, 정렬 평균내림차순
select department_id, trunc(avg(salary))
from employees
where department_id >=50
GROUP BY department_id
having avg(salary)>=5000
order by avg(salary) desc;

--직무 SA가 포함된 데이터의 그룹별 사원수, 그룹별 급여합, 정렬해주기, 그루핑은 job_id로
select job_id, count(*) as 사원수, sum(salary) as 급여합
from employees
where job_id like 'SA%'
group by job_id
order by sum(salary) asc;

--------------------------------------------------------------------------------
--롤업 - 주그룹의 토탈
--그룹핑 1개 -> 총계출력
select department_id,
        sum(salary)
from employees
group by rollup(department_id)
order by department_id;

--그룹핑 2개 -> 총계와 주그룹의 토탈
select department_id, job_id, avg(salary), count(salary)
from employees
group by rollup(department_id, Job_id)
order by department_id, job_id;

--큐브 - 서브그룹까지의 토탈 (구할 수 있는 모든합)
select department_id, job_id, avg(salary), count(salary)
from employees
group by cube(department_id, Job_id)
order by department_id, job_id;

--GROUPING-
select  department_id, 
        DECODE (GROUPING(JOB_ID), 1, '소계', job_id),
        avg(salary), 
        count(salary),
        Grouping(Department_id),
        Grouping(JOB_ID)
from employees
group by ROLLUP(department_id, Job_id)
order by department_id, job_id;

--------------------------------------------------------------------------------
--문제 1.
--사원 테이블에서 JOB_ID별 사원 수를 구하세요.
--사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요
select  Job_id, 
        count(*) as 사원수, 
        avg(salary) 월급평균
from employees
GROUP BY JOB_ID
ORDER BY avg(salary) desc;

--문제 2.
--사원 테이블에서 입사 년도 별 사원 수를 구하세요.
select  to_char(hire_date, 'YY'),
        count(*) 사원수
from employees
GROUP BY to_char(hire_date, 'YY')
order by to_char(hire_date, 'YY') asc;

--문제 3.
--급여가 1000 이상인 사원들의 부서별 평균 급여를 출력하세요. 단 부서 평균 급여가 2000이상인 부서만 출력
select  department_id,
        avg(salary)
from employees
where salary >= 1000
GROUP BY department_id
HAVING avg(salary) >= 2000
order by avg(salary) desc;

--문제 4.
--사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
--department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
--조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
--조건 2) 평균은 소수 2째 자리에서 절삭 하세요.
select  department_id,
        trunc(avg(salary+salary*commission_pct),2),
        sum(salary + salary*commission_pct),
        count(*)
from employees
where commission_pct is not null
group by department_id;


--문제 5.
--직업별 월급합, 총합계를 출력하세요
select  DECODE(GROUPING(job_id), 1, '합계', JOB_ID), 
        sum(salary)
from employees
GROUP BY ROLLUP(Job_Id);

--문제 6.부서별, JOB_ID를 그룹핑 하여 토탈, 합계를 출력하세요.
--GROUPING() 을 이용하여 소계 합계를 표현하세요.
select  DECODE (GROUPING(department_id), 1, '합계', department_id) as Department_id,
        DECODE (GROUPING(JOB_ID), 1, '소계', job_id) as job_id,
        count(*) as TOTAL,
        sum(salary) as sum
from employees
GROUP By RollUP(Department_id, Job_id)
order by sum asc;



