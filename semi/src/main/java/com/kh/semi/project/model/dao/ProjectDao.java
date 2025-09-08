package com.kh.semi.project.model.dao;

import com.kh.semi.project.model.vo.Project;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;


@Repository
public class ProjectDao {

    public ArrayList<Project> selectProjectList(SqlSessionTemplate sqlSession) {
        return (ArrayList)sqlSession.selectList("projectMapper.selectProjectList");
    }


    public int insertProject(Project p, SqlSessionTemplate sqlSession) {
        return sqlSession.insert("projectMapper.insertProject", p);
    }

    public Project selectProject(int pno, SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("projectMapper.selectProject", pno);
    }
}
