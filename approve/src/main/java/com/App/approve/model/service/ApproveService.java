package com.App.approve.model.service;

import com.App.approve.model.vo.Approvement;
import com.App.common.model.vo.PageInfo;

import java.util.ArrayList;

public interface ApproveService {


    // 게시판 리스트 페이징
    int selectListCount();
    ArrayList<Approvement> selectList(PageInfo pi);

    // 게시글 상세조회
    Approvement selectAppBoard(int appNo);

}
