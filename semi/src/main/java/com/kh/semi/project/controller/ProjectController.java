package com.kh.semi.project.controller;


import com.kh.semi.approve.model.vo.Approvement;
import com.kh.semi.attachment.model.service.AttachmentServiceImpl;
import com.kh.semi.attachment.model.vo.Attachment;
import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.common.template.FilePath;
import com.kh.semi.common.template.MyFileRenamePolicy;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.semi.common.template.Pagination;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class ProjectController {
    @Autowired
    private ProjectServiceImpl pService;

    @Autowired
    private AttachmentServiceImpl attService;

    @GetMapping("list.pj")
    public ModelAndView selectProjectList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage, ModelAndView mv){

        int listCount = pService.selectListCount();
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 9);

        ArrayList<Project> list = pService.selectProjectList(pi);
        List<Project> allProjectList = pService.selectAllProjects();

        mv.addObject("allProjectList", allProjectList);
        mv.addObject("pi", pi).addObject("list", list).setViewName("project/projectList");
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
        for (MultipartFile file : upfiles) {
            System.out.println(file.getOriginalFilename());

        }
        System.out.println(p);
        System.out.println("-------------------------");



        ObjectMapper objectMapper = new ObjectMapper();
        try {
            List<Map<String, String>> memberList = objectMapper.readValue(members, new TypeReference<List<Map<String, String>>>() {
            });
            for(Map<String, String> a : memberList){
                System.out.println(a);
            }
            int result = pService.insertProjectMember(p, memberList, upfiles, attCategory);

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
        int attCategory=0;

        Project p = pService.selectProject(pno);
        System.out.println(p);
        ArrayList<ProjectMember> pm=  pService.selectProjectMember(pno);

        if(pm != null){ mv.addObject("pm", pm);        }
        if(p !=null) {
            mv.addObject("p", p).setViewName("project/projectDetailView");
        } else {
            mv.addObject("errorMsg", "게시글 조회 실패").setViewName("common/errorPage");
        }

        List<Attachment> attachments = attService.selectAttachments(pno, attCategory); // DAO/Service에 구현 필요
        mv.addObject("attachments", attachments).setViewName("project/projectDetailView");

        return mv;
    }

    @GetMapping("myProject.pj")
    public ModelAndView myProjectList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage, ModelAndView mv, HttpSession session){

        int myEmpNo = (( Employee)session.getAttribute("loginUser")).getEmpNo();
        System.out.println(myEmpNo);
        int listCount = pService.mySelectListCount(myEmpNo);

        System.out.println(listCount);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 9);

        ArrayList<Project> list = pService.myProjectList(myEmpNo, pi);
        List<Project> allProjectList = pService.mySelectAllProjects(myEmpNo);

        mv.addObject("allProjectList", allProjectList);
        mv.addObject("pi", pi).addObject("list", list).setViewName("project/myProject");
        return mv;
    }


    @GetMapping("/project/getAllProjects")
    @ResponseBody
    public List<Project> getAllProjects() {
        return pService.selectAllProjects(); // 페이징 없이 전체 목록 조회
    }

    @GetMapping("/project/getMyAllProjects")
    @ResponseBody
    public List<Project> getAllProjects(HttpSession session) {
        int myEmpNo = (( Employee)session.getAttribute("loginUser")).getEmpNo();
        return pService.mySelectAllProjects(myEmpNo);// 페이징 없이 전체 목록 조회
    }

    @GetMapping("updateForm.pj")
    public ModelAndView updateProjectForm(@RequestParam("pjtNo") Integer pno, ModelAndView mv){
        if (pno == null) {
            mv.addObject("errorMsg", "프로젝트 번호가 없습니다").setViewName("common/errorPage");
            return mv;
        }

        Project p = pService.selectProject(pno);
        if(p != null) {
            mv.addObject("p", p).setViewName("project/ProjectUpdateForm");
        } else {
            mv.addObject("errorMsg", "기존 게시글 원본 조회 실패").setViewName("common/errorPage");
        }
        return mv;
    }

}
