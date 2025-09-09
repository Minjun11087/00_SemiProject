package com.kh.semi.customer.controller;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class CustomerController {
    private int cusNo;
    private String cusName;
    private String cusGender;
    private int cusAge;
    private int cusResinum;
    private String cusAddress;
    private int cusPhone;
    private String cusEmail;
    private String cusJob;
    private String loan; // 대출 현황
    private int amount; // 대출 금액
    private double interest; // 이자율
    private int rating; // 신용등급

}
