package com.kh.semi.approve.model.service;

import com.kh.semi.approve.model.vo.Approvement;
import com.kh.semi.common.model.vo.PageInfo;

import java.util.ArrayList;

public interface ApproveService {


    // 게시판 리스트 페이징
    int selectListCount();
    ArrayList<Approvement> selectList(PageInfo pi);

    // 게시글 상세조회
    Approvement selectAppBoard(int appNo);


    int updateAppBoard(Approvement a);

    int insertAppBoard(Approvement a);

    int updateAppStatus(int ano, String appStatus);

    int updateManagerStatus(int ano, String status);

    int updateFinalStatus(int ano, String status);
}
