package com.App.approve.controller;

import com.App.approve.model.service.ApproveServiceImpl;
import com.App.approve.model.vo.Approvement;
import com.App.common.model.vo.PageInfo;
import com.App.common.template.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;

@Controller
public class AppController {
    @Autowired
    private ApproveServiceImpl aService;

    @GetMapping("/")
    public ModelAndView selectListApp(@RequestParam(value = "cpage", defaultValue = "1") int currentPage, ModelAndView mv){
        int listCount = aService.selectListCount();
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
        ArrayList<Approvement> list = aService.selectList(pi);
        mv.addObject("pi", pi)
                .addObject("list", list)
                .setViewName("appBoard/appList");


        return mv;
    }

    @GetMapping("detail.app")
    public String selectAppBoard(int ano, Model mv){

        Approvement a = aService.selectAppBoard(ano);
        mv.addAttribute("a", a);
        System.out.println(a);
        return "appBoard/appView";
    }

    @GetMapping("enrollForm.app")
    public String appEnrollForm(){
        return "appBoard/appEnrollForm";
    }

    @PostMapping("insertBoard.app")
    public String insertAppBoard(Approvement a, Model model, RedirectAttributes reattr){
        int result = aService.insertAppBoard(a);

        if(result>0){
            reattr.addFlashAttribute("alertMsg", "결재신청 성공");
            return "redirect:/";
        }else{
            model.addAttribute("errorMsg", "결재신청 실패");
            return "redirect:/";
        }
    }

    @GetMapping("updateForm.app")
    public String appUpdateForm(Approvement a, Model model, RedirectAttributes reattr){
        return "appBoard/appUpdateForm";
    }

    @PostMapping("update.app")
    public String updateAppBoard(){

    }


}
