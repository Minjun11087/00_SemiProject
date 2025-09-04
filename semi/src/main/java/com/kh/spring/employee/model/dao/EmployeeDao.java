package com.kh.spring.employee.model.dao;

import com.kh.spring.employee.model.vo.Employee;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class EmployeeDao {

    public Employee loginMember(SqlSessionTemplate sqlSession, Employee e) {
        return sqlSession.selectOne("memberMapper.loginMember", e);
    }
}
