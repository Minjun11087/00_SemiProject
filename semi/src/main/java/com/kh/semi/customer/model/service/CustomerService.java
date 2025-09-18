package com.kh.semi.customer.model.service;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.customer.model.vo.Customer;

import java.util.ArrayList;

public interface CustomerService {

    // 고객 리스트, 페이징
    int selectCusListCount();
    ArrayList<Customer> selectCusList(PageInfo pi);

    //고객 정보 상세
    Customer selectCustomer();

    //고객 추가
    int insertCustomer();

    //검색바, 페이징
    int selectSearchCusCount(String keyword);
    ArrayList<Customer> searchCustomer(String keyword, PageInfo pi);



}
