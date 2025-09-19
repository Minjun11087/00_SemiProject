package com.kh.semi.approve.model.vo;

import com.kh.semi.attachment.model.vo.Attachment;
import lombok.*;

import java.sql.Date;
import java.util.List;

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
    private int managerNo;
    private String managerName;
    private String managerDept;
    private String managerJob;
    private int finalNo;
    private String finalName;
    private String finalDept;
    private String finalJob;
    private String managerStatus;
    private String finalStatus;
    private List<Attachment> attachments;


}
