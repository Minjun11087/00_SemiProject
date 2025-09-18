package com.kh.semi.approve.model.service;

import com.kh.semi.approve.model.dao.ApproveDao;
import com.kh.semi.approve.model.vo.Approvement;
import com.kh.semi.common.model.vo.PageInfo;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
@Service
@Transactional
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

    @Override
    public int updateAppBoard(Approvement a) {
        return aDao.updateAppBoard(sqlSession, a);
    }

    @Override
    public int insertAppBoard(Approvement a) {
        return aDao.insertAppBoard(sqlSession, a);
    }

    @Override
    public int updateAppStatus(int ano, String status) {
        return aDao.updateAppStatus(sqlSession, ano, status);
    }

    @Override
    public int updateManagerStatus(int ano, String status) {
        return aDao.updateManagerStatus(sqlSession, ano, status);
    }

    @Override
    public int updateFinalStatus(int ano, String status) {
        return aDao.updateFinalStatus(sqlSession, ano, status);
    }

}
