package com.kh.semi.customer.model.dao;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.customer.model.vo.Customer;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class CustomerDao {

    public int selectCusListCount(SqlSessionTemplate sqlSession) {

        return sqlSession.selectOne("customerMapper.selectCusListCount");

    }

    public ArrayList<Customer> selectCusList(SqlSessionTemplate sqlSession, PageInfo pi) {

        int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);

        return (ArrayList) sqlSession.selectList("customerMapper.selectCusList", null, rowBounds);

    }
}
