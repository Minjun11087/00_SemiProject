package com.kh.semi.employee.model.service;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.employee.model.dao.EmployeeDao;
import com.kh.semi.employee.model.vo.Employee;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

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

    @Override
    public int selectListCount() {

        return eDao.selectListCount(sqlSession);
    }

    @Override
    public ArrayList<Employee> selectList(PageInfo pi) {
        return eDao.selectList(sqlSession, pi);
    }

    @Override
    public int insertEmployee(Employee emp) {
        return 0;
    }

    @Override
    public Employee selectEmployee(int empNo) {
        return eDao.selectEmployee(sqlSession, empNo);
    }

    @Override
    public int updateEmployee(Employee emp) {
        return 0;
    }

    @Override
    public ArrayList<Employee> searchEmployee(String keyword, PageInfo pi) {
        return eDao.searchEmployee(sqlSession, keyword, pi);
    }

    @Override
    public int selectSearchCount(String keyword) {
        return eDao.selectSearchCount(sqlSession, keyword);
    }



}
