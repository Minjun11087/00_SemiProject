package com.kh.semi.messenger.model.service;

import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.messenger.model.dao.MessengerDao;
import com.kh.semi.messenger.model.vo.Message;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class MessengerServiceImpl implements MessengerService{

    @Autowired
    private MessengerDao msDao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public ArrayList<Message> chatroom(Message ms) {
        return msDao.selectChatRoom(sqlSession, ms);
    }

    @Override
    public int sendMessage(Message ms) {
        return msDao.sendMessage(sqlSession, ms);
    }

    @Override
    public ArrayList<Employee> empListMs() {
        return msDao.empListMs(sqlSession);
    }

    @Override
    public ArrayList<Message> chatList(Message ms) {
        return msDao.selectChatList(sqlSession, ms);
    }

    @Override
    public int updateMsOffline(String empId) {
        return msDao.updateMsOffline(sqlSession, empId);
    }

    @Override
    public Employee loginEmp(Employee emp) {
        return msDao.loginEmp(sqlSession, emp);
    }

    @Override
    public int insertEmp(Employee emp) {
        return msDao.insertEmp(sqlSession, emp);
    }

    @Override
    public ArrayList<Message> selectMessage(int empNo) {
        return msDao.selectMessage(sqlSession, empNo);
    }

    @Override
    public ArrayList<Message> getLatestMessagesForUser(int myNo) {
        return msDao.getLatestMessagesForUser(sqlSession, myNo);
    }

    @Override
    public int chatExit(int exitEmpRno, int exitEmpSno) {
        return msDao.chatExit(sqlSession, exitEmpRno, exitEmpSno);
    }

    @Override
    public int updateMsOnline(String empId){
        return msDao.updateMsOnline(sqlSession, empId);
    }

}
