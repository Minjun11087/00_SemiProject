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
-- ������
-- ============================================
CREATE SEQUENCE SEQ_ENO START WITH 100 NOCYCLE NOCACHE; -- �����ȣ
CREATE SEQUENCE SEQ_PNO START WITH 1 NOCYCLE NOCACHE; -- ������Ʈ��ȣ
CREATE SEQUENCE SEQ_VNO START WITH 1 NOCYCLE NOCACHE; -- �ް���ȣ
CREATE SEQUENCE SEQ_SNO START WITH 1 NOCYCLE NOCACHE; -- ������ȣ
CREATE SEQUENCE SEQ_ANO START WITH 1 NOCYCLE NOCACHE; -- �����ȣ
CREATE SEQUENCE SEQ_MNO START WITH 1 NOCYCLE NOCACHE; -- �޼�����ȣ
CREATE SEQUENCE SEQ_RNO NOCYCLE NOCACHE; -- ��û��ȣ
CREATE SEQUENCE SEQ_CNO NOCYCLE NOCACHE; -- ����ȣ
CREATE SEQUENCE SEQ_ATNO NOCYCLE NOCACHE; -- ÷�����Ϲ�ȣ
CREATE SEQUENCE SEQ_FNO NOCYCLE NOCACHE; -- ���ι�ȣ
CREATE SEQUENCE SEQ_CRNO START WITH 1 INCREMENT BY 1 NOCACHE; -- ä�ù��ȣ

-- �� ���̺�
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
-----------------�� ���̺� �ڸ�Ʈ------------------
COMMENT ON COLUMN CUSTOMER_TB.CUS_NO IS '����ȣ';
COMMENT ON COLUMN CUSTOMER_TB.CUS_NAME IS '����';
COMMENT ON COLUMN CUSTOMER_TB.CUS_GENDER IS '������';
COMMENT ON COLUMN CUSTOMER_TB.CUS_AGE IS '������';
COMMENT ON COLUMN CUSTOMER_TB.CUS_RESINUM IS '���ֹι�ȣ';
COMMENT ON COLUMN CUSTOMER_TB.CUS_ADDRESS IS '���ּ�';
COMMENT ON COLUMN CUSTOMER_TB.CUS_PHONE IS '������ó';
COMMENT ON COLUMN CUSTOMER_TB.CUS_EMAIL IS '���̸���';
COMMENT ON COLUMN CUSTOMER_TB.CUS_JOB IS '������';
COMMENT ON COLUMN CUSTOMER_TB.CUS_ENROLLDATE IS '����ϳ�¥';
COMMENT ON COLUMN CUSTOMER_TB.LOAN IS '������Ȳ';
COMMENT ON COLUMN CUSTOMER_TB.AMOUNT IS '����ݾ�';
COMMENT ON COLUMN CUSTOMER_TB.INTEREST IS '������';
COMMENT ON COLUMN CUSTOMER_TB.RATING IS '�ſ���';
-- ============================================
-- CUSTOMER_TB ���� ������
-- ============================================
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'ȣ����','M', 33, '930101-1234567','��������','010-4444-5678','tiger@company.com', 0.4);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�䳢','F', 32, '940101-2234567','��������','010-5152-5678','rabbit@company.com', 0.3);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�ڳ���','M', 30, '960101-1234567','���ĸ�','010-6524-5678','elephant@company.com', 0.7);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'����','M', 29, '970101-1234567','�Ե�����','010-8512-5678','lion@company.com', 0.6);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'���','F', 33, '930201-2234567','��������','010-4244-5678','ks@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'����','M', 32, '940102-1234567','��������','010-5452-5678','jbam@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�ڻ罿','F', 30, '960301-2234567','���ĸ�','010-6525-5278','pss@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'��ȣ��','M', 29, '970401-1234567','�Ե�����','010-8513-5278','tiger@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'����','F', 29, '970204-2234567','���ֿ���','010-4254-5178','kyh@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'������','M', 32, '941202-1235567','�ܵ�����','010-5472-2678','gaj@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'���ܹ�','F', 30, '960321-2235567','���ĸ�','010-6535-5778','hbb@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'ȣ�ڹ�','M', 29, '971101-1239567','�Ե�����','010-8593-5278','jgb@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�ڰ�','M', 29, '970419-1234967','�Ե�����','010-1533-5978','parkg@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'������','F', 29, '971004-2254567','���ֿ���','010-4954-5678','jbg@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'������','M', 32, '941212-1435567','���ڿ�','010-5252-2579','wons@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'����','F', 30, '960511-2635567','���ĸ�','010-6325-5174','jh@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�ڸ�','M', 29, '971016-1229567','�Ե�����','010-8621-5798','bkb@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�̺ξ�','M', 29, '971120-1264967','�Ե�����','010-6245-5976','lbu@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�޹���','F', 29, '971214-2234567','���ֿ���','010-2674-5278','yangm@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'������','M', 32, '941118-1425427','���ڿ�','010-5357-2472','jddol@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'���ʹ�','F', 30, '960121-2655765','���ĸ�','010-6135-5254','scho@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'��ȣġ','M', 29, '971118-1427567','�Ե�����','010-2611-4758','hochi@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'����','M', 29, '971012-1466897','�Ե�����','010-1155-4764','drago@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�̿��','F', 29, '971214-2234567','���ֿ���','010-6624-5177','yorong@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'������','M', 32, '941211-1585027','���ڿ�','010-1317-4442','jddung2@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'��̹�','F', 30, '960225-2257795','���ĸ�','010-3435-2154','backmm@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�̸���','M', 29, '971211-1628506','�Ե�����','010-2321-4551','macho@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�ӹ�ġ','M', 29, '971028-1461934','�Ե�����','010-2135-9473','immc@gmail.com', 0.2);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'����','M', 29, '970617-1584937','���ֿ���','010-2375-5679','gorila@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'�δ���','M', 32, '940121-1526497','���ڿ�','010-1151-2232','dudug@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'������','F', 30, '961010-2646898','���ĸ�','010-2432-2234','omok@gmail.com', 0.1);
INSERT INTO CUSTOMER_TB (CUS_NO, CUS_NAME, CUS_GENDER, CUS_AGE, CUS_RESINUM, 
    CUS_ADDRESS, CUS_PHONE, CUS_EMAIL, INTEREST)
VALUES (SEQ_CNO.NEXTVAL,'����¡','M', 29, '970158-1446897','�Ե�����','010-5522-4467','ojin@gmail.com', 0.2);

--=================================================
----------------------- �� ���� ������ ������Ʈ ------------------------- 
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
------------------ ������ �߰��� ���� ���� ���̺� ---------------------
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
------------------ ������ �߰��� ���� ���� ���̺� ---------------------
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
----- ����ݾ� 0������ �ڵ� ���⿩�� N Ʈ���� -----------------
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
------------------ ������ ���̺� ------------------
CREATE TABLE ACCOUNT_TB(
    ACC_NUM CHAR(16) PRIMARY KEY,
    ACC_PWD VARCHAR2(100) NOT NULL,
    CUS_NO NUMBER REFERENCES CUSTOMER_TB(CUS_NO),
    ACC_STATUS CHAR(1) DEFAULT 'Y' CHECK(ACC_STATUS IN ('Y', 'N'))
);

--=================================================
--------------- ������ ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN ACCOUNT_TB.ACC_NUM IS '�����¹�ȣ';
COMMENT ON COLUMN ACCOUNT_TB.ACC_PWD IS '�����º��';
COMMENT ON COLUMN ACCOUNT_TB.CUS_NO IS '����ȣ';
COMMENT ON COLUMN ACCOUNT_TB.ACC_STATUS IS '�����»���';


----------------- ÷������ ���̺� -------------------
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
--------------- ÷������ ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN ATTACHMENT_TB.ATT_NO IS '÷�����Ϲ�ȣ';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_CHANGENAME IS '�������ϸ�';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_ORIGIN IS '�������ϸ�';
COMMENT ON COLUMN ATTACHMENT_TB.REF_NO IS '�Ҽӱ۹�ȣ';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_CATEGORY IS '�����Խù���ȣ';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_FILEPATH IS '���ϰ��';
COMMENT ON COLUMN ATTACHMENT_TB.UPLOAD_DATE IS '���峯¥';

-- ============================================
-- �μ� ���̺�
-- ============================================
CREATE TABLE DEPARTMENT ( -- �μ� ���̺�
    DEPT_CODE CHAR(2) PRIMARY KEY, -- �μ��ڵ�(D1~D6)
    DEPT_TITLE VARCHAR2(20) NOT NULL -- �μ���(1������ 2�ѹ��� 3�λ�� 4������ 5������ 6������)
);

--=================================================
--------------- �μ� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN DEPARTMENT.DEPT_CODE IS '�μ��ڵ�';
COMMENT ON COLUMN DEPARTMENT.DEPT_TITLE IS '�μ���';

-- ============================================
-- 5. DEPARTMENT_TB ���� ������
-- ============================================
INSERT INTO DEPARTMENT VALUES('D1','������');
INSERT INTO DEPARTMENT VALUES('D2','�ѹ���');
INSERT INTO DEPARTMENT VALUES('D3','�λ��');
INSERT INTO DEPARTMENT VALUES('D4','������');
INSERT INTO DEPARTMENT VALUES('D5','������');
INSERT INTO DEPARTMENT VALUES('D6','������');
INSERT INTO DEPARTMENT VALUES('D7','�ӽúμ�');

-- ============================================
-- ���� ���̺�
-- ============================================
CREATE TABLE JOB_TB ( -- ���� ���̺�
    JOB_CODE CHAR(2) PRIMARY KEY, -- �����ڵ�(J1~J4)
    JOB_TITLE VARCHAR2(20) NOT NULL -- ���޸�(1������ 2���� 3���� 4���)
);

--=================================================
--------------- ���� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN JOB_TB.JOB_CODE IS '�����ڵ�';
COMMENT ON COLUMN JOB_TB.JOB_TITLE IS '���޸�';

-- ============================================
-- JOB_TB ���� ������
-- ============================================
INSERT INTO JOB_TB VALUES('J1','������');
INSERT INTO JOB_TB VALUES('J2','����');
INSERT INTO JOB_TB VALUES('J3','����');
INSERT INTO JOB_TB VALUES('J4','���');
INSERT INTO JOB_TB VALUES('J5','�ӽ�����');

-- ============================================
-- ��� ���̺�
-- ============================================
CREATE TABLE EMPLOYEE_TB ( -- ��� ���̺�
    EMP_NO NUMBER PRIMARY KEY, -- �����ȣ
    EMP_NAME VARCHAR2(20) NOT NULL, -- ����̸�
    EMP_RESINUM VARCHAR2(6) NOT NULL, -- ����������
    EMP_ID VARCHAR2(20) NOT NULL UNIQUE, -- ������̵�
    EMP_PWD VARCHAR2(100) NOT NULL, -- ��� ��й�ȣ
    EMP_GENDER CHAR(1) CHECK (EMP_GENDER IN ('M','F')) NOT NULL, -- ����(���ڴ� 'M', ���ڴ� 'F'�� ����)
    DEPT_CODE CHAR(2) DEFAULT 'D7' REFERENCES DEPARTMENT(DEPT_CODE), -- �μ��ڵ� (�μ� ���̺� ����)
    JOB_CODE CHAR(2) DEFAULT 'J5' REFERENCES JOB_TB(JOB_CODE), -- �����ڵ� (���� ���̺� ����)
    EMP_PHONE VARCHAR2(13) NOT NULL, -- ��ȭ��ȣ
    EMP_EMAIL VARCHAR2(50), -- �̸���
    EMP_ADDRESS VARCHAR2(4000) NOT NULL, -- �ּ�
    EMP_STATUS CHAR(1) DEFAULT 'Y' NOT NULL, -- ��������(����ϸ� N���� ����)
    ATT_NO NUMBER REFERENCES ATTACHMENT_TB(ATT_NO), -- �������
    SALARY NUMBER, -- �޿�
    BONUS NUMBER DEFAULT 0,
    HIRE_DATE DATE DEFAULT SYSDATE, -- �Ի糯¥
    MODIFY_DATE DATE DEFAULT SYSDATE, -- ������¥
    EMP_PICTURE VARCHAR2(4000), -- �������(���� ��ũ ���ڿ��� ����)
    MESSENGER_STATUS CHAR(1) DEFAULT 'N' CHECK (MESSENGER_STATUS IN ('Y', 'N'))  -- �޽��� ���ӻ���
);

--=================================================
--------------- ��� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN EMPLOYEE_TB.EMP_NO IS '�����ȣ';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_NAME IS '�����ȣ';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_RESINUM IS '����������';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_ID IS '������̵�';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_PWD IS '�����й�ȣ';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_GENDER IS '����';
COMMENT ON COLUMN EMPLOYEE_TB.DEPT_CODE IS '�μ��ڵ�';
COMMENT ON COLUMN EMPLOYEE_TB.JOB_CODE IS '�����ڵ�';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_EMAIL IS '�̸���';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_ADDRESS IS '�ּ�';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_STATUS IS '��������';
COMMENT ON COLUMN EMPLOYEE_TB.ATT_NO  IS '�������';
COMMENT ON COLUMN EMPLOYEE_TB.SALARY IS '�޿�';
COMMENT ON COLUMN EMPLOYEE_TB.BONUS IS '���ʽ�';
COMMENT ON COLUMN EMPLOYEE_TB.HIRE_DATE IS '�Ի���';
COMMENT ON COLUMN EMPLOYEE_TB.MODIFY_DATE IS '������';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_PICTURE IS '�������';
COMMENT ON COLUMN EMPLOYEE_TB.MESSENGER_STATUS IS '�޽������ӻ���';


-- ============================================
-- �ް� ���̺�
-- ============================================
CREATE TABLE VACATION_TB ( -- �ް� ���̺�
    VAC_NO NUMBER PRIMARY KEY, -- �ް���ȣ
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO), -- �����ȣ (��� ���̺� ����)
    VAC_SDATE DATE, -- �ް� ���� ��¥
    VAC_EDATE DATE, -- �ް� ���� ��¥
    VAC_STATUS CHAR(1) CHECK(VAC_STATUS IN ('Y','N')) -- �ް� ����
);

--=================================================
--------------- �ް� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN VACATION_TB.VAC_NO IS '�ް���ȣ';
COMMENT ON COLUMN VACATION_TB.EMP_NO IS '�����ȣ';
COMMENT ON COLUMN VACATION_TB.VAC_SDATE IS '�ް�������';
COMMENT ON COLUMN VACATION_TB.VAC_EDATE IS '�ް�������';
COMMENT ON COLUMN VACATION_TB.VAC_STATUS IS '�ް�����';

-- ============================================
-- �ް� ���� Ʈ����
-- ============================================
CREATE OR REPLACE TRIGGER TRG_VAC
    BEFORE INSERT OR UPDATE ON VACATION_TB
    FOR EACH ROW
BEGIN
    -- �ް� �������� �ԷµǾ��� �� �ް����¸� 'Y'�� ����
    IF :NEW.VAC_SDATE IS NOT NULL THEN
        :NEW.VAC_STATUS := 'Y';
    END IF;
END;
/

-- ============================================
-- ������Ʈ ���̺�
-- ============================================
CREATE TABLE PROJECT_TB ( -- ������Ʈ ���̺�
    PJT_NO NUMBER PRIMARY KEY, -- ������Ʈ��ȣ
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL, -- �ۼ���ID
    PJT_NAME VARCHAR2(2000) NOT NULL, -- ������Ʈ��
    PJT_STARTDATE DATE NOT NULL, --������Ʈ ������
    PJT_ENDDATE DATE NOT NULL, --������Ʈ ������
    PJT_ENROLLDATE DATE DEFAULT SYSDATE NOT NULL, -- ������Ʈ �ۼ���
    PJT_COUNT NUMBER DEFAULT 0, -- ��ȸ��
    PJT_STATUS CHAR(1) DEFAULT 'c' NOT NULL CHECK (PJT_STATUS IN ('p','c','e','n')), -- ������Ʈ ����(������(p) | ������(c) | ����(e) | ����(n))
    PJT_CONTENT VARCHAR2(4000) NOT NULL, -- ������Ʈ ����
    PJT_TAGS VARCHAR2(1000) DEFAULT ' ' NOT NULL
);

--=================================================
--------------- ������Ʈ ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN PROJECT_TB.PJT_NO IS '������Ʈ��ȣ';
COMMENT ON COLUMN PROJECT_TB.EMP_NO IS '�ۼ��ڻ����ȣ';
COMMENT ON COLUMN PROJECT_TB.PJT_NAME IS '������Ʈ�̸�';
COMMENT ON COLUMN PROJECT_TB.PJT_ENROLLDATE IS '�ۼ���';
COMMENT ON COLUMN PROJECT_TB.PJT_COUNT IS '��ȸ��';
COMMENT ON COLUMN PROJECT_TB.PJT_STATUS IS '����';
COMMENT ON COLUMN PROJECT_TB.PJT_CONTENT IS '������Ʈ����';

-- ============================================
-- ������Ʈ ������ ���̺�
-- ============================================
CREATE TABLE PROJECTMEMBER_TB ( -- ������Ʈ������ ���̺�
    PJT_NO NUMBER NOT NULL REFERENCES PROJECT_TB(PJT_NO), -- ������Ʈ��ȣ
    EMP_NO NUMBER NOT NULL REFERENCES EMPLOYEE_TB(EMP_NO), -- �����ȣ
    PRIMARY KEY (PJT_NO, EMP_NO) -- ����Ű
);

--=================================================
--------------- ������Ʈ ������ ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN PROJECTMEMBER_TB.PJT_NO IS '������Ʈ��ȣ';
COMMENT ON COLUMN PROJECTMEMBER_TB.EMP_NO IS '�ۼ��ڻ����ȣ';


-- ============================================
-- ���� �Խ��� ���̺�
-- ============================================
CREATE TABLE APP_BOARD ( -- ����Խ��� ���̺�
    APP_NO NUMBER PRIMARY KEY, -- �����ȣ
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO), -- �����ȣ
    APP_TITLE VARCHAR2(4000) NOT NULL, -- ���� ����
    APP_CONTENT VARCHAR2(4000) NOT NULL, -- ���� ����
    CREATE_DATE DATE DEFAULT SYSDATE, -- �����
    APP_STATUS VARCHAR(3) DEFAULT 'U' CHECK (APP_STATUS IN ('U','A','D')), -- ����(U:���, A:����, D:�ݷ�)
    APP_DATE DATE DEFAULT SYSDATE, -- ������
    APP_SHOWSTATUS VARCHAR(3) DEFAULT 'Y' CHECK (APP_SHOWSTATUS IN ('Y', 'N')),
    MANAGER_STATUS VARCHAR(3) DEFAULT 'U' CHECK (MANAGER_STATUS IN ('U', 'A', 'D')),
    FINAL_STATUS VARCHAR(3) DEFAULT 'U' CHECK (FINAL_STATUS IN ('U', 'A', 'D'))
);

--=================================================
--------------- ���� �Խ��� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN APP_BOARD.APP_NO IS '�����ȣ';
COMMENT ON COLUMN APP_BOARD.EMP_NO IS '�����ȣ';
COMMENT ON COLUMN APP_BOARD.APP_TITLE IS '��������';
COMMENT ON COLUMN APP_BOARD.APP_CONTENT IS '���系��';
COMMENT ON COLUMN APP_BOARD.CREATE_DATE IS '�����';
COMMENT ON COLUMN APP_BOARD.APP_STATUS IS '�������';
COMMENT ON COLUMN APP_BOARD.APP_DATE IS '������';
COMMENT ON COLUMN APP_BOARD.APP_SHOWSTATUS IS '�����翩��';
COMMENT ON COLUMN APP_BOARD.MANAGER_STATUS IS '1�����ο���';
COMMENT ON COLUMN APP_BOARD.FINAL_STATUS IS '�������ο���';



-- ============================================
-- ���ε� ���� ���̺�
-- ============================================
CREATE TABLE FINAL_APP ( -- ���ε� ���� ���̺�
    FA_NO NUMBER PRIMARY KEY, -- ���ι�ȣ
    APP_NO NUMBER REFERENCES APP_BOARD(APP_NO) NOT NULL -- �����ȣ 
    
);

--=================================================
--------------- ���ε� ���� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN FINAL_APP.FA_NO IS '���ι�ȣ';
COMMENT ON COLUMN FINAL_APP.APP_NO IS '�����ȣ';


-- ============================================



-- ����Խ��ǿ��� ���� �� ���ε� ���� ���̺�� �ڵ� �߰� Ʈ����
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
-- ���� ���̺�
-- ============================================
CREATE TABLE SCHEDULE ( -- ���� ���̺�
    SCH_NO NUMBER PRIMARY KEY, -- ������ȣ
    SCH_NAME VARCHAR2(2000) NOT NULL, -- ���� �̸�
    SCH_CONTENT VARCHAR2(4000) NOT NULL, -- ���� ����
    SCH_STARTDATE DATE NOT NULL, -- ���� ������
    SCH_ENDDATE DATE NOT NULL, -- ���� ������
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL, -- �ۼ��� �����ȣ
    SCH_ENROLLDATE DATE DEFAULT SYSDATE NOT NULL, -- �����    
    SCH_COUNT NUMBER DEFAULT 0 NOT NULL, -- ��ȸ��
    SCH_STATUS CHAR(1) DEFAULT 'c' NOT NULL CHECK (SCH_STATUS IN ('p','c','e','n')) -- ���� ����(������(p) | ������(c) | ����(e))| ����(n)
);

--=================================================
--------------- ���� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN SCHEDULE.SCH_NO IS '������ȣ';
COMMENT ON COLUMN SCHEDULE.SCH_NAME IS '�����̸�';
COMMENT ON COLUMN SCHEDULE.SCH_CONTENT IS '��������';
COMMENT ON COLUMN SCHEDULE.SCH_STARTDATE IS '����������';
COMMENT ON COLUMN SCHEDULE.SCH_ENDDATE IS '����������';
COMMENT ON COLUMN SCHEDULE.EMP_NO IS '�����ȣ';
COMMENT ON COLUMN SCHEDULE.SCH_ENROLLDATE IS '�����';
COMMENT ON COLUMN SCHEDULE.SCH_COUNT IS '��ȸ��';
COMMENT ON COLUMN SCHEDULE.SCH_STATUS IS '��������';


-- ============================================
-- ������Ʈ ���� �� ���� ���̺� �ڵ� �Է��ϴ� Ʈ����
-- ============================================
CREATE OR REPLACE TRIGGER TRG_PROJECT_TO_SCHEDULE
    AFTER INSERT ON PROJECT_TB
    FOR EACH ROW
BEGIN
    -- ���� ���̺� ������Ʈ ������ ������� ���� ������ ����
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
        :NEW.PJT_NO,                    -- ������Ʈ ��ȣ�� ���� ��ȣ�� ���
        :NEW.PJT_NAME,                  -- ������Ʈ���� ���������� ���
        :NEW.PJT_CONTENT,               -- ������Ʈ ������ ���� �������� ���
        :NEW.PJT_STARTDATE,             -- ������Ʈ �������� ���� �����Ϸ� ���
        :NEW.PJT_ENDDATE,               -- ������Ʈ �������� ���� �����Ϸ� ���
        :NEW.EMP_NO,                    -- ������Ʈ �ۼ��ڸ� ���� �ۼ��ڷ� ���
        :NEW.PJT_ENROLLDATE,            -- ������Ʈ �ۼ����� ���� ����Ϸ� ���                                              
        :NEW.PJT_STATUS                 -- ������Ʈ ���¸� ���� ���·� ���
    );
END;
/

-- ============================================
-- ���� ���� ���� �� ������Ʈ ���µ� �Բ� �����ϴ� Ʈ����
-- ============================================
-- 1. ���� ���̺�� COMPOUND TRIGGER
CREATE OR REPLACE TRIGGER TRG_SCHEDULE_SYNC
    FOR UPDATE ON SCHEDULE
    COMPOUND TRIGGER
    
    -- ����� �����͸� ������ �÷���
    TYPE t_schedule_changes IS TABLE OF SCHEDULE%ROWTYPE INDEX BY PLS_INTEGER;
    schedule_changes t_schedule_changes;
    change_count PLS_INTEGER := 0;
    
    -- BEFORE EACH ROW: ����� ������ ����
    BEFORE EACH ROW IS
    BEGIN
        -- ���°� ������ ����� ��츸 ����
        IF :OLD.SCH_STATUS != :NEW.SCH_STATUS THEN
            change_count := change_count + 1;
            schedule_changes(change_count).SCH_NO := :NEW.SCH_NO;
            schedule_changes(change_count).SCH_NAME := :NEW.SCH_NAME;
            schedule_changes(change_count).SCH_STATUS := :NEW.SCH_STATUS;
        END IF;
    END BEFORE EACH ROW;
    
    -- AFTER STATEMENT: ������ �����ͷ� ������Ʈ ������Ʈ
    AFTER STATEMENT IS
    BEGIN
        FOR i IN 1..change_count LOOP
            -- ������Ʈ ���� ������Ʈ (���ѷ��� ���� ����)
            UPDATE PROJECT_TB
            SET PJT_STATUS = schedule_changes(i).SCH_STATUS
            WHERE PJT_NAME = schedule_changes(i).SCH_NAME
            AND PJT_STATUS != schedule_changes(i).SCH_STATUS; -- �ٸ� ���� ������Ʈ
            
            -- ������ �α�
            IF SQL%ROWCOUNT > 0 THEN
                DBMS_OUTPUT.PUT_LINE('����->������Ʈ ����ȭ: ' || schedule_changes(i).SCH_NAME || 
                                   ' ���º���: ' || schedule_changes(i).SCH_STATUS);
            END IF;
        END LOOP;
        
        -- �÷��� �ʱ�ȭ
        schedule_changes.DELETE;
        change_count := 0;
    END AFTER STATEMENT;
    
END TRG_SCHEDULE_SYNC;
/

-- 2. ������Ʈ ���̺�� COMPOUND TRIGGER  
CREATE OR REPLACE TRIGGER TRG_PROJECT_SYNC
    FOR UPDATE ON PROJECT_TB
    COMPOUND TRIGGER
    
    -- ����� �����͸� ������ �÷���
    TYPE t_project_changes IS TABLE OF PROJECT_TB%ROWTYPE INDEX BY PLS_INTEGER;
    project_changes t_project_changes;
    change_count PLS_INTEGER := 0;
    
    -- BEFORE EACH ROW: ����� ������ ����
    BEFORE EACH ROW IS
    BEGIN
        -- ���°� ������ ����� ��츸 ����
        IF :OLD.PJT_STATUS != :NEW.PJT_STATUS THEN
            change_count := change_count + 1;
            project_changes(change_count).PJT_NO := :NEW.PJT_NO;
            project_changes(change_count).PJT_NAME := :NEW.PJT_NAME;
            project_changes(change_count).PJT_STATUS := :NEW.PJT_STATUS;
        END IF;
    END BEFORE EACH ROW;
    
    -- AFTER STATEMENT: ������ �����ͷ� ���� ������Ʈ
    AFTER STATEMENT IS
    BEGIN
        FOR i IN 1..change_count LOOP
            -- ���� ���� ������Ʈ (���ѷ��� ���� ����)
            UPDATE SCHEDULE
            SET SCH_STATUS = project_changes(i).PJT_STATUS
            WHERE SCH_NAME = project_changes(i).PJT_NAME
            AND SCH_STATUS != project_changes(i).PJT_STATUS; -- �ٸ� ���� ������Ʈ
            
            -- ������ �α�
            IF SQL%ROWCOUNT > 0 THEN
                DBMS_OUTPUT.PUT_LINE('������Ʈ->���� ����ȭ: ' || project_changes(i).PJT_NAME || 
                                   ' ���º���: ' || project_changes(i).PJT_STATUS);
            END IF;
        END LOOP;
        
        -- �÷��� �ʱ�ȭ
        project_changes.DELETE;
        change_count := 0;
    END AFTER STATEMENT;
    
END TRG_PROJECT_SYNC;
/

-- ============================================
-- ä�ù� ���̺�
-- ============================================
CREATE TABLE CHAT_ROOM_TB ( 
    CHAT_ROOM_ID NUMBER PRIMARY KEY, -- ä�ù� ���� ��ȣ (�׷� ä�ù� �ĺ���)
    CHAT_ROOM_TYPE VARCHAR2(10) DEFAULT '1:1' NOT NULL, -- ä�ù� Ÿ�� (��: '1:1', 'GROUP')
    CHAT_ROOM_NAME VARCHAR2(100), -- �׷� ä�ù� �̸� (���û���, 1:1 ä���� NULL)
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL -- ä�ù� ������
);

--=================================================
--------------- ä�ù� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN CHAT_ROOM_TB.CHAT_ROOM_ID IS 'ä�ù������ȣ';
COMMENT ON COLUMN CHAT_ROOM_TB.CHAT_ROOM_TYPE IS 'ä�ù�Ÿ��';
COMMENT ON COLUMN CHAT_ROOM_TB.CHAT_ROOM_NAME IS 'ä�ù��̸�';
COMMENT ON COLUMN CHAT_ROOM_TB.CREATE_DATE IS 'ä�ù������';

-- ============================================
-- �޽��� ���̺�
-- ============================================
CREATE TABLE MESSAGE_TB ( -- �޽��� ���̺�
    MSG_NO NUMBER PRIMARY KEY, -- �޽��� ��ȣ
    EMP_SNO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL, -- �߽Ż����ȣ
    CHAT_ROOM_ID NUMBER REFERENCES CHAT_ROOM_TB(CHAT_ROOM_ID) NOT NULL, -- �����ڰ� �ƴ� ä�ù� ID�� ����
    MSG_CONTENT VARCHAR2(4000) DEFAULT '�������' NOT NULL, -- �޽��� ����
    MSG_DATE DATE DEFAULT SYSDATE NOT NULL, -- �ۼ���
    IS_READ CHAR(1) DEFAULT 'N' NOT NULL -- �޽��� ���� ����
);

--=================================================
--------------- �޽��� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN MESSAGE_TB.MSG_NO IS '�޽�����ȣ';
COMMENT ON COLUMN MESSAGE_TB.EMP_SNO IS '�߽Ż����ȣ';
COMMENT ON COLUMN MESSAGE_TB.CHAT_ROOM_ID IS 'ä�ù�ID';
COMMENT ON COLUMN MESSAGE_TB.MSG_CONTENT IS '�޽�������';
COMMENT ON COLUMN MESSAGE_TB.MSG_DATE IS '�ۼ���';
COMMENT ON COLUMN MESSAGE_TB.IS_READ IS '�޽�����������';

-- ============================================
-- ä�ù� ��� ���̺�
-- ============================================
CREATE TABLE CHAT_ROOM_MEMBER_TB ( 
    CHAT_ROOM_ID NUMBER REFERENCES CHAT_ROOM_TB(CHAT_ROOM_ID) NOT NULL,
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL,
    PRIMARY KEY (CHAT_ROOM_ID, EMP_NO) -- ���� �⺻Ű�� �ߺ� ����
);

--=================================================
--------------- ä�ù� ��� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN CHAT_ROOM_MEMBER_TB.CHAT_ROOM_ID IS 'ä�ù�ID';
COMMENT ON COLUMN CHAT_ROOM_MEMBER_TB.EMP_NO IS '�����ȣ';

-- ============================================
-- ��û���� ���̺�
-- ============================================
CREATE TABLE REQUIREMENT_TB (
    REQ_NO NUMBER NOT NULL, -- ��û���׹�ȣ
    ATT_NO NUMBER, -- ÷�����Ϲ�ȣ
    EMP_NO NUMBER NOT NULL,  -- �����ȣ
    REQ_STATUS CHAR(1) DEFAULT 'P' NOT NULL, -- ó������(ó����:'P'/����:'A'/�ź�:'D') 
    REQ_TITLE VARCHAR2(1000)  NOT NULL, -- ��û��������
    REQ_CONTENT  VARCHAR2(4000)  NOT NULL,  -- ��û���׳���
    REQ_REJECT VARCHAR2(4000), -- �ݷ����� ����
    REQ_ACCEPTDATE DATE DEFAULT SYSDATE,  -- ��û���׼�����
    REQ_APPDATE DATE, -- ��û����ó����

    PRIMARY KEY (REQ_NO),
    FOREIGN KEY (ATT_NO) REFERENCES ATTACHMENT_TB(ATT_NO),
    FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE_TB(EMP_NO)
);

--=================================================
--------------- ��û���� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN REQUIREMENT_TB.REQ_NO IS '��û���׹�ȣ';
COMMENT ON COLUMN REQUIREMENT_TB.ATT_NO IS '÷�����Ϲ�ȣ';
COMMENT ON COLUMN REQUIREMENT_TB.EMP_NO IS '�ۼ��ڹ�ȣ';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_STATUS IS '��û���׻���';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_TITLE IS '��û��������';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_CONTENT IS '��û���׳���';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_REJECT IS '�ݷ����׳���';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_ACCEPTDATE IS '��û���׼�����';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_APPDATE IS '��û����ó����';


COMMIT;



-- ============================================
-- �����ٷ� ����� ���� ������ ���ѿ��� GRANT CREATE JOB TO semi; GRANT EXECUTE ON DBMS_SCHEDULER TO semi;
-- ============================================
-- ���� �����ٷ� ����
BEGIN
  DBMS_SCHEDULER.DROP_JOB('UPDATE_EXPIRED_SCHEDULES');
END;
/
-- ���� ���� ������Ʈ �����췯 
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name        => 'UPDATE_EXPIRED_SCHEDULES',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN UPDATE SCHEDULE SET SCH_STATUS = ''e'' WHERE SCH_ENDDATE < TRUNC(SYSDATE) AND SCH_STATUS != ''e''; COMMIT; END;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=DAILY; BYHOUR=0; BYMINUTE=0; BYSECOND=0',
    enabled         => TRUE,
    comments        => '���� ������ ����� ������ ''e''�� ������Ʈ'
  );
END;
/

COMMIT;
