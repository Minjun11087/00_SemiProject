package com.kh.semi.project.controller;

import com.kh.semi.project.model.service.ProjectServiceImpl;
import com.kh.semi.project.model.vo.Project;
import oracle.jdbc.proxy.annotation.Post;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

    @GetMapping("enrollForm.pj")
    public String enrollForm() {
        //포워딩할 뷰 (/WEB-INㄲF/views/  board/boardEnrollForm  .jsp)
        return "project/ProjectEnrollForm";
    }

    @PostMapping("insert.pj")
    public String insertProject(Project p, MultipartFile upfiles, Model model, RedirectAttributes redirectAttributes) {
        System.out.println(upfiles);
        int result = pService.insertProject(p);

        if(result>0) {//성공
            redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 게시글 등록");
            return "redirect:/";
        }else {//실패
            model.addAttribute("errorMsg", "게시글 등록 실패 ");
            return "common/errorPage";
        }
    }

    @GetMapping("detail.pj")
    public ModelAndView selectProject(int pno, ModelAndView mv) {

        Project p = pService.selectProject(pno);

        if(p !=null) {
            mv.addObject("p", p).setViewName("project/projectDetailView");
        } else {
            mv.addObject("errorMsg", "게시글 조회 실패").setViewName("common/errorPage");
        }
        return mv;
    }

}
