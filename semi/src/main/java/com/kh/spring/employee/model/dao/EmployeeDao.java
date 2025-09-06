package com.kh.spring.employee.model.dao;

import com.kh.spring.employee.model.vo.Employee;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class EmployeeDao {

    public Employee loginMember(SqlSessionTemplate sqlSession, Employee e) {
        return sqlSession.selectOne("memberMapper.loginMember", e);
    }

    public int insertMember(SqlSessionTemplate sqlSession, Employee e) {
        return sqlSession.insert("memberMapper.insertMember", e);
    }

    public int updateMember(SqlSessionTemplate sqlSession, Employee e) {
        return sqlSession.update("memberMapper.updateMember", e);
    }

    public int deleteMember(SqlSessionTemplate sqlSession, String empId) {
        return sqlSession.update("memberMapper.deleteMember", empId);
    }

    public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
        return sqlSession.selectOne("memberMapper.idCheck", checkId);
    }
}
