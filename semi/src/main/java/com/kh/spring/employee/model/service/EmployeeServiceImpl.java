package com.kh.spring.employee.model.service;

import com.kh.spring.employee.model.dao.EmployeeDao;
import com.kh.spring.employee.model.vo.Employee;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeServiceImpl implements EmployeeService{

    @Autowired
    private EmployeeDao eDao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public Employee loginMember(Employee e) {

        return eDao.loginMember(sqlSession, e);
    }

    @Override
    public int insertMember(Employee e) {

        return eDao.insertMember(sqlSession, e);
    }

    @Override
    public int updateMember(Employee e) {

        return eDao.updateMember(sqlSession, e);
    }

    @Override
    public int deleteMember(String empId) {

        return eDao.deleteMember(sqlSession, empId);
    }

    @Override
    public int idCheck(String checkId) {

        return eDao.idCheck(sqlSession, checkId);
    }
}
