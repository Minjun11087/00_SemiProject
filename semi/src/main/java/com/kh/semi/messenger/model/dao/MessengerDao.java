package com.kh.semi.messenger.model.dao;

import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.messenger.model.vo.Message;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class MessengerDao {
    public int updateMsOnline(SqlSessionTemplate sqlSession, String empId) {
        return sqlSession.update("messengerMapper.updateMsOnline");
    }

    public int updateMsOffline(SqlSessionTemplate sqlSession, String empId) {
        return sqlSession.update("messengerMapper.updateMsOffline");
    }

    public ArrayList<Employee> empListMs(SqlSessionTemplate sqlSession) {
        return (ArrayList)sqlSession.selectList("messengerMapper.selectEmpListMs");
    }

    public int sendMessage(SqlSessionTemplate sqlSession, Message ms) {
        return sqlSession.insert("messengerMapper.sendMessage", ms);
    }

    public ArrayList<Message> selectChatList(SqlSessionTemplate sqlSession, Message ms) {
        return (ArrayList)sqlSession.selectList("messengerMapper.selectChatList", ms);
    }

    public ArrayList<Message> selectChatRoom(SqlSessionTemplate sqlSession, Message ms) {
        return (ArrayList)sqlSession.selectList("messengerMapper.selectChatRoom", ms);
    }
}
