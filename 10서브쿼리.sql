--서브쿼리
--서브쿼리 사용방법 ()안에 명시함, 서브쿼리절의 리턴행이 1줄 이하여야 합니다
--서브쿼리 절에는 비교할 대상이 '하나' 반드시 들어 가야합니다.
--(서브쿼리절을 먼저 해석하면 됩니다)

--nancy의 급여
select salary from employees where first_name = 'Nancy';

select * 
from employees 
where salary >= (select salary from employees where first_name = 'Nancy');

--employee_id가 104번인 사람과 job)id가 동일한 사람을 검색하는 문장
select job_id from employees where employee_id = 104;

select * 
from employees 
where job_id = (select job_id 
                from employees 
                where employee_id = 104);
--------------------------------------------------------------------------------
--서브쿼리의 결과가 여러개 라면, 단일행 연산자를 사용할 수 없음.
--이런 경우는 다중행 서브쿼리 연산자를 이용해서 처리해야합니다.
select Employee_id
from employees
where job_id = 'IT_PROG';

select *
from employees
where employee_id >= (select Employee_id from employees where job_id = 'IT_PROG');
--------------------------------------------------------------------------------
--다중행 서브쿼리 in, any, all
SELECT SALARY
FROM Employees
where First_name = 'David';

--IN
SELECT *
FROM employees
where Salary in (SELECT Salary From Employees where First_name = 'David');

--4800,6800,9500
--ANY - 최소값 보다 큰 OR 최대값 보다 작은
SELECT *
FROM employees
where Salary < Any (select salary from employees where first_name = 'David');
                        
--ALL - 최대값 보다 큰 OR 최소값 보다 작은 사람
SELECT *
FROM employees
Where Salary < All (Select salary From employees where first_name = 'David');

--First_name 이 Steven인 사람의 급여보다 작은 사람
select *
from employees where first_name = 'Steven';

Select *
from employees
where salary < ANY(select salary from employees where first_name = 'Steven');

------------------------------------------------------------------------------------
--스칼라 서브쿼리(select 구문에 서브쿼리가 오는 것, LEFT OUTER조인이랑 같은 결과)
--
select first_name, department_name
from employees e
left outer join departments d on e.department_id = d.department_id
order by first_name asc;

SELECT FIRST_NAME,
        (SELECT Department_Name From departments D WHERE E.Department_ID = D.Department_ID) as DEPARTMENT_NAME,
        (SELECT LOCATION_ID From departments D WHERE E.Department_ID = D.Department_ID) as LOCATIONI_ID
FROM Employees E
ORDER BY FIRST_NAME ASC;

--
--각 부서의 매니저장의 이름
--left join
select  d.*,
        e.first_name
from departments d
left outer join employees e
on d.manager_id = e.employee_id
order by d.manager_id;
--스칼라, 기준이 되는 테이블을 먼저 정해두고 그 다음에 스칼라 커리구문 작성하기
select  d.*,
        (select first_name from employees e where d.manager_id = e.employee_id)
from departments d
order by d.manager_id;
----------------------------------------------------------------------------------------
--LEFT JOIN
SELECT  e1.*,
        d.department_name as 직원의부서,
        e2.first_name as 매니저이름
FROM employees e1
left outer join employees e2 on e1.manager_id = e2.employee_id
left outer join departments d on e1.department_id = d.department_id;
--scalar
select  e1.*,
        (select department_name from departments d where e1.department_id = d.department_id) as 직원의부서,
        (select first_name from employees e2 where e1.manager_id = e2.employee_id) as 매니저이름
From employees e1;
--부서별 사원수
select  department_id,
        count(*) 
from employees Group by Department_id --이걸 스칼라 쿼리에 넣어주면됨.
order by department_id asc;

select  d.*,
        (select count(*) from Employees e where d.Department_id =e.Department_id Group by department_id) as 부서별사원수
from Departments d;

