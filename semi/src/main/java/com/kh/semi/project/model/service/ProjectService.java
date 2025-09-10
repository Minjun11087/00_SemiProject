package com.kh.semi.project.model.service;

import com.kh.semi.project.model.vo.Project;

import java.util.ArrayList;

public interface ProjectService {
    ArrayList<Project> selectProjectList();

    int insertProject(Project p);

    Project selectProject(int pno);
}
