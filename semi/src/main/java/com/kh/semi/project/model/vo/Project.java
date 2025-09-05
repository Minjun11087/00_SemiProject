package com.kh.semi.project.model.vo;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Project {

    private int pjtNo;
    private int empNo;
    private String pjtName;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date pjtStartDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date pjtEndDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    private Date pjtEnrollDate;
    private int pjtCount;
    private String pjtStatus;
    private String pjtContent;
    private String empName;
}
