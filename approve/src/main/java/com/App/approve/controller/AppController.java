package com.App.approve.controller;

import com.App.approve.model.service.ApproveServiceImpl;
import com.App.approve.model.vo.Approvement;
import com.App.common.model.vo.PageInfo;
import com.App.common.template.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
        System.out.println(pi);
        System.out.println(list);
        mv.addObject("pi", pi)
                .addObject("list", list)
                .setViewName("appBoard/appList");


        return mv;
    }

    @GetMapping("detail.app")
    public String selectAppBoard(int ano, Model model){

        Approvement a = aService.selectAppBoard(ano);
        model.addAttribute("a", a);
        return "appBoard/appView";
    }

}
