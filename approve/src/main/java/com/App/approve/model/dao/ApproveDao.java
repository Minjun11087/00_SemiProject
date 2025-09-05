package com.App.approve.model.dao;

import com.App.approve.model.vo.Approvement;
import com.App.common.model.vo.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class ApproveDao {
    public int selectListCount(SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("approveMapper.selectListCount");
    }

    public ArrayList selectList(SqlSessionTemplate sqlSession, PageInfo pi) {

        int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);
        return (ArrayList)sqlSession.selectList("approveMapper.selectList", null, rowBounds);
    }

    public Approvement selectAppBoard(SqlSessionTemplate sqlSession, int appNo) {
        return sqlSession.selectOne("approveMember.selectAppBoard");
    }
}
