CREATE USER ePRESS IDENTIFIED BY ePRESS;
GRANT connect, resource TO ePRESS;

CONN ePRESS / ePRESS

CREATE TABLE securityquestions(
question_id NUMBER(6) CONSTRAINT securityquestion_id_pk PRIMARY KEY,
question VARCHAR2(300) CONSTRAINT securityquestion_value_nn NOT NULL);

CREATE TABLE users(
username VARCHAR2(30) CONSTRAINT user_name_pk PRIMARY KEY,
password VARCHAR2(60) CONSTRAINT user_password_nn NOT NULL,
email VARCHAR2(60) CONSTRAINT user_email_nn NOT NULL,
CONSTRAINT user_email_chk CHECK(email LIKE '%@%.%'),
security_question NUMBER(6) CONSTRAINT user_secquestion_nn NOT NULL,
CONSTRAINT user_secquestion_fk FOREIGN KEY (security_question) REFERENCES securityquestions (question_id),
security_answer VARCHAR(60) CONSTRAINT user_secanswer_nn NOT NULL,
last_name VARCHAR2(30) CONSTRAINT user_lastname_nn NOT NULL,
first_name VARCHAR2(30) CONSTRAINT user_firstname_nn NOT NULL,
role VARCHAR2(40) CONSTRAINT user_role_nn NOT NULL,
CONSTRAINT user_role_chk CHECK(role IN('ADMIN','MODERATOR','JOURNALIST')));

CREATE TABLE categories(
category_id NUMBER(8) CONSTRAINT category_id_pk PRIMARY KEY,
category_name VARCHAR2(50) CONSTRAINT category_name_nn NOT NULL);

CREATE TABLE articles(
article_id NUMBER(8) CONSTRAINT article_id_pk PRIMARY KEY,
category_id NUMBER(8) CONSTRAINT article_category_nn NOT NULL,
CONSTRAINT article_category_fk FOREIGN KEY (category_id) REFERENCES categories (category_id),
username VARCHAR2(30) CONSTRAINT article_writer_nn NOT NULL,
CONSTRAINT article_writer_fk FOREIGN KEY (username) REFERENCES users (username),
title VARCHAR2(200) CONSTRAINT article_title_nn NOT NULL,
content VARCHAR2(4000) CONSTRAINT article_content_nn NOT NULL,
creation_date DATE DEFAULT SYSDATE CONSTRAINT article_creationdate_nn NOT NULL,
post_date DATE,
status VARCHAR2(8) CONSTRAINT article_status_nn NOT NULL,
CONSTRAINT article_status_chk CHECK(status IN('PENDING','APPROVED','DECLINED')),
image_url VARCHAR2(50));

CREATE TABLE comments(
comment_id NUMBER(8) CONSTRAINT comment_id_pk PRIMARY KEY,
article_id NUMBER(8) CONSTRAINT comment_article_nn NOT NULL,
CONSTRAINT comment_article_fk FOREIGN KEY (article_id) REFERENCES articles (article_id),
title VARCHAR2(100) CONSTRAINT comment_title_nn NOT NULL,
content VARCHAR2(500) CONSTRAINT comment_content_nn NOT NULL,
comment_date DATE DEFAULT SYSDATE CONSTRAINT comment_date_nn NOT NULL,
email VARCHAR2(60) CONSTRAINT comment_email_nn NOT NULL,
CONSTRAINT comment_email_chk CHECK(email LIKE '%@%.%'),
alias VARCHAR2(20) CONSTRAINT comment_alias_nn NOT NULL,
status VARCHAR2(8) CONSTRAINT comment_status_nn NOT NULL,
CONSTRAINT comment_status_chk CHECK(status IN('PENDING','APPROVED','DECLINED')));

CREATE TABLE reacts(
react_id NUMBER(8) CONSTRAINT react_id_pk PRIMARY KEY,
react_date DATE DEFAULT SYSDATE,
react_type VARCHAR2(20) CONSTRAINT react_type_nn NOT NULL,
CONSTRAINT react_type_chk CHECK(react_type IN('LIKE','DISLIKE')),
sessionId VARCHAR2(100),
comment_id NUMBER(8),
article_id NUMBER(8),
CONSTRAINT react_article_fk FOREIGN KEY (article_id) REFERENCES articles (article_id),
CONSTRAINT react_comment_fk FOREIGN KEY (comment_id) REFERENCES comments (comment_id),
CONSTRAINT react_target_chk CHECK((article_id IS NULL OR comment_id IS NULL) AND (article_id IS NOT NULL OR comment_id IS NOT NULL)),
CONSTRAINT react_target_uc UNIQUE(sessionId, article_id, comment_id));

/*
CREATE TABLE images(
image_id NUMBER(8) CONSTRAINT image_id_pk PRIMARY KEY,
image_url VARCHAR2(50) CONSTRAINT image_url_nn NOT NULL,
article_id NUMBER(8) CONSTRAINT image_article_nn NOT NULL,
CONSTRAINT image_article_fk FOREIGN KEY (article_id) REFERENCES article (article_id));
*/

CREATE OR REPLACE PROCEDURE delete_article(articleID NUMBER)
IS
BEGIN
	DELETE FROM reacts WHERE article_id=articleID OR comment_id IN (SELECT comment_id FROM reacts r JOIN comments c USING(comment_id) WHERE c.article_id=articleID);
	DELETE FROM comments WHERE article_id=articleID;
	DELETE FROM articles WHERE article_id=articleID;
	COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE delete_user(user_name VARCHAR2)
IS
BEGIN
	DELETE FROM reacts WHERE article_id IN (SELECT article_id FROM articles WHERE username=user_name) OR comment_id IN (SELECT comment_id FROM reacts JOIN comments USING(comment_id) JOIN articles USING(article_id) WHERE username=user_name);
	DELETE FROM comments WHERE article_id=articleID;
	DELETE FROM articles WHERE article_id=articleID;
	COMMIT;
END;
/

INSERT INTO securityquestions VALUES(1,'What was your first pet''s name ?');
INSERT INTO securityquestions VALUES(2,'What is your mother-in-law''s favourite dish ?');
INSERT INTO securityquestions VALUES(3,'What was your first grade teacher''s name ?');
INSERT INTO users VALUES('MERZAK','$2a$14$RKHXeB9JC5IhvuXiwkK/1eVRjy27yRAicEzXJeeRnBcjLzEUdrU/K','merzak_mohamed@outlook.com',1,'TEST','MERZAK','Mohamed','ADMIN');
INSERT INTO users VALUES('IDAOUNSAR','$2a$14$RKHXeB9JC5IhvuXiwkK/1eVRjy27yRAicEzXJeeRnBcjLzEUdrU/K','idaounsar.houcine@gmail.com',2,'TEST','IDAOUNSAR','Houcine','MODERATOR');
INSERT INTO categories VALUES(1,'TEST');
INSERT INTO articles VALUES(1,1,'MERZAK','TEST ARTICLE TITLE','TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT TEST ARTICLE CONTENT',SYSDATE,SYSDATE,'APPROVED',NULL);
INSERT INTO comments VALUES(1,1,'TEST COMMENT TITLE','TEST COMMENT CONTENT TEST COMMENT CONTENT TEST COMMENT CONTENT TEST COMMENT CONTENT TEST COMMENT CONTENT',SYSDATE,'merzak@test_domain.com','M3RZ4K','APPROVED');
INSERT INTO reacts VALUES(1,SYSDATE,'LIKE','DATABASE_ISERTION_TEST_1',NULL,1);
INSERT INTO reacts VALUES(2,SYSDATE,'DISLIKE','DATABASE_ISERTION_TEST_2',NULL,1);
INSERT INTO reacts VALUES(3,SYSDATE,'LIKE','DATABASE_ISERTION_TEST_3',1,NULL);
INSERT INTO reacts VALUES(4,SYSDATE,'DISLIKE','DATABASE_ISERTION_TEST_4',1,NULL);
COMMIT;
