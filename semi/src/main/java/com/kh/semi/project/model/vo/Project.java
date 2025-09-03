package com.kh.semi.project.model.vo;

import lombok.*;

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
    private Date pjtEnrollDate;
    private int count;
    private String pjtStatus;
    private String pjtContent;

}
