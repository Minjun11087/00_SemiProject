package com.kh.semi.messenger.model.dao;

import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.messenger.model.vo.Message;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Repository
public class MessengerDao {
    public int updateMsOnline(SqlSessionTemplate sqlSession, String empId) {
        return sqlSession.update("messengerMapper.updateMsOnline", empId);
    }

    public int updateMsOffline(SqlSessionTemplate sqlSession, String empId) {
        return sqlSession.update("messengerMapper.updateMsOffline", empId);
    }

    public ArrayList<Employee> empListMs(SqlSessionTemplate sqlSession) {
        return (ArrayList)sqlSession.selectList("employeeMapper.selectEmpListMs");
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

    public Employee loginEmp(SqlSessionTemplate sqlSession, Employee emp) {
        return sqlSession.selectOne("employeeMapper.loginEmp", emp);
    }

    public int insertEmp(SqlSessionTemplate sqlSession, Employee emp) {
        return sqlSession.insert("employeeMapper.insertEmp", emp);
    }

    public ArrayList<Message> selectMessage(SqlSessionTemplate sqlSession, int empNo) {
        return (ArrayList)sqlSession.selectList("messengerMapper.selectMessage", empNo);
    }

    public ArrayList<Message> getLatestMessagesForUser(SqlSessionTemplate sqlSession, int myNo) {
        return (ArrayList)sqlSession.selectList("messengerMapper.getLatestMessagesForUser", myNo);
    }

    public int chatExit(SqlSessionTemplate sqlSession, int exitEmpRno, int exitEmpSno) {
        Map<String, Object> params = new HashMap<>();
        params.put("exitEmpRno", exitEmpRno);
        params.put("exitEmpSno", exitEmpSno);

        return sqlSession.delete("chatExit", params);
    }
}
