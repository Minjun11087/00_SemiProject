package com.kh.semi.approve.model.dao;

import com.kh.semi.approve.model.vo.Approvement;
import com.kh.semi.common.model.vo.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
        return sqlSession.selectOne("approveMapper.selectAppBoard", appNo);
    }


    public int insertAppBoard(SqlSessionTemplate sqlSession, Approvement a) {
        return sqlSession.insert("approveMapper.insertAppBoard", a);
    }

    public int updateAppBoard(SqlSessionTemplate sqlSession, Approvement a) {
        return sqlSession.update("approveMapper.updateAppBoard", a);
    }

    public int updateAppStatus(SqlSessionTemplate sqlSession, int ano, String status) {
        Map<String, Object> param = new HashMap<>();
        param.put("ano", ano);
        param.put("status", status);

        return sqlSession.update("approveMapper.updateAppStatus", param);
    }

    public int updateManagerStatus(SqlSessionTemplate sqlSession, int ano, String status) {
        Map<String, Object> param = new HashMap<>();
        param.put("ano", ano);
        param.put("status", status);
        return sqlSession.update("approveMapper.updateManagerStatus", param);
    }

    public int updateFinalStatus(SqlSessionTemplate sqlSession, int ano, String status) {
        Map<String, Object> param = new HashMap<>();
        param.put("ano", ano);
        param.put("status", status);
        return sqlSession.update("approveMapper.updateFinalStatus", param);
    }
}
