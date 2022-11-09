--집합연산자 (위 아래 column개수가 정확히 일치해야 함)
--union(합집합 중복x), union all(합집합 중복o), intersect(교집합), minus(차집합)

select employee_id, first_name from employees where hire_date like '04%'
union
select employee_id, first_name from employees where department_id = 20;

select employee_id, first_name from employees where hire_date like '04%'
union all
select employee_id, first_name from employees where department_id = 20;

select employee_id, first_name from employees where hire_date like '04%'
intersect
select employee_id, first_name from employees where department_id = 20;

select employee_id, first_name from employees where hire_date like '04%'
minus
select employee_id, first_name from employees where department_id = 20;

----
select employee_id, first_name, salary from employees where department_id = 20
union all
select employee_id, first_name, salary from employees where salary > 10000
union all
select 300, 'hong', 20000 from dual;

------------------------------------------------------------------
-- 분석함수() over(조건)
SELECT  EMPLOYEE_ID,
        DEPARTMENT_ID,
        SALARY,
        RANK() OVER(ORDER BY SALARY DESC) AS 중복순위O,
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS 중복순위X,
        ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 일련번호,
        rownum as 조회된순서 -- rownum은 조회된 순서
FROM EMPLOYEES
ORDER BY SALARY DESC; 
