package com.App.approve.model.vo;

import java.sql.Date;

public class Approvement {
    private int appNo;
    private int empNo;
    private String appTitle;
    private String appContent;
    private Date createDate;
    private String appStatus;
    private Date appDate;

    public Approvement (){}

    public Approvement(int appNo, int empNo, String appTitle, String appContent, Date createDate, String appStatus, Date appDate) {
        this.appNo = appNo;
        this.empNo = empNo;
        this.appTitle = appTitle;
        this.appContent = appContent;
        this.createDate = createDate;
        this.appStatus = appStatus;
        this.appDate = appDate;
    }

    public int getAppNo() {
        return appNo;
    }

    public void setAppNo(int appNo) {
        this.appNo = appNo;
    }

    public int getEmpNo() {
        return empNo;
    }

    public void setEmpNo(int empNo) {
        this.empNo = empNo;
    }

    public String getAppTitle() {
        return appTitle;
    }

    public void setAppTitle(String appTitle) {
        this.appTitle = appTitle;
    }

    public String getAppContent() {
        return appContent;
    }

    public void setAppContent(String appContent) {
        this.appContent = appContent;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getAppStatus() {
        return appStatus;
    }

    public void setAppStatus(String appStatus) {
        this.appStatus = appStatus;
    }

    public Date getAppDate() {
        return appDate;
    }

    public void setAppDate(Date appDate) {
        this.appDate = appDate;
    }

    @Override
    public String toString() {
        return "Approvement{" +
                "appNo=" + appNo +
                ", empNo=" + empNo +
                ", appTitle='" + appTitle + '\'' +
                ", appContent='" + appContent + '\'' +
                ", createDate=" + createDate +
                ", appStatus='" + appStatus + '\'' +
                ", appDate=" + appDate +
                '}';
    }
}
