--���̺����
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
--������ ����            
CREATE SEQUENCE SEQ_INFO;            
CREATE SEQUENCE SEQ_AUTH;
--������ ����            
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'java', 'java is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'jsp', 'jsp is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'spring', 'spring is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'oracle', 'oracle is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'mysql', 'mysql is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'c', 'c is');             

INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '���ο�', 'developer');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, 'ȫ����', 'DBA');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '�̼���', 'designer');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '��浿', 'scientist');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '���ο�', 'teacher');
------------------
select * from info;
select * from auth;

--INNER JOIN
SELECT * FROM info INNER JOIN auth on info.auth_id = auth.auth_id;
SELECT * FROM info LEFT OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM info RIGHT OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM info FULL OUTER JOIN auth ON info.auth_id = auth.auth_id;
SELECT * FROM INFO CROSS JOIN AUTH;