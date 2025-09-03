package com.kh.semi.project.model.dao;

import com.kh.semi.project.model.vo.Project;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProjectDao {

    @Autowired
    private SqlSessionTemplate sqlSession; // 필드 주입

    public List<Project> selectProjectList() {
        return sqlSession.selectList("projectMapper.selectProjectList");
    }
}
