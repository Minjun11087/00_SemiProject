package com.kh.semi.project.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.semi.attachment.model.service.AttachmentServiceImpl;
import com.kh.semi.attachment.model.vo.Attachment;
import com.kh.semi.common.template.FilePath;
import com.kh.semi.common.template.MyFileRenamePolicy;
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
        for (MultipartFile file : upfiles) {
            System.out.println(file.getOriginalFilename());

        }

        if (upfiles  != null && !upfiles.isEmpty()) {
            File folder = new File(FilePath.UPLOAD_PATH);
                if (!folder.exists()) folder.mkdirs();
                for (MultipartFile file : upfiles) {
                    if (file.isEmpty()) continue;
                    String originName = file.getOriginalFilename();
                    String changeName = new MyFileRenamePolicy().rename(originName);
                    File dest = new File(FilePath.UPLOAD_PATH + changeName);
                    try {
                        file.transferTo(dest);
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                    Attachment att = new Attachment();
                    att.setAttOrigin(originName);
                    att.setAttChangeName(changeName);
                    att.setAttFilePath(FilePath.URL_PATH);
                    att.setAttCategory(attCategory);
                    att.setRefNo(p.getPjtNo());
                    int insertAttResult = attService.insertAttachment(att);

                }
        }

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
