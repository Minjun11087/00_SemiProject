package com.kh.semi.employee.model.vo;

import lombok.*;

import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Employee {

    private int empNo;
    private String empName;
    private String empResinum;
    private String empId;
    private String empPwd;
    private String empGender;
    private String deptCode;
    private String jobCode;
    private String empPhone;
    private String empEmail;
    private String empAddress;
    private String empStatus;
    private String empSign;
    private int salary;
    private int bonus;
    private String hireDate;
    private Date modifyDate;
    private String empPicture;
    private String messengerStatus;
    private String deptTitle;
    private String jobTitle;

}
