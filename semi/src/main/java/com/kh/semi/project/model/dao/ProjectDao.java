package com.kh.semi.project.model.dao;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.project.model.vo.Project;
import com.kh.semi.project.model.vo.ProjectMember;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Repository
public class ProjectDao {

    public ArrayList<Project> selectProjectList(SqlSessionTemplate sqlSession, PageInfo pi) {
        int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);

        return (ArrayList)sqlSession.selectList("projectMapper.selectProjectList", null, rowBounds);
    }

    public int selectListCount(SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("projectMapper.selectListCount");
    }

    public List<Project> selectAllProjects(SqlSessionTemplate sqlSession) {
        return (ArrayList)sqlSession.selectList("projectMapper.selectProjectList");
    }

    public int insertProject(Project p, SqlSessionTemplate sqlSession) {
        sqlSession.insert("projectMapper.insertProject", p);
        return p.getPjtNo();
    }

    public Project selectProject(int pno, SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("projectMapper.selectProject", pno);
    }

    public ArrayList<Employee> listProjectMember(SqlSessionTemplate sqlSession, String myId) {
        return  (ArrayList)sqlSession.selectList("employeeMapper.listProjectMember", myId);
    }

    public Integer selectEmpNoByName(SqlSessionTemplate sqlSession, String empName) {
        return sqlSession.selectOne("projectMapper.selectEmpNoByName", empName);
    }

    public int insertProjectMember(SqlSessionTemplate sqlSession, Map<String, Object> params) {
        return sqlSession.insert("projectMapper.insertProjectMember", params);
    }


    public ArrayList<ProjectMember> selectProjectMember(SqlSessionTemplate sqlSession, int pno) {
        return (ArrayList)sqlSession.selectList("projectMapper.selectProjectMember", pno);
    }



    public ArrayList<Project> myProjectList(SqlSessionTemplate sqlSession, int myEmpNo,  PageInfo pi) {
        int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);
        return (ArrayList)sqlSession.selectList("projectMapper.myProjectList", myEmpNo, rowBounds);
    }

    public int mySelectListCount(SqlSessionTemplate sqlSession, int myEmpNo) {
        return sqlSession.selectOne("projectMapper.mySelectListCount", myEmpNo);
    }

    public List<Project> mySelectAllProjects(SqlSessionTemplate sqlSession, int myEmpNo) {
        return (ArrayList)sqlSession.selectList("projectMapper.myProjectList", myEmpNo);
    }

    public int updateProject(Project p, SqlSessionTemplate sqlSession) {
        return sqlSession.update("projectMapper.updateProject", p);
    }

    public int deleteProject(SqlSessionTemplate sqlSession, Integer pno) {
        return sqlSession.update("projectMapper.deleteProject", pno);
    }
}
