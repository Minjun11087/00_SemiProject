package com.kh.semi.schedule.model.vo;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Schedule {

    private int schNo;
    private String schName;
    private String schContent;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date schStartDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date schEndDate;
    private int empNo;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date schEnrollDate;
    private int schCount;
    private String schStatus; // 일정 상태(진행중(p) | 검토중(c) | 만료(e)) 디폴트값으로는  검토중(c)
    private String empName;
}
