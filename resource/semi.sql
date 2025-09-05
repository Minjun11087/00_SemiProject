DROP TABLE FINAL_APP;
DROP TABLE VACATION_TB;
DROP TABLE PROJECTMEMBER_TB;
DROP TABLE APP_BOARD;
DROP TABLE SCHEDULE;
DROP TABLE MESSAGE_TB;
DROP TABLE REQUIREMENT_TB;
DROP TABLE ACCOUNT_TB;
DROP TABLE CUSTOMER_TB;
DROP TABLE ATTACHMENT_TB;
DROP TABLE PROJECT_TB;
DROP TABLE EMPLOYEE_TB;
DROP TABLE DEPARTMENT;
DROP TABLE JOB_TB;

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
    LOAN CHAR(1) DEFAULT 'N' CHECK(LOAN IN ('N', 'Y')),
    AMOUNT NUMBER DEFAULT 0.0,
    INTEREST NUMBER,
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

-- ============================================
-- ACCOUNT_TB ���� ������
-- ============================================
INSERT INTO ACCOUNT_TB (ACC_NUM, ACC_PWD, CUS_NO)
VALUES ('425123-01-424253', 1234, 4);
INSERT INTO ACCOUNT_TB (ACC_NUM, ACC_PWD, CUS_NO)
VALUES ('425123-01-613451', 1234, 4);
INSERT INTO ACCOUNT_TB (ACC_NUM, ACC_PWD, CUS_NO)
VALUES ('474233-01-424253', 1234, 2);
INSERT INTO ACCOUNT_TB (ACC_NUM, ACC_PWD, CUS_NO)
VALUES ('985622-01-424253', 1234, 3);

--=================================================
----------------- ÷������ ���̺� -------------------
CREATE TABLE ATTACHMENT_TB(
    ATT_NO NUMBER PRIMARY KEY,
    ATT_CHANGENAME VARCHAR2(100),
    ATT_ORIGIN VARCHAR2(100),
    REF_NO NUMBER,
    ATT_CATEGORY NUMBER,
    ATT_FILEPATH VARCHAR2(4000)
);

--=================================================
--------------- ÷������ ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN ATTACHMENT_TB.ATT_NO IS '÷�����Ϲ�ȣ';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_CHANGENAME IS '�������ϸ�';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_ORIGIN IS '�������ϸ�';
COMMENT ON COLUMN ATTACHMENT_TB.REF_NO IS '�Ҽӱ۹�ȣ';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_CATEGORY IS '�����Խù���ȣ';
COMMENT ON COLUMN ATTACHMENT_TB.ATT_FILEPATH IS '���ϰ��';

-- ============================================
-- ATTACHMENT_TB ���� ������
-- ============================================
INSERT INTO ATTACHMENT_TB (ATT_NO, ATT_CHANGENAME, ATT_ORIGIN, REF_NO, ATT_CATEGORY, ATT_FILEPATH)
VALUES (SEQ_ATNO.NEXTVAL, '20250607124422121', 'FLOWER.JPG', 1, 1, 'images/upfile');
INSERT INTO ATTACHMENT_TB (ATT_NO, ATT_CHANGENAME, ATT_ORIGIN, REF_NO, ATT_CATEGORY, ATT_FILEPATH)
VALUES (SEQ_ATNO.NEXTVAL, '20250607124422125', 'FLOWER.JPG', 2, 1, 'images/upfile');
INSERT INTO ATTACHMENT_TB (ATT_NO, ATT_CHANGENAME, ATT_ORIGIN, REF_NO, ATT_CATEGORY, ATT_FILEPATH)
VALUES (SEQ_ATNO.NEXTVAL, '20250607124422641', 'CITY.JPG', 1, 2, 'images/upfile');
INSERT INTO ATTACHMENT_TB (ATT_NO, ATT_CHANGENAME, ATT_ORIGIN, REF_NO, ATT_CATEGORY, ATT_FILEPATH)
VALUES (SEQ_ATNO.NEXTVAL, '20250607124422132', 'CITY.JPG', 2, 2, 'images/upfile');

-- ============================================
-- �μ� ���̺�
-- ============================================
CREATE TABLE DEPARTMENT ( -- �μ� ���̺�
    DEPT_CODE CHAR(2) PRIMARY KEY, -- �μ��ڵ�(D1~D6)
    DEPT_TITLE VARCHAR2(10) NOT NULL -- �μ���(1������ 2�ѹ��� 3�λ�� 4������ 5������ 6������)
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

-- ============================================
-- ���� ���̺�
-- ============================================
CREATE TABLE JOB_TB ( -- ���� ���̺�
    JOB_CODE CHAR(2) PRIMARY KEY, -- �����ڵ�(J1~J4)
    JOB_TITLE VARCHAR2(10) NOT NULL -- ���޸�(1������ 2���� 3���� 4���)
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

-- ============================================
-- ��� ���̺�
-- ============================================
CREATE TABLE EMPLOYEE_TB ( -- ��� ���̺�
    EMP_NO NUMBER PRIMARY KEY, -- �����ȣ
    EMP_NAME VARCHAR2(20) NOT NULL, -- ����̸�
    EMP_RESINUM VARCHAR2(6) NOT NULL UNIQUE, -- ����������
    EMP_ID VARCHAR2(20) NOT NULL UNIQUE, -- ������̵�
    EMP_PWD VARCHAR2(100) NOT NULL, -- ��� ��й�ȣ
    EMP_GENDER CHAR(1) CHECK (EMP_GENDER IN ('M','F')) NOT NULL, -- ����(���ڴ� 'M', ���ڴ� 'F'�� ����)
    DEPT_CODE CHAR(2) REFERENCES DEPARTMENT(DEPT_CODE) NOT NULL, -- �μ��ڵ� (�μ� ���̺� ����)
    JOB_CODE CHAR(2) REFERENCES JOB_TB(JOB_CODE) NOT NULL, -- �����ڵ� (���� ���̺� ����)
    EMP_PHONE VARCHAR2(13) NOT NULL, -- ��ȭ��ȣ
    EMP_EMAIL VARCHAR2(50) NOT NULL, -- �̸���
    EMP_ADDRESS VARCHAR2(4000) NOT NULL, -- �ּ�
    EMP_STATUS CHAR(1) DEFAULT 'Y' NOT NULL, -- ��������(����ϸ� N���� ����)
    EMP_SIGN VARCHAR2(4000) NOT NULL, -- ��� ����
    SALARY NUMBER NOT NULL, -- �޿�
    BONUS NUMBER DEFAULT 0,
    HIRE_DATE DATE DEFAULT SYSDATE, -- �Ի糯¥
    MODIFY_DATE DATE DEFAULT SYSDATE, -- ������¥
    EMP_PICTURE VARCHAR2(4000) NOT NULL, -- �������(���� ��ũ ���ڿ��� ����)
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
COMMENT ON COLUMN EMPLOYEE_TB.EMP_SIGN IS '������μ���';
COMMENT ON COLUMN EMPLOYEE_TB.SALARY IS '�޿�';
COMMENT ON COLUMN EMPLOYEE_TB.BONUS IS '���ʽ�';
COMMENT ON COLUMN EMPLOYEE_TB.HIRE_DATE IS '�Ի���';
COMMENT ON COLUMN EMPLOYEE_TB.MODIFY_DATE IS '������';
COMMENT ON COLUMN EMPLOYEE_TB.EMP_PICTURE IS '�������';
COMMENT ON COLUMN EMPLOYEE_MESSENGER_STATUS IS '�޽������ӻ���';

-- ============================================
-- EMPLOYEE_TB ���� ������
-- ============================================
INSERT INTO EMPLOYEE_TB (EMP_NO, EMP_NAME, EMP_RESINUM, EMP_ID, EMP_PWD, EMP_GENDER,
    DEPT_CODE, JOB_CODE, EMP_PHONE, EMP_EMAIL, EMP_ADDRESS, EMP_SIGN, SALARY, BONUS, EMP_PICTURE)
VALUES (SEQ_ENO.NEXTVAL,'ȫ�浿','900101','hong','pass123','M','D1','J1','010-1234-5678','hong@company.com','����� ������','ȫ�浿����', 3000000, 0.3, '/images/hong.jpg');
INSERT INTO EMPLOYEE_TB (EMP_NO, EMP_NAME, EMP_RESINUM, EMP_ID, EMP_PWD, EMP_GENDER,
    DEPT_CODE, JOB_CODE, EMP_PHONE, EMP_EMAIL, EMP_ADDRESS, EMP_SIGN, SALARY, BONUS, EMP_PICTURE)
VALUES (SEQ_ENO.NEXTVAL,'��ö��','900102','kim','pass123','M','D2','J2','010-1234-4124','kim@company.com','����� ��걸','��ö������', 3000000, 0.3, '/images/kim.jpg');
INSERT INTO EMPLOYEE_TB (EMP_NO, EMP_NAME, EMP_RESINUM, EMP_ID, EMP_PWD, EMP_GENDER,
    DEPT_CODE, JOB_CODE, EMP_PHONE, EMP_EMAIL, EMP_ADDRESS, EMP_SIGN, SALARY, BONUS, EMP_PICTURE)
VALUES (SEQ_ENO.NEXTVAL,'�̿���','900103','lee','pass123','F','D3','J3','010-1234-1535','lee@company.com','����� ���빮��','�̿��񼭸�', 3000000, 0.3, '/images/lee.jpg');
INSERT INTO EMPLOYEE_TB (EMP_NO, EMP_NAME, EMP_RESINUM, EMP_ID, EMP_PWD, EMP_GENDER,
    DEPT_CODE, JOB_CODE, EMP_PHONE, EMP_EMAIL, EMP_ADDRESS, EMP_SIGN, SALARY, BONUS, EMP_PICTURE)
VALUES (SEQ_ENO.NEXTVAL,'�ڹμ�','900104','park','pass123','M','D4','J4','010-1234-1645','park@company.com','����� ���۱�','�ڹμ�����', 3000000, 0.3, '/images/park.jpg');
INSERT INTO EMPLOYEE_TB (EMP_NO, EMP_NAME, EMP_RESINUM, EMP_ID, EMP_PWD, EMP_GENDER,
    DEPT_CODE, JOB_CODE, EMP_PHONE, EMP_EMAIL, EMP_ADDRESS, EMP_SIGN, SALARY, BONUS, EMP_PICTURE)
VALUES (SEQ_ENO.NEXTVAL,'������','900105','choi','pass123','F','D5','J4','010-1234-8264','choi@company.com','����� ��õ��','����������', 3000000, 0.3, '/images/choi.jpg');

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
-- VACATION_TB ���� ������
-- ============================================
INSERT INTO VACATION_TB (VAC_NO, EMP_NO, VAC_SDATE, VAC_EDATE, VAC_STATUS)
VALUES (SEQ_VNO.NEXTVAL, 100, '2025-08-22', '2025-08-25', 'Y');
INSERT INTO VACATION_TB (VAC_NO, EMP_NO, VAC_SDATE, VAC_EDATE, VAC_STATUS)
VALUES (SEQ_VNO.NEXTVAL, 101, '2025-08-23', '2025-08-26', 'Y');
INSERT INTO VACATION_TB (VAC_NO, EMP_NO, VAC_SDATE, VAC_EDATE, VAC_STATUS)
VALUES (SEQ_VNO.NEXTVAL, 102, '2025-08-23', '2025-08-28', 'Y');
INSERT INTO VACATION_TB (VAC_NO, EMP_NO, VAC_SDATE, VAC_EDATE, VAC_STATUS)
VALUES (SEQ_VNO.NEXTVAL, 103, '2025-08-24', '2025-08-27', 'Y');
INSERT INTO VACATION_TB (VAC_NO, EMP_NO, VAC_SDATE, VAC_EDATE, VAC_STATUS)
VALUES (SEQ_VNO.NEXTVAL, 104, '2025-08-24', '2025-08-29', 'Y');

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
    PJT_STATUS CHAR(1) DEFAULT 'p' NOT NULL CHECK (PJT_STATUS IN ('p','c','o','e')), -- ������Ʈ ����(������(p) | ������(c) | �Ϸ�(o) | ����(e))
    PJT_CONTENT VARCHAR2(4000) NOT NULL -- ������Ʈ ����
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
-- PROJECT_TB ���� ������
-- ============================================
INSERT INTO PROJECT_TB (PJT_NO, EMP_NO, PJT_NAME, PJT_STARTDATE, PJT_ENDDATE, PJT_ENROLLDATE, PJT_CONTENT)
VALUES (SEQ_PNO.NEXTVAL, 100, 'ERP ����','2025-08-01', '2025-09-01', '2025-08-01', 'ERP �ý��� ���� ������Ʈ');
INSERT INTO PROJECT_TB (PJT_NO, EMP_NO, PJT_NAME, PJT_STARTDATE, PJT_ENDDATE, PJT_ENROLLDATE, PJT_CONTENT)
VALUES (SEQ_PNO.NEXTVAL, 101, 'CRM ����','2025-08-11', '2025-09-11', '2025-08-02', 'CRM �ý��� ���� ������Ʈ');
INSERT INTO PROJECT_TB (PJT_NO, EMP_NO, PJT_NAME, PJT_STARTDATE, PJT_ENDDATE, PJT_ENROLLDATE, PJT_CONTENT)
VALUES (SEQ_PNO.NEXTVAL, 102, '������Ʈ ����', '2025-08-02', '2025-08-22', '2025-08-03', '��� ������Ʈ ���� ������Ʈ');
INSERT INTO PROJECT_TB (PJT_NO, EMP_NO, PJT_NAME, PJT_STARTDATE, PJT_ENDDATE, PJT_ENROLLDATE, PJT_CONTENT)
VALUES (SEQ_PNO.NEXTVAL, 103, '����� �� ����', '2025-08-03', '2025-11-11','2025-08-04', '����� �� ���� ������Ʈ');
INSERT INTO PROJECT_TB (PJT_NO, EMP_NO, PJT_NAME, PJT_STARTDATE, PJT_ENDDATE, PJT_ENROLLDATE, PJT_CONTENT)
VALUES (SEQ_PNO.NEXTVAL, 104, '������ Ȯ��', '2025-08-15', '2025-09-20', '2025-08-05', '���� �� ��Ʈ��ũ ������ Ȯ�� ������Ʈ');

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
-- PROJECTMEMBER_TB ���� ������
-- ============================================
INSERT INTO PROJECTMEMBER_TB (PJT_NO, EMP_NO) VALUES (1,100);
INSERT INTO PROJECTMEMBER_TB (PJT_NO, EMP_NO) VALUES (1,101);
INSERT INTO PROJECTMEMBER_TB (PJT_NO, EMP_NO) VALUES (2,102);
INSERT INTO PROJECTMEMBER_TB (PJT_NO, EMP_NO) VALUES (3,103);
INSERT INTO PROJECTMEMBER_TB (PJT_NO, EMP_NO) VALUES (3,104);

-- ============================================
-- ���� �Խ��� ���̺�
-- ============================================
CREATE TABLE APP_BOARD ( -- ����Խ��� ���̺�
    APP_NO NUMBER PRIMARY KEY, -- �����ȣ
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO), -- �����ȣ
    APP_TITLE VARCHAR2(4000) NOT NULL, -- ���� ����
    APP_CONTENT VARCHAR2(4000) NOT NULL, -- ���� ����
    CREATE_DATE DATE DEFAULT SYSDATE, -- �����
    APP_STATUS VARCHAR2(20) DEFAULT 'U' CHECK (APP_STATUS IN ('U','A','D')), -- ����(U:���, A:����, D:�ݷ�)
    APP_DATE DATE -- ������
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

-- ============================================
-- APP_BOARD ���� ������
-- ============================================
INSERT INTO APP_BOARD (APP_NO, EMP_NO, APP_TITLE, APP_CONTENT, APP_DATE)
VALUES (SEQ_ANO.NEXTVAL, 100, '���� ����', '���� ���� ���� ����', NULL);
INSERT INTO APP_BOARD (APP_NO, EMP_NO, APP_TITLE, APP_CONTENT, APP_DATE)
VALUES (SEQ_ANO.NEXTVAL, 101, 'ȸ�� �Ȱ�', 'ȸ�� �Ȱ� ����', NULL);
INSERT INTO APP_BOARD (APP_NO, EMP_NO, APP_TITLE, APP_CONTENT, APP_DATE)
VALUES (SEQ_ANO.NEXTVAL, 102, '������Ʈ ����', '������Ʈ ���� ����', NULL);
INSERT INTO APP_BOARD (APP_NO, EMP_NO, APP_TITLE, APP_CONTENT, APP_DATE)
VALUES (SEQ_ANO.NEXTVAL, 103, '�ް� ��û', '�ް� ��û ����', NULL);
INSERT INTO APP_BOARD (APP_NO, EMP_NO, APP_TITLE, APP_CONTENT, APP_DATE)
VALUES (SEQ_ANO.NEXTVAL, 104, '���� ����', '���� ���� ����', NULL);

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
    SCH_SDATE DATE NOT NULL, -- ���� ������
    SCH_EDATE DATE NOT NULL, -- ���� ������
    EMP_NO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL, -- �ۼ��� �����ȣ
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL, -- �����
    MODIFY_DATE DATE DEFAULT SYSDATE NOT NULL, -- ������
    SCH_COUNT NUMBER DEFAULT 0 NOT NULL, -- ��ȸ��
    SCH_STATUS CHAR(30) DEFAULT 'P' NOT NULL CHECK (SCH_STATUS IN ('P','E')) -- ���� ����(P:������, E:����)
);

--=================================================
--------------- ���� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN SCHEDULE.SCH_NO IS '������ȣ';
COMMENT ON COLUMN SCHEDULE.SCH_NAME IS '�����̸�';
COMMENT ON COLUMN SCHEDULE.SCH_CONTENT IS '��������';
COMMENT ON COLUMN SCHEDULE.SCH_SDATE IS '����������';
COMMENT ON COLUMN SCHEDULE.SCH_EDATE IS '����������';
COMMENT ON COLUMN SCHEDULE.EMP_NO IS '�����ȣ';
COMMENT ON COLUMN SCHEDULE.CREATE_DATE IS '�����';
COMMENT ON COLUMN SCHEDULE.MODIFY_DATE IS '������';
COMMENT ON COLUMN SCHEDULE.SCH_COUNT IS '��ȸ��';
COMMENT ON COLUMN SCHEDULE.SCH_STATUS IS '��������';

-- ============================================
-- SCHEDULE ���� ������
-- ============================================
INSERT INTO SCHEDULE (SCH_NO, SCH_NAME, SCH_CONTENT, SCH_SDATE, SCH_EDATE, EMP_NO)
VALUES (SEQ_SNO.NEXTVAL, 'ȸ�� A', '�ְ� ȸ��', '2025-08-01', '2025-08-01',100);
INSERT INTO SCHEDULE (SCH_NO, SCH_NAME, SCH_CONTENT, SCH_SDATE, SCH_EDATE, EMP_NO)
VALUES (SEQ_SNO.NEXTVAL, '���� ����', '���� ���� ����', '2025-08-05', '2025-08-05',101);
INSERT INTO SCHEDULE (SCH_NO, SCH_NAME, SCH_CONTENT, SCH_SDATE, SCH_EDATE, EMP_NO)
VALUES (SEQ_SNO.NEXTVAL, '����', '���� ����', '2025-08-10', '2025-08-12',102);
INSERT INTO SCHEDULE (SCH_NO, SCH_NAME, SCH_CONTENT, SCH_SDATE, SCH_EDATE, EMP_NO)
VALUES (SEQ_SNO.NEXTVAL, '��ũ��', '����ũ ��ȭ', '2025-08-15', '2025-08-16',103);
INSERT INTO SCHEDULE (SCH_NO, SCH_NAME, SCH_CONTENT, SCH_SDATE, SCH_EDATE, EMP_NO)
VALUES (SEQ_SNO.NEXTVAL, 'ȸ�� B', '������Ʈ ȸ��', '2025-08-20', '2025-08-20',104);

-- ============================================
-- �޽��� ���̺�
-- ============================================
CREATE TABLE MESSAGE_TB ( -- �޽��� ���̺�
    MSG_NO NUMBER PRIMARY KEY, -- �޽��� ��ȣ
    EMP_SNO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL, -- �߽Ż����ȣ
    EMP_RNO NUMBER REFERENCES EMPLOYEE_TB(EMP_NO) NOT NULL, -- ���Ż����ȣ
    MSG_CONTENT VARCHAR2(4000) DEFAULT '�������' NOT NULL, -- �޽��� ����
    MSG_DATE DATE DEFAULT SYSDATE NOT NULL -- �ۼ���
);

--=================================================
--------------- �޽��� ���̺� �ڸ�Ʈ ---------------
COMMENT ON COLUMN MESSAGE_TB.MSG_NO IS '�޽�����ȣ';
COMMENT ON COLUMN MESSAGE_TB.EMP_SNO IS '�߽Ż����ȣ';
COMMENT ON COLUMN MESSAGE_TB.EMP_RNO IS '���Ż����ȣ';
COMMENT ON COLUMN MESSAGE_TB.MSG_CONTENT IS '�޽�������';
COMMENT ON COLUMN MESSAGE_TB.MSG_DATE IS '�ۼ���';

-- ============================================
-- 14. MESSAGE_TB ���� ������
-- ============================================
INSERT INTO MESSAGE_TB (MSG_NO, EMP_SNO, EMP_RNO, MSG_CONTENT)
VALUES (SEQ_MNO.NEXTVAL,100,101,'�������� ���� A');

INSERT INTO MESSAGE_TB (MSG_NO, EMP_SNO, EMP_RNO, MSG_CONTENT)
VALUES (SEQ_MNO.NEXTVAL,101,102,'�������� ���� B');

INSERT INTO MESSAGE_TB (MSG_NO, EMP_SNO, EMP_RNO, MSG_CONTENT)
VALUES (SEQ_MNO.NEXTVAL,102,103,'�������� ���� C');

INSERT INTO MESSAGE_TB (MSG_NO, EMP_SNO, EMP_RNO, MSG_CONTENT)
VALUES (SEQ_MNO.NEXTVAL,103,104,'�������� ���� D');

INSERT INTO MESSAGE_TB (MSG_NO, EMP_SNO, EMP_RNO, MSG_CONTENT)
VALUES (SEQ_MNO.NEXTVAL,104,101,'�������� ���� E');

-- ============================================
-- ��û���� ���̺�
-- ============================================
CREATE TABLE REQUIREMENT_TB (
    REQ_NO NUMBER NOT NULL, -- ��û���׹�ȣ
    ATT_NO NUMBER NOT NULL, -- ÷�����Ϲ�ȣ
    EMP_NO NUMBER NOT NULL,  -- �����ȣ
    REQ_STATUS CHAR(1) DEFAULT 'P' NOT NULL, -- ó������(ó����:'P'/����:'A'/�ź�:'D') 
    REQ_TITLE VARCHAR2(1000)  NOT NULL, -- ��û��������
    REQ_CONTENT  VARCHAR2(4000)  NOT NULL,  -- ��û���׳���
    REQ_ACCEPTDATE DATE DEFAULT SYSDATE NOT NULL,  -- ��û���׼�����
    REQ_APPDATE DATE DEFAULT SYSDATE NOT NULL, -- ��û����ó����

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
COMMENT ON COLUMN REQUIREMENT_TB.REQ_ACCEPTDATE IS '��û���׼�����';
COMMENT ON COLUMN REQUIREMENT_TB.REQ_APPDATE IS '��û����ó����';

-- ============================================
-- REQUIREMENT_TB ���� ������
-- ============================================
INSERT INTO REQUIREMENT_TB (REQ_NO, ATT_NO, EMP_NO, REQ_TITLE, REQ_CONTENT)
VALUES (SEQ_RNO.NEXTVAL, 1, 101, '��û����1', '��û����1');
INSERT INTO REQUIREMENT_TB (REQ_NO, ATT_NO, EMP_NO, REQ_TITLE, REQ_CONTENT)
VALUES (SEQ_RNO.NEXTVAL, 2, 102, '��û����2', '��û����2');
INSERT INTO REQUIREMENT_TB (REQ_NO, ATT_NO, EMP_NO, REQ_TITLE, REQ_CONTENT)
VALUES (SEQ_RNO.NEXTVAL, 3, 103, '��û����3', '��û����3');
INSERT INTO REQUIREMENT_TB (REQ_NO, ATT_NO, EMP_NO, REQ_TITLE, REQ_CONTENT)
VALUES (SEQ_RNO.NEXTVAL, 4, 104, '��û����4', '��û����4');

COMMIT;