package com.kh.semi.messenger.model.vo;

import lombok.*;

import java.sql.Date;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Message {

    private int msgNo;
    private int empSno;
    private int empRno;
    private String msgContent;
    private String msgDate;
    private String sendEmpName;

}
