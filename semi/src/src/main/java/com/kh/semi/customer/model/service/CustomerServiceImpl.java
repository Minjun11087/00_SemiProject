package com.kh.semi.customer.model.service;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.customer.model.dao.CustomerDao;
import com.kh.semi.customer.model.vo.Customer;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao cusDao;
    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int selectCusListCount() {
        return cusDao.selectCusListCount(sqlSession);
    }

    @Override
    public ArrayList<Customer> selectCusList(PageInfo pi) {
        return cusDao.selectCusList(sqlSession, pi);
    }

    @Override
    public Customer selectCustomer() {
        return null;
    }

    @Override
    public int insertCustomer() {
        return 0;
    }

    @Override
    public int selectSearchCusCount(String keyword) {
        return 0;
    }

    @Override
    public ArrayList<Customer> searchCustomer(String keyword, PageInfo pi) {
        return null;
    }
}
