package com.kh.semi.project.controller;

import com.kh.semi.project.model.service.ProjectServiceImpl;
import com.kh.semi.project.model.vo.Project;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;

@Controller
public class ProjectController {
    @Autowired
    private ProjectServiceImpl pService;

    @GetMapping("")
    public ModelAndView selectProjectList(ModelAndView mv){
        ArrayList<Project> list = pService.selectProjectList();
        mv.addObject("list", list).setViewName("project/projectList");
        return mv;
    }

}
