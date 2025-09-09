package com.kh.semi.employee.model.service;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.employee.model.vo.Employee;

import java.util.ArrayList;

public interface EmployeeService {

    //1. 사원 전체 목록 페이지 페이징 처리
    int selectListCount();
    ArrayList<Employee> selectList(PageInfo pi);
    //2. 사원 추가
    int insertEmployee(Employee emp);

    //3. 사원 정보 상세조회
    Employee selectEmployee(int empNo);

    //4. 사원 정보 수정
    int updateEmployee(Employee emp);

    //5. 조직도

    //6. 검색바
    ArrayList<Employee> searchEmployee(String keyword, PageInfo pi);

    //7. 검색 결과
    int selectSearchCount(String keyword);


}
