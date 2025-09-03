package com.kh.semi.messenger.model.service;

import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.messenger.model.vo.Message;

import java.util.ArrayList;

public interface MessengerService {

    ArrayList<Message> chatroom(Message ms);

    int sendMessage(Message ms);

    ArrayList<Employee> empListMs();

    ArrayList<Message> chatList(Message ms);

    int updateMsOnline(String empId);

    int updateMsOffline(String empId);

    Employee loginEmp(Employee emp);

    int insertEmp(Employee emp);
}
