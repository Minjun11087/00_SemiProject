package com.kh.spring.employee.model.service;

import com.kh.spring.employee.model.vo.Employee;

public interface EmployeeService {

    Employee loginMember(Employee e);

    //회원가입(insert)
    int insertMember(Employee e);

    //정보수정(update)
    int updateMember(Employee e);

    //회원탈퇴(update)
    int deleteMember(String userId);

    //아이디 중복확인(select)
    int idCheck(String checkId);

}
