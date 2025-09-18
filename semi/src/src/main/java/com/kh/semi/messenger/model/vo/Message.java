package com.kh.semi.messenger.model.vo;

import lombok.*;

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
    private String receiveEmpName;
    private String chatPartnerName;
    private int chatPartnerNo;
    private String messageType;

}
