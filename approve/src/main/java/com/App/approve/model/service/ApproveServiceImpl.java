package com.App.approve.model.service;

import com.App.approve.model.dao.ApproveDao;
import com.App.approve.model.vo.Approvement;
import com.App.common.model.vo.PageInfo;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
@Service
public class ApproveServiceImpl implements ApproveService{

    @Autowired
    private ApproveDao aDao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int selectListCount() {
        return aDao.selectListCount(sqlSession);
    }

    @Override
    public ArrayList<Approvement> selectList(PageInfo pi) {
        return aDao.selectList(sqlSession, pi);
    }

    @Override
    public Approvement selectAppBoard(int appNo) {
        return aDao.selectAppBoard(sqlSession, appNo);
    }
}
