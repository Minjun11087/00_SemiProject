package com.kh.semi.customer.model.vo;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Customer {

    private int cusNo;
    private String cusName;
    private String cusGender;
    private int cusAge;
    private String cusResinum;
    private String cusAddress;
    private String cusPhone;
    private String cusEmail;
    private String cusJob;
    private String loan; // 대출 현황
    private int amount; // 대출 금액
    private double interest; // 이자율
    private int rating; // 신용등급

}
