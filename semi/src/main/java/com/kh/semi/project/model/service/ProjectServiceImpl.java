package com.kh.semi.project.model.service;

import com.kh.semi.project.model.dao.ProjectDao;
import com.kh.semi.project.model.vo.Project;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
@Service
public class ProjectServiceImpl implements ProjectService{
    @Autowired
    private ProjectDao pDao;
    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public ArrayList<Project> selectProjectList() {
        return pDao.selectProjectList(sqlSession);
    }

    @Override
    public int insertProject(Project p) {
        return pDao.insertProject(p, sqlSession);
    }

    @Override
    public Project selectProject(int pno) {
        return pDao.selectProject(pno, sqlSession);
    }
}
