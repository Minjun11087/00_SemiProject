package com.kh.semi.project.model.service;

import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.project.model.vo.Project;
import com.kh.semi.project.model.vo.ProjectMember;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface ProjectService {
    ArrayList<Project> selectProjectList();

    int insertProject(Project p);

    Project selectProject(int pno);

    ArrayList<Employee> listProjectMember(String myId);

    int insertProjectMember(Project p,  List<Map<String, String>> memberList);


    ArrayList<ProjectMember> selectProjectMember(int pno);

    ArrayList<Project> myProjectList(int myEmpNo);
}
