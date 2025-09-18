package com.kh.semi.employee.model.dao;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.employee.model.vo.Employee;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class EmployeeDao {

    public Employee loginMember(SqlSessionTemplate sqlSession, Employee e) {
        return sqlSession.selectOne("employeeMapper.loginMember", e);
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

    public int selectListCount(SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("employeeMapper.selectListCount");
    }


    public ArrayList<Employee> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {

        int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);

        return (ArrayList)sqlSession.selectList("employeeMapper.selectList",null, rowBounds);

    }


    public Employee selectEmployee(SqlSessionTemplate sqlSession, int empNo) {
        return sqlSession.selectOne("employeeMapper.selectEmployee", empNo);
    }


    public ArrayList<Employee> searchEmployee(SqlSessionTemplate sqlSession, String keyword, PageInfo pi) {

        int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);

        return (ArrayList)sqlSession.selectList("employeeMapper.searchEmployee", keyword, rowBounds);
    }


    public int selectSearchCount(SqlSessionTemplate sqlSession, String keyword) {

        return sqlSession.selectOne("employeeMapper.selectSearchCount", keyword);
    }





}
