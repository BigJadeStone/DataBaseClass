--테이블생성
CREATE TABLE INFO 
(
  ID NUMBER NOT NULL 
, TITLE VARCHAR2(100) 
, CONTENT VARCHAR2(100) 
, REGDATE DATE DEFAULT sysdate NOT NULL 
, CONSTRAINT INFO_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);
   
CREATE TABLE auth 
(
  AUTH_ID NUMBER NOT NULL 
, NAME VARCHAR2(30) 
, JOB VARCHAR2(30) 
, CONSTRAINT TABLE1_PK PRIMARY KEY 
  (
    AUTH_ID 
  )
  ENABLE 
);            
--시퀀스 생성            
CREATE SEQUENCE SEQ_INFO;            
CREATE SEQUENCE SEQ_AUTH;
--데이터 삽입            
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'java', 'java is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'jsp', 'jsp is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'spring', 'spring is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'oracle', 'oracle is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'mysql', 'mysql is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'c', 'c is');             

INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '박인욱', 'developer');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '홍길자', 'DBA');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '이순신', 'designer');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '고길동', 'scientist');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '박인욱', 'teacher');
------------------
select * from info;
select * from auth;

--INNER JOIN
SELECT * FROM info INNER JOIN auth on info.auth_id = auth.auth_id;
SELECT * FROM info LEFT OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM info RIGHT OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM info FULL OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM INFO CROSS JOIN AUTH;