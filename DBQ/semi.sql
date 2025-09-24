--update employee_tb
--set emp_no = 1
--,dept_code = 'D1'
--, job_code = 'J1'
--where emp_no = 1;
--
--commit;
DROP TABLE FINAL_APP;
DROP TABLE VACATION_TB;
DROP TABLE PROJECTMEMBER_TB;
DROP TABLE APP_BOARD;
DROP TABLE SCHEDULE;
DROP TABLE CHAT_ROOM_MEMBER_TB;
DROP TABLE MESSAGE_TB;
DROP TABLE CHAT_ROOM_TB;
DROP TABLE REQUIREMENT_TB;
DROP TABLE ACCOUNT_TB;
DROP TABLE CUSTOMER_TB;
DROP TABLE PROJECT_TB;
DROP TABLE EMPLOYEE_TB;
DROP TABLE ATTACHMENT_TB;
DROP TABLE DEPARTMENT;
DROP TABLE JOB_TB;


DROP TRIGGER TRG_CUS_GENDER;
DROP TRIGGER TRG_CUS_AGE;
DROP TRIGGER TRG_LOAN;
DROP TRIGGER TRG_VAC;
DROP TRIGGER TRG_FA;

DROP SEQUENCE SEQ_ENO;
DROP SEQUENCE SEQ_PNO;
DROP SEQUENCE SEQ_VNO;
DROP SEQUENCE SEQ_SNO;
DROP SEQUENCE SEQ_ANO;
DROP SEQUENCE SEQ_MNO;
DROP SEQUENCE SEQ_RNO;
DROP SEQUENCE SEQ_CNO;
DROP SEQUENCE SEQ_ATNO;
DROP SEQUENCE SEQ_FNO;
DROP SEQUENCE SEQ_CRNO;

-- ============================================
-- 시퀀스
-- ============================================
CREATE SEQUENCE SEQ_ENO START WITH 100 NOCYCLE NOCACHE; -- 사원번호
CREATE SEQUENCE SEQ_PNO START WITH 1 NOCYCLE NOCACHE; -- 프로젝트번호
CREATE SEQUENCE SEQ_VNO START WITH 1 NOCYCLE NOCACHE; -- 휴가번호
CREATE SEQUENCE SEQ_SNO START WITH 1 NOCYCLE NOCACHE; -- 일정번호
CREATE SEQUENCE SEQ_ANO START WITH 1 NOCYCLE NOCACHE; -- 결재번호
CREATE SEQUENCE SEQ_MNO START WITH 1 NOCYCLE NOCACHE; -- 메세지번호
CREATE SEQUENCE SEQ_RNO NOCYCLE NOCACHE; -- 요청번호
CREATE SEQUENCE SEQ_CNO NOCYCLE NOCACHE; -- 고객번호
CREATE SEQUENCE SEQ_ATNO NOCYCLE NOCACHE; -- 첨부파일번호
CREATE SEQUENCE SEQ_FNO NOCYCLE NOCACHE; -- 승인번호
CREATE SEQUENCE SEQ_CRNO START WITH 1 INCREMENT BY 1 NOCACHE; -- 채팅방번호

-- 고객 테이블
CREATE TABLE CUSTOMER_TB (
    CUS_NO NUMBER PRIMARY KEY,
    CUS_NAME VARCHAR2(20) NOT NULL,
    CUS_GENDER VARCHAR2(1) NOT NULL,
    CUS_AGE NUMBER,
    CUS_RESINUM VARCHAR2(15) NOT NULL,
    CUS_ADDRESS VARCHAR2(80) NOT NULL,
    CUS_PHONE VARCHAR2(13) NOT NULL,
    CUS_EMAIL VARCHAR2(30),
    CUS_JOB CHAR(1) DEFAULT 'Y' CHECK(CUS_JOB IN ('Y', 'N')),
    CUS_ENROLLDATE DATE DEFAULT SYSDATE,
    LOAN CHAR(1) DEFAULT 'N' CHECK(LOAN IN ('N', 'Y')),
    AMOUNT NUMBER DEFAULT 0,
    INTEREST NUMBER DEFAULT 0.0,
    RATING NUMBER DEFAULT 6
);

--=================================================
-----------------고객 테이블 코멘트------------------
COMMENT ON COLUMN CUSTOMER_TB.CUS_NO IS '고객번호';
COMMENT ON COLUMN CUSTOMER_TB.CUS_NAME IS '고객명';
COMMENT ON COLUMN CUSTOMER_TB.CUS_GENDER IS '고객성별';
COMMENT ON COLUMN CUSTOMER_TB.CUS_AGE IS '고객나이';
COMMENT ON COLUMN CUSTOMER_TB.CUS_RESINUM IS '고객주민번호';
COMMENT ON COLUMN CUSTOMER_TB.CUS_ADDRESS IS '고객주소';
COMMENT ON COLUMN CUSTOMER_TB.CUS_PHONE IS '고객연락처';
COMMENT ON COLUMN CUSTOMER_TB.CUS_EMAIL IS '고객이메일';
COMMENT ON COLUMN CUSTOMER_TB.CUS_JOB IS '고객직장';
COMMENT ON COLUMN CUSTOMER_TB.CUS_ENROLLDATE IS '고객등록날짜';
COMMENT ON COLUMN CUSTOMER_TB.LOAN IS '대출현황';
COMMENT ON COLUMN CUSTOMER_TB.AMOUNT IS '대출금액';
COMMENT ON COLUMN CUSTOMER_TB.INTEREST IS '이자율';
COMMENT ON COLUMN CUSTOMER_TB.RATING IS '신용등급';
-- ============================================
-- CUSTOMER_TB 샘플 데이터
-- ============================================
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'호랑이','M', 33, '930101-1234567','서울대공원','010-4444-5678','tiger@company.com', 0.4);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'토끼','F', 32, '940101-2234567','에버랜드','010-5152-5678','rabbit@company.com', 0.3);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'코끼리','M', 30, '960101-1234567','사파리','010-6524-5678','elephant@company.com', 0.7);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'사자','M', 29, '970101-1234567','롯데월드','010-8512-5678','lion@company.com', 0.6);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'김삵','F', 33, '930201-2234567','서울대공원','010-4244-5678','ks@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'정뱀','M', 32, '940102-1234567','에버랜드','010-5452-5678','jbam@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'박사슴','F', 30, '960301-2234567','사파리','010-6525-5278','pss@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'이호랑','M', 29, '970401-1234567','롯데월드','010-8513-5278','tiger@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'고영희','F', 29, '970204-2234567','경주월드','010-4254-5178','kyh@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'강아지','M', 32, '941202-1235567','단독주택','010-5472-2678','gaj@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'정꿀벌','F', 30, '960321-2235567','사파리','010-6535-5778','hbb@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'호박벌','M', 29, '971101-1239567','롯데월드','010-8593-5278','jgb@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'박곰','M', 29, '970419-1234967','롯데월드','010-1533-5978','parkg@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'정박쥐','F', 29, '971004-2254567','경주월드','010-4954-5678','jbg@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'원숭이','M', 32, '941212-1435567','대자연','010-5252-2579','wons@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'정학','F', 30, '960511-2635567','사파리','010-6325-5174','jh@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'박말','M', 29, '971016-1229567','롯데월드','010-8621-5798','bkb@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'이부엉','M', 29, '971120-1264967','롯데월드','010-6245-5976','lbu@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'앵무새','F', 29, '971214-2234567','경주월드','010-2674-5278','yangm@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'정똘이','M', 32, '941118-1425427','대자연','010-5357-2472','jddol@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'새초미','F', 30, '960121-2655765','사파리','010-6135-5254','scho@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'박호치','M', 29, '971118-1427567','롯데월드','010-2611-4758','hochi@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'고드라','M', 29, '971012-1466897','롯데월드','010-1155-4764','drago@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'이요롱','F', 29, '971214-2234567','경주월드','010-6624-5177','yorong@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'정떵이','M', 32, '941211-1585027','대자연','010-1317-4442','jddung2@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'백미미','F', 30, '960225-2257795','사파리','010-3435-2154','backmm@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'이마초','M', 29, '971211-1628506','롯데월드','010-2321-4551','macho@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'임뭉치','M', 29, '971028-1461934','롯데월드','010-2135-9473','immc@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'고릴라','M', 29, '970617-1584937','경주월드','010-2375-5679','gorila@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'두더지','M', 32, '940121-1526497','대자연','010-1151-2232','dudug@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'오목이','F', 30, '961010-2646898','사파리','010-2432-2234','omok@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'문오징','M', 29, '970158-1446897','롯데월드','010-5522-4467','ojin@gmail.com', 0.2);

--=================================================
----------------------- 고객 샘플 데이터 업데이트 ------------------------- 
UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 3;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 7;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 10;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 11;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 12;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 14;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 18;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 19;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 22;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 27;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 29;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 30;

UPDATE CUSTOMER_TB
     SET LOAN = 'Y'
         , AMOUNT = 3000000
         , INTEREST = 0.2
         , RATING = 5
 WHERE CUS_NO = 31;

--=================================================
------------------ 고객정보 추가시 성별 생성 테이블 ---------------------
CREATE OR REPLACE TRIGGER TRG_CUS_GENDER
	BEFORE INSERT ON CUSTOMER_TB
	FOR EACH ROW
BEGIN 
	DECLARE
		CGENDER_CODE CHAR(1);
	BEGIN
	
	    	CGENDER_CODE := SUBSTR(:NEW.CUS_RESINUM, 8, 1);
		
		IF CGENDER_CODE IN ('1', '3') THEN
			:NEW.CUS_GENDER := 'M';
		ELSE 
			:NEW.CUS_GENDER := 'F';
		END IF;
	END;
END;
/

--=================================================
------------------ 고객정보 추가시 나이 삽입 테이블 ---------------------
CREATE OR REPLACE TRIGGER TRG_CUS_AGE
	BEFORE INSERT ON CUSTOMER_TB
	FOR EACH ROW
DECLARE
	C_AGE NUMBER;
BEGIN
	C_AGE := floor(months_between(sysdate, to_date(substr(:NEW.cus_resinum, 1, 6), 'RRMMDD'))/12);
	:NEW.CUS_AGE := C_AGE;
END;
/

-- ==============================================
----- 대출금액 0수정시 자동 대출여부 N 트리거 -----------------
CREATE OR REPLACE TRIGGER TRG_LOAN
    BEFORE UPDATE ON CUSTOMER_TB
    FOR EACH ROW
BEGIN 
    IF :NEW.AMOUNT = 0 
    THEN
    :NEW.LOAN := 'N';
    END IF;
END;
/
		
	

--=================================================
------------------ 고객계좌 테이블 ------------------
CREATE TABLE ACCOUNT_TB(
    ACC_NUM CHAR(16) PRIMARY KEY,
    ACC_PWD VARCHAR2(100) NOT NULL,
    CUS_NO NUMBER REFERENCES CUSTOMER_TB(CUS_NO),
    ACC_STATUS CHAR(1) DEFAULT 'Y' CHECK(ACC_STATUS IN ('Y', 'N'))
);

--=================================================
--------------- 고객계좌 테이블 코멘트 ---------------
COMMENT ON COLUMN ACCOUNT_TB.ACC_NUM IS '고객계좌번호';
COMMENT ON COLUMN ACCOUNT_TB.ACC_PWD IS '고객계좌비번';
COMMENT ON COLUMN ACCOUNT_TB.CUS_NO IS '고객번호';
COMMENT ON COLUMN ACCOUNT_TB.ACC_STATUS IS '고객계좌상태';


----------------- 첨부파일 테이블 -------------------
CREATE TABLE ATTACHMENT_TB(
    ATT_NO NUMBER PRIMARY KEY,
    ATT_CHANGENAME VARCHAR2(255),
    ATT_ORIGIN VARCHAR2(255),
    REF_NO NUMBER,
    ATT_CATEGORY NUMBER,
    ATT_FILEPATH VARCHAR2(255),
    UPLOAD_DATE DATE DEFAULT SYSDATE

);


--=================================================
--------------- 첨부파일 테이블 코멘트 ---------------
COMMENT ON COLUMN ATTACHMENT_TB.ATT_NO IS '첨부파일번호';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_CHANGENAME IS '수정파일명';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_ORIGIN IS '원본파일명';
COMMENT ON COLUMN ATTACHMENT_TB.REF_NO IS '소속글번호';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_CATEGORY IS '참조게시물번호';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_FILEPATH IS '파일경로';
COMMENT ON COLUMN ATTACHMENT_TB.UPLOAD_DATE IS '저장날짜';

-- ============================================
-- 부서 테이블
-- ============================================
CREATE TABLE DEPARTMENT ( -- 부서 테이블
    DEPT_CODE CHAR(2) PRIMARY KEY, -- 부서코드(D1~D6)
    DEPT_TITLE VARCHAR2(20) NOT NULL -- 부서명(1지점장 2총무부 3인사부 4영업부 5관리부 6지원부)
);

--=================================================
--------------- 부서 테이블 코멘트 ---------------
COMMENT ON COLUMN DEPARTMENT.DEPT_CODE IS '부서코드';
COMMENT ON COLUMN DEPARTMENT.DEPT_TITLE IS '부서명';

-- ============================================
-- 5. DEPARTMENT_TB 샘플 데이터
-- ============================================
INSERT INTO DEPARTMENT VALUES('D1','관리자');
INSERT INTO DEPARTMENT VALUES('D2','총무부');
INSERT INTO DEPARTMENT VALUES('D3','인사부');
INSERT INTO DEPARTMENT VALUES('D4','영업부');
INSERT INTO DEPARTMENT VALUES('D5','관리부');
INSERT INTO DEPARTMENT VALUES('D6','지원부');
INSERT INTO DEPARTMENT VALUES('D7','임시부서');

-- ============================================
-- 직급 테이블
-- ============================================
CREATE TABLE JOB_TB ( -- 직급 테이블
    JOB_CODE CHAR(2) PRIMARY KEY, -- 직급코드(J1~J4)
    JOB_TITLE VARCHAR2(20) NOT NULL -- 직급명(1지점장 2부장 3팀장 4사원)
);

--=================================================
--------------- 직급 테이블 코멘트 ---------------
COMMENT ON COLUMN JOB_TB.JOB_CODE IS '직급코드';
COMMENT ON COLUMN JOB_TB.JOB_TITLE IS '직급명';

-- ============================================
-- JOB_TB 샘플 데이터
-- ============================================
INSERT INTO JOB_TB VALUES('J1','지점장');
INSERT INTO JOB_TB VALUES('J2','부장');
INSERT INTO JOB_TB VALUES('J3','팀장');
INSERT INTO JOB_TB VALUES('J4','사원');
INSERT INTO JOB_TB VALUES('J5','임시직급');

-- ============================================
-- 사원 테이블
-- ============================================
CREATE TABLE EMPLOYEE_TB ( -- 사원 테이블
    EMP_NO NUMBER PRIMARY KEY, -- 사원번호
    EMP_NAME VARCHAR2(20) NOT NULL, -- 사원이름
    EMP_RESINUM VARCHAR2(6) NOT NULL, -- 사원생년월일
    EMP_ID VARCHAR2(20) NOT NULL UNIQUE, -- 사원아이디
    EMP_PWD VARCHAR2(100) NOT NULL, -- 사원 비밀번호
    EMP_GENDER CHAR(1) CHECK (EMP_GENDER IN ('M','F')) NOT NULL, -- 성별(남자는 'M', 여자는 'F'로 저장)
    DEPT_CODE CHAR(2) DEFAULT 'D7' REFERENCES DEPARTMENT(DEPT_CODE), -- 부서코드 (부서 테이블 참조)
    JOB_CODE CHAR(2) DEFAULT 'J5' REFERENCES JOB_TB(JOB_CODE), -- 직급코드 (직급 테이블 참조)
    EMP_PHONE VARCHAR2(13) NOT NULL, -- 전화번호
    EMP_EMAIL VARCHAR2(50), -- 이메일
    EMP_ADDRESS VARCHAR2(4000) NOT NULL, -- 주소
    EMP_STATUS CHAR(1) DEFAULT 'Y' NOT NULL, -- 재직상태(퇴사하면 N으로 변경)
    ATT_NO NUMBER REFERENCES ATTACHMENT_TB(ATT_NO), -- 서명사진
    SALARY NUMBER, -- 급여
    BONUS NUMBER DEFAULT 0,
    HIRE_DATE DATE DEFAULT SYSDATE, -- 입사날짜
    MODIFY_DATE DATE DEFAULT SYSDATE, -- 수정날짜
    EMP_PICTURE VARCHAR2(4000), -- 증명사진(파일 링크 문자열로 저장)
    MESSENGER_STATUS CHAR(1) DEFAULT 'N' CHECK (MESSENGER_STATUS IN ('Y', 'N'))  -- 메신저 접속상태
);

--=================================================
--------------- 사원 테이블 코멘트 ---------------
COMMENT ON COLUMN EMPLOYEE_TB.EMP_NO IS '사원번호';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_NAME IS '사원번호';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_RESINUM IS '사원생년월일';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_ID IS '사원아이디';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_PWD IS '사원비밀번호';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_GENDER IS '성별';
COMMENT ON COLUMN EMPLOYEE_TB.DEPT_CODE IS '부서코드';
COMMENT ON COLUMN EMPLOYEE_TB.JOB_CODE IS '직급코드';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_PHONE IS '전화번호';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_EMAIL IS '이메일';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_ADDRESS IS '주소';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_STATUS IS '재직상태';
COMMENT ON COLUMN EMPLOYEE_TB.ATT_NO  IS '서명사진';
COMMENT ON COLUMN EMPLOYEE_TB.SALARY IS '급여';
COMMENT ON COLUMN EMPLOYEE_TB.BONUS IS '보너스';
COMMENT ON COLUMN EMPLOYEE_TB.HIRE_DATE IS '입사일';
COMMENT ON COLUMN EMPLOYEE_TB.MODIFY_DATE IS '수정일';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_PICTURE IS '사원사진';
COMMENT ON COLUMN EMPLOYEE_TB.MESSENGER_STATUS IS '메신저접속상태';


-- ============================================
-- 휴가 테이블
-- ============================================
CREATE TABLE VACATION_TB ( -- 휴가 테이블
    VAC_NO NUMBER PRIMARY KEY, -- 휴가번호
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO), -- 사원번호 (사원 테이블 참조)
    VAC_SDATE DATE, -- 휴가 시작 날짜
    VAC_EDATE DATE, -- 휴가 종료 날짜
    VAC_STATUS CHAR(1) CHECK(VAC_STATUS IN ('Y','N')) -- 휴가 여부
);

--=================================================
--------------- 휴가 테이블 코멘트 ---------------
COMMENT ON COLUMN VACATION_TB.VAC_NO IS '휴가번호';
COMMENT ON COLUMN VACATION_TB.EMP_NO IS '사원번호';
COMMENT ON COLUMN VACATION_TB.VAC_SDATE IS '휴가시작일';
COMMENT ON COLUMN VACATION_TB.VAC_EDATE IS '휴가종료일';
COMMENT ON COLUMN VACATION_TB.VAC_STATUS IS '휴가상태';

-- ============================================
-- 휴가 상태 트리거
-- ============================================
CREATE OR REPLACE TRIGGER TRG_VAC
    BEFORE INSERT OR UPDATE ON VACATION_TB
    FOR EACH ROW
BEGIN
    -- 휴가 시작일이 입력되었을 때 휴가상태를 'Y'로 설정
    IF :NEW.VAC_SDATE IS NOT NULL THEN
        :NEW.VAC_STATUS := 'Y';
    END IF;
END;
/

-- ============================================
-- 프로젝트 테이블
-- ============================================
CREATE TABLE PROJECT_TB ( -- 프로젝트 테이블
    PJT_NO NUMBER PRIMARY KEY, -- 프로젝트번호
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL, -- 작성자ID
    PJT_NAME VARCHAR2(2000) NOT NULL, -- 프로젝트명
    PJT_STARTDATE DATE NOT NULL, --프로젝트 시작일
    PJT_ENDDATE DATE NOT NULL, --프로젝트 종료일
    PJT_ENROLLDATE DATE DEFAULT SYSDATE NOT NULL, -- 프로젝트 작성일
    PJT_COUNT NUMBER DEFAULT 0, -- 조회수
    PJT_STATUS CHAR(1) DEFAULT 'c' NOT NULL CHECK (PJT_STATUS IN ('p','c','e','n')), -- 프로젝트 상태(진행중(p) | 검토중(c) | 만료(e) | 삭제(n))
    PJT_CONTENT VARCHAR2(4000) NOT NULL, -- 프로젝트 내용
    PJT_TAGS VARCHAR2(1000) DEFAULT ' ' NOT NULL
);

--=================================================
--------------- 프로젝트 테이블 코멘트 ---------------
COMMENT ON COLUMN PROJECT_TB.PJT_NO IS '프로젝트번호';
COMMENT ON COLUMN PROJECT_TB.EMP_NO IS '작성자사원번호';
COMMENT ON COLUMN PROJECT_TB.PJT_NAME IS '프로젝트이름';
COMMENT ON COLUMN PROJECT_TB.PJT_ENROLLDATE IS '작성일';
COMMENT ON COLUMN PROJECT_TB.PJT_COUNT IS '조회수';
COMMENT ON COLUMN PROJECT_TB.PJT_STATUS IS '상태';
COMMENT ON COLUMN PROJECT_TB.PJT_CONTENT IS '프로젝트내용';

-- ============================================
-- 프로젝트 참여자 테이블
-- ============================================
CREATE TABLE PROJECTMEMBER_TB ( -- 프로젝트참여자 테이블
    PJT_NO NUMBER NOT NULL REFERENCES PROJECT_TB(PJT_NO), -- 프로젝트번호
    EMP_NO NUMBER NOT NULL REFERENCES EMPLOYEE_TB(EMP_NO), -- 사원번호
    PRIMARY KEY (PJT_NO, EMP_NO) -- 복합키
);

--=================================================
--------------- 프로젝트 참여자 테이블 코멘트 ---------------
COMMENT ON COLUMN PROJECTMEMBER_TB.PJT_NO IS '프로젝트번호';
COMMENT ON COLUMN PROJECTMEMBER_TB.EMP_NO IS '작성자사원번호';


-- ============================================
-- 결재 게시판 테이블
-- ============================================
CREATE TABLE APP_BOARD ( -- 결재게시판 테이블
    APP_NO NUMBER PRIMARY KEY, -- 결재번호
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO), -- 사원번호
    APP_TITLE VARCHAR2(4000) NOT NULL, -- 결재 제목
    APP_CONTENT VARCHAR2(4000) NOT NULL, -- 결재 내용
    CREATE_DATE DATE DEFAULT SYSDATE, -- 등록일
    APP_STATUS VARCHAR(3) DEFAULT 'U' CHECK (APP_STATUS IN ('U','A','D')), -- 상태(U:대기, A:승인, D:반려)
    APP_DATE DATE DEFAULT SYSDATE, -- 결재일
    APP_SHOWSTATUS VARCHAR(3) DEFAULT 'Y' CHECK (APP_SHOWSTATUS IN ('Y', 'N')),
    MANAGER_STATUS VARCHAR(3) DEFAULT 'U' CHECK (MANAGER_STATUS IN ('U', 'A', 'D')),
    FINAL_STATUS VARCHAR(3) DEFAULT 'U' CHECK (FINAL_STATUS IN ('U', 'A', 'D'))
);

--=================================================
--------------- 결재 게시판 테이블 코멘트 ---------------
COMMENT ON COLUMN APP_BOARD.APP_NO IS '결재번호';
COMMENT ON COLUMN APP_BOARD.EMP_NO IS '사원번호';
COMMENT ON COLUMN APP_BOARD.APP_TITLE IS '결재제목';
COMMENT ON COLUMN APP_BOARD.APP_CONTENT IS '결재내용';
COMMENT ON COLUMN APP_BOARD.CREATE_DATE IS '등록일';
COMMENT ON COLUMN APP_BOARD.APP_STATUS IS '결재상태';
COMMENT ON COLUMN APP_BOARD.APP_DATE IS '결재일';
COMMENT ON COLUMN APP_BOARD.APP_SHOWSTATUS IS '글존재여부';
COMMENT ON COLUMN APP_BOARD.MANAGER_STATUS IS '1차승인여부';
COMMENT ON COLUMN APP_BOARD.FINAL_STATUS IS '최종승인여부';



-- ============================================
-- 승인된 결재 테이블
-- ============================================
CREATE TABLE FINAL_APP ( -- 승인된 결재 테이블
    FA_NO NUMBER PRIMARY KEY, -- 승인번호
    APP_NO NUMBER REFERENCES APP_BOARD(APP_NO) NOT NULL -- 결재번호 
    
);

--=================================================
--------------- 승인된 결재 테이블 코멘트 ---------------
COMMENT ON COLUMN FINAL_APP.FA_NO IS '승인번호';
COMMENT ON COLUMN FINAL_APP.APP_NO IS '결재번호';


-- ============================================



-- 결재게시판에서 승인 시 승인된 결재 테이블로 자동 추가 트리거
-- ============================================
CREATE OR REPLACE TRIGGER TRG_FA
AFTER UPDATE ON APP_BOARD
FOR EACH ROW
BEGIN
    INSERT INTO FINAL_APP (FA_NO, APP_NO)
    VALUES (SEQ_FNO.NEXTVAL, :NEW.APP_NO);

END;
/

-- ============================================
-- 일정 테이블
-- ============================================
CREATE TABLE SCHEDULE ( -- 일정 테이블
    SCH_NO NUMBER PRIMARY KEY, -- 일정번호
    SCH_NAME VARCHAR2(2000) NOT NULL, -- 일정 이름
    SCH_CONTENT VARCHAR2(4000) NOT NULL, -- 일정 내용
    SCH_STARTDATE DATE NOT NULL, -- 일정 시작일
    SCH_ENDDATE DATE NOT NULL, -- 일정 종료일
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL, -- 작성자 사원번호
    SCH_ENROLLDATE DATE DEFAULT SYSDATE NOT NULL, -- 등록일    
    SCH_COUNT NUMBER DEFAULT 0 NOT NULL, -- 조회수
    SCH_STATUS CHAR(1) DEFAULT 'c' NOT NULL CHECK (SCH_STATUS IN ('p','c','e','n')) -- 일정 상태(진행중(p) | 검토중(c) | 만료(e))| 삭제(n)
);

--=================================================
--------------- 일정 테이블 코멘트 ---------------
COMMENT ON COLUMN SCHEDULE.SCH_NO IS '일정번호';
COMMENT ON COLUMN SCHEDULE.SCH_NAME IS '일정이름';
COMMENT ON COLUMN SCHEDULE.SCH_CONTENT IS '일정내용';
COMMENT ON COLUMN SCHEDULE.SCH_STARTDATE IS '일정시작일';
COMMENT ON COLUMN SCHEDULE.SCH_ENDDATE IS '일정종료일';
COMMENT ON COLUMN SCHEDULE.EMP_NO IS '사원번호';
COMMENT ON COLUMN SCHEDULE.SCH_ENROLLDATE IS '등록일';
COMMENT ON COLUMN SCHEDULE.SCH_COUNT IS '조회수';
COMMENT ON COLUMN SCHEDULE.SCH_STATUS IS '일정상태';


-- ============================================
-- 프로젝트 생성 시 일정 테이블에 자동 입력하는 트리거
-- ============================================
CREATE OR REPLACE TRIGGER TRG_PROJECT_TO_SCHEDULE
    AFTER INSERT ON PROJECT_TB
    FOR EACH ROW
BEGIN
    -- 일정 테이블에 프로젝트 정보를 기반으로 일정 데이터 삽입
    INSERT INTO SCHEDULE (
        SCH_NO,
        SCH_NAME,
        SCH_CONTENT,
        SCH_STARTDATE,
        SCH_ENDDATE,
        EMP_NO,
        SCH_ENROLLDATE,        
        SCH_STATUS
    ) VALUES (
        :NEW.PJT_NO,                    -- 프로젝트 번호를 일정 번호로 사용
        :NEW.PJT_NAME,                  -- 프로젝트명을 일정명으로 사용
        :NEW.PJT_CONTENT,               -- 프로젝트 내용을 일정 내용으로 사용
        :NEW.PJT_STARTDATE,             -- 프로젝트 시작일을 일정 시작일로 사용
        :NEW.PJT_ENDDATE,               -- 프로젝트 종료일을 일정 종료일로 사용
        :NEW.EMP_NO,                    -- 프로젝트 작성자를 일정 작성자로 사용
        :NEW.PJT_ENROLLDATE,            -- 프로젝트 작성일을 일정 등록일로 사용                                              
        :NEW.PJT_STATUS                 -- 프로젝트 상태를 일정 상태로 사용
    );
END;
/

-- ============================================
-- 일정 상태 변경 시 프로젝트 상태도 함께 변경하는 트리거
-- ============================================
-- 1. 일정 테이블용 COMPOUND TRIGGER
CREATE OR REPLACE TRIGGER TRG_SCHEDULE_SYNC
    FOR UPDATE ON SCHEDULE
    COMPOUND TRIGGER
    
    -- 변경된 데이터를 저장할 컬렉션
    TYPE t_schedule_changes IS TABLE OF SCHEDULE%ROWTYPE INDEX BY PLS_INTEGER;
    schedule_changes t_schedule_changes;
    change_count PLS_INTEGER := 0;
    
    -- BEFORE EACH ROW: 변경될 데이터 수집
    BEFORE EACH ROW IS
    BEGIN
        -- 상태가 실제로 변경된 경우만 수집
        IF :OLD.SCH_STATUS != :NEW.SCH_STATUS THEN
            change_count := change_count + 1;
            schedule_changes(change_count).SCH_NO := :NEW.SCH_NO;
            schedule_changes(change_count).SCH_NAME := :NEW.SCH_NAME;
            schedule_changes(change_count).SCH_STATUS := :NEW.SCH_STATUS;
        END IF;
    END BEFORE EACH ROW;
    
    -- AFTER STATEMENT: 수집된 데이터로 프로젝트 업데이트
    AFTER STATEMENT IS
    BEGIN
        FOR i IN 1..change_count LOOP
            -- 프로젝트 상태 업데이트 (무한루프 방지 포함)
            UPDATE PROJECT_TB
            SET PJT_STATUS = schedule_changes(i).SCH_STATUS
            WHERE PJT_NAME = schedule_changes(i).SCH_NAME
            AND PJT_STATUS != schedule_changes(i).SCH_STATUS; -- 다를 때만 업데이트
            
            -- 디버깅용 로그
            IF SQL%ROWCOUNT > 0 THEN
                DBMS_OUTPUT.PUT_LINE('일정->프로젝트 동기화: ' || schedule_changes(i).SCH_NAME || 
                                   ' 상태변경: ' || schedule_changes(i).SCH_STATUS);
            END IF;
        END LOOP;
        
        -- 컬렉션 초기화
        schedule_changes.DELETE;
        change_count := 0;
    END AFTER STATEMENT;
    
END TRG_SCHEDULE_SYNC;
/

-- 2. 프로젝트 테이블용 COMPOUND TRIGGER  
CREATE OR REPLACE TRIGGER TRG_PROJECT_SYNC
    FOR UPDATE ON PROJECT_TB
    COMPOUND TRIGGER
    
    -- 변경된 데이터를 저장할 컬렉션
    TYPE t_project_changes IS TABLE OF PROJECT_TB%ROWTYPE INDEX BY PLS_INTEGER;
    project_changes t_project_changes;
    change_count PLS_INTEGER := 0;
    
    -- BEFORE EACH ROW: 변경될 데이터 수집
    BEFORE EACH ROW IS
    BEGIN
        -- 상태가 실제로 변경된 경우만 수집
        IF :OLD.PJT_STATUS != :NEW.PJT_STATUS THEN
            change_count := change_count + 1;
            project_changes(change_count).PJT_NO := :NEW.PJT_NO;
            project_changes(change_count).PJT_NAME := :NEW.PJT_NAME;
            project_changes(change_count).PJT_STATUS := :NEW.PJT_STATUS;
        END IF;
    END BEFORE EACH ROW;
    
    -- AFTER STATEMENT: 수집된 데이터로 일정 업데이트
    AFTER STATEMENT IS
    BEGIN
        FOR i IN 1..change_count LOOP
            -- 일정 상태 업데이트 (무한루프 방지 포함)
            UPDATE SCHEDULE
            SET SCH_STATUS = project_changes(i).PJT_STATUS
            WHERE SCH_NAME = project_changes(i).PJT_NAME
            AND SCH_STATUS != project_changes(i).PJT_STATUS; -- 다를 때만 업데이트
            
            -- 디버깅용 로그
            IF SQL%ROWCOUNT > 0 THEN
                DBMS_OUTPUT.PUT_LINE('프로젝트->일정 동기화: ' || project_changes(i).PJT_NAME || 
                                   ' 상태변경: ' || project_changes(i).PJT_STATUS);
            END IF;
        END LOOP;
        
        -- 컬렉션 초기화
        project_changes.DELETE;
        change_count := 0;
    END AFTER STATEMENT;
    
END TRG_PROJECT_SYNC;
/

-- ============================================
-- 채팅방 테이블
-- ============================================
CREATE TABLE CHAT_ROOM_TB ( 
    CHAT_ROOM_ID NUMBER PRIMARY KEY, -- 채팅방 고유 번호 (그룹 채팅방 식별자)
    CHAT_ROOM_TYPE VARCHAR2(10) DEFAULT '1:1' NOT NULL, -- 채팅방 타입 (예: '1:1', 'GROUP')
    CHAT_ROOM_NAME VARCHAR2(100), -- 그룹 채팅방 이름 (선택사항, 1:1 채팅은 NULL)
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL -- 채팅방 생성일
);

--=================================================
--------------- 채팅방 테이블 코멘트 ---------------
COMMENT ON COLUMN CHAT_ROOM_TB.CHAT_ROOM_ID IS '채팅방고유번호';
COMMENT ON COLUMN CHAT_ROOM_TB.CHAT_ROOM_TYPE IS '채팅방타입';
COMMENT ON COLUMN CHAT_ROOM_TB.CHAT_ROOM_NAME IS '채팅방이름';
COMMENT ON COLUMN CHAT_ROOM_TB.CREATE_DATE IS '채팅방생성일';

-- ============================================
-- 메시지 테이블
-- ============================================
CREATE TABLE MESSAGE_TB ( -- 메시지 테이블
    MSG_NO NUMBER PRIMARY KEY, -- 메시지 번호
    EMP_SNO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL, -- 발신사원번호
    CHAT_ROOM_ID NUMBER REFERENCES CHAT_ROOM_TB(CHAT_ROOM_ID) NOT NULL, -- 수신자가 아닌 채팅방 ID를 참조
    MSG_CONTENT VARCHAR2(4000) DEFAULT '내용없음' NOT NULL, -- 메시지 내용
    MSG_DATE DATE DEFAULT SYSDATE NOT NULL, -- 작성일
    IS_READ CHAR(1) DEFAULT 'N' NOT NULL -- 메시지 읽음 상태
);

--=================================================
--------------- 메시지 테이블 코멘트 ---------------
COMMENT ON COLUMN MESSAGE_TB.MSG_NO IS '메시지번호';
COMMENT ON COLUMN MESSAGE_TB.EMP_SNO IS '발신사원번호';
COMMENT ON COLUMN MESSAGE_TB.CHAT_ROOM_ID IS '채팅방ID';
COMMENT ON COLUMN MESSAGE_TB.MSG_CONTENT IS '메시지내용';
COMMENT ON COLUMN MESSAGE_TB.MSG_DATE IS '작성일';
COMMENT ON COLUMN MESSAGE_TB.IS_READ IS '메시지읽음상태';

-- ============================================
-- 채팅방 사원 테이블
-- ============================================
CREATE TABLE CHAT_ROOM_MEMBER_TB ( 
    CHAT_ROOM_ID NUMBER REFERENCES CHAT_ROOM_TB(CHAT_ROOM_ID) NOT NULL,
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL,
    PRIMARY KEY (CHAT_ROOM_ID, EMP_NO) -- 복합 기본키로 중복 방지
);

--=================================================
--------------- 채팅방 사원 테이블 코멘트 ---------------
COMMENT ON COLUMN CHAT_ROOM_MEMBER_TB.CHAT_ROOM_ID IS '채팅방ID';
COMMENT ON COLUMN CHAT_ROOM_MEMBER_TB.EMP_NO IS '사원번호';

-- ============================================
-- 요청사항 테이블
-- ============================================
CREATE TABLE REQUIREMENT_TB (
    REQ_NO NUMBER NOT NULL, -- 요청사항번호
    ATT_NO NUMBER, -- 첨부파일번호
    EMP_NO NUMBER NOT NULL,  -- 사원번호
    REQ_STATUS CHAR(1) DEFAULT 'P' NOT NULL, -- 처리상태(처리중:'P'/승인:'A'/거부:'D') 
    REQ_TITLE VARCHAR2(1000)  NOT NULL, -- 요청사항제목
    REQ_CONTENT  VARCHAR2(4000)  NOT NULL,  -- 요청사항내용
    REQ_REJECT VARCHAR2(4000), -- 반려사항 내용
    REQ_ACCEPTDATE DATE DEFAULT SYSDATE,  -- 요청사항수신일
    REQ_APPDATE DATE, -- 요청사항처리일

    PRIMARY KEY (REQ_NO),
    FOREIGN KEY (ATT_NO) REFERENCES ATTACHMENT_TB(ATT_NO),
    FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE_TB(EMP_NO)
);

--=================================================
--------------- 요청사항 테이블 코멘트 ---------------
COMMENT ON COLUMN REQUIREMENT_TB.REQ_NO IS '요청사항번호';
COMMENT ON COLUMN REQUIREMENT_TB.ATT_NO IS '첨부파일번호';
COMMENT ON COLUMN REQUIREMENT_TB.EMP_NO IS '작성자번호';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_STATUS IS '요청사항상태';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_TITLE IS '요청사항제목';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_CONTENT IS '요청사항내용';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_REJECT IS '반려사항내용';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_ACCEPTDATE IS '요청사항수신일';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_APPDATE IS '요청사항처리일';


COMMIT;



-- ============================================
-- 스케줄러 사용을 위해 관리자 권한에서 GRANT CREATE JOB TO semi; GRANT EXECUTE ON DBMS_SCHEDULER TO semi;
-- ============================================
-- 기존 스케줄러 삭제
BEGIN
  DBMS_SCHEDULER.DROP_JOB('UPDATE_EXPIRED_SCHEDULES');
END;
/
-- 만료 일정 업데이트 스케쥴러 
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name        => 'UPDATE_EXPIRED_SCHEDULES',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN UPDATE SCHEDULE SET SCH_STATUS = ''e'' WHERE SCH_ENDDATE < TRUNC(SYSDATE) AND SCH_STATUS != ''e''; COMMIT; END;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=DAILY; BYHOUR=0; BYMINUTE=0; BYSECOND=0',
    enabled         => TRUE,
    comments        => '매일 자정에 만료된 일정을 ''e''로 업데이트'
  );
END;
/

COMMIT;
