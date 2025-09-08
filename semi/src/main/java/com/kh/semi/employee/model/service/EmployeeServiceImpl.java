package com.kh.semi.employee.model.service;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.employee.model.dao.EmployeeDao;
import com.kh.semi.employee.model.vo.Employee;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeDao empDao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int selectListCount() {

        return empDao.selectListCount(sqlSession);
    }

    @Override
    public ArrayList<Employee> selectList(PageInfo pi) {
        return empDao.selectList(sqlSession, pi);
    }

    @Override
    public int insertEmployee(Employee emp) {
        return 0;
    }

    @Override
    public Employee selectEmployee(int empNo) {
        return empDao.selectEmployee(sqlSession, empNo);
    }

    @Override
    public int updateEmployee(Employee emp) {
        return 0;
    }







}