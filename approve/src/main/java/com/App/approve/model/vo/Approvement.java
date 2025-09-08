package com.App.approve.model.vo;

import lombok.*;

import java.sql.Date;
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Approvement {
    private int appNo;
    private int empNo;
    private String appTitle;
    private String appContent;
    private Date createDate;
    private String appStatus;
    private Date appDate;
    private String appShowStatus;
    private String empName;
    private String deptTitle;
    private String jobTitle;
    private String appEmpStatus;
    private String appFF;


}
