package com.kh.semi.project.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.project.model.service.ProjectServiceImpl;
import com.kh.semi.project.model.vo.Project;
import com.kh.semi.project.model.vo.ProjectMember;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class ProjectController {
    @Autowired
    private ProjectServiceImpl pService;

    @GetMapping("list.pj")
    public ModelAndView selectProjectList(ModelAndView mv){

        ArrayList<Project> list = pService.selectProjectList();

        mv.addObject("list", list).setViewName("project/projectList");
        return mv;
    }

    @GetMapping("enrollForm.pj")
    public ModelAndView enrollForm(ModelAndView mv, HttpSession session) {
        String myId = (( Employee)session.getAttribute("loginUser")).getEmpId();

        ArrayList<Employee> mlist = pService.listProjectMember(myId);

        mv.addObject("mlist", mlist).setViewName("project/ProjectEnrollForm");
        return mv;
    }

    @PostMapping("insert.pj")
    public String insertProject(Project p, Model model, RedirectAttributes redirectAttributes, @RequestParam String members, @RequestParam List<MultipartFile> upfiles, @RequestParam int attCategory) {
        System.out.println("=== 파일 업로드 디버깅 ===");
        System.out.println("파일 개수: " + upfiles.size());
        for (int i = 0; i < upfiles.size(); i++) {
            MultipartFile file = upfiles.get(i);
            System.out.println("파일 " + (i+1) + ": " + file.getOriginalFilename() + " (크기: " + file.getSize() + " bytes)");
        }
        System.out.println("attCategory: " + attCategory);
        System.out.println("=======================");


        ObjectMapper objectMapper = new ObjectMapper();
        try {
            List<Map<String, String>> memberList = objectMapper.readValue(members, new TypeReference<List<Map<String, String>>>() {
            });
            for(Map<String, String> a : memberList){
                System.out.println(a);
            }
            int result = pService.insertProjectMember(p, memberList);

            if(result>=0) {//성공
                redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 게시글 등록");
                return "redirect:/list.pj";
            }else {//실패
                model.addAttribute("errorMsg", "게시글 등록 실패 ");
                return "common/errorPage";
            }

        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

    }

    @GetMapping("detail.pj")
    public ModelAndView selectProject(int pno, ModelAndView mv) {

        Project p = pService.selectProject(pno);
        System.out.println(p);
        ArrayList<ProjectMember> pm=  pService.selectProjectMember(pno);

        if(pm != null){ mv.addObject("pm", pm);        }
        if(p !=null) {
            mv.addObject("p", p).setViewName("project/projectDetailView");
        } else {
            mv.addObject("errorMsg", "게시글 조회 실패").setViewName("common/errorPage");
        }
        return mv;
    }

    @GetMapping("myProject.pj")
    public ModelAndView myProjectList(ModelAndView mv, HttpSession session){
        int myEmpNo = (( Employee)session.getAttribute("loginUser")).getEmpNo();

        ArrayList<Project> list = pService.myProjectList(myEmpNo);

        mv.addObject("list", list).setViewName("project/myProject");
        return mv;
    }



}
