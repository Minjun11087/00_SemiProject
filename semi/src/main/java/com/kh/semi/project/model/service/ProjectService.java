package com.kh.semi.project.model.service;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.project.model.vo.Project;
import com.kh.semi.project.model.vo.ProjectMember;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface ProjectService {
    ArrayList<Project> selectProjectList(PageInfo pi);

    int selectListCount();

    List<Project> selectAllProjects();

    int insertProject(Project p);

    Project selectProject(int pno);

    ArrayList<Employee> listProjectMember(String myId);

    int insertProjectMember(Project p,  List<Map<String, String>> memberList, List<MultipartFile> upfiles, int attCategory);


    ArrayList<ProjectMember> selectProjectMember(int pno);

    ArrayList<Project> myProjectList(int myEmpNo, PageInfo pi);

    int mySelectListCount(int myEmpNo);

    List<Project> mySelectAllProjects(int myEmpNo);
}
