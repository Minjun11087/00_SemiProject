package com.kh.semi.employee.controller;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.common.template.Pagination;
import com.kh.semi.employee.model.service.EmployeeService;
import com.kh.semi.employee.model.vo.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService bservice;

    @GetMapping("list.emp")
    public ModelAndView selectList(@RequestParam(value="cpage", defaultValue = "1") int currentPage, ModelAndView mv){

        int listCount = bservice.selectListCount();

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        ArrayList<Employee> list = bservice.selectList(pi);

        mv.addObject("pi", pi)
                .addObject("list", list)
                .setViewName("employee/empListView");

        return mv;
    }


    @GetMapping("detail.emp")
    public String selectEmployee(int eno, Model model){

         Employee emp = bservice.selectEmployee(eno);

         model.addAttribute("emp", emp);
         return "employee/empDetailView";

    }

    @GetMapping("zozic.emp")
    public String zozicPage(){

        return "employee/zozicdoView";
    }

    @GetMapping("search.sc")
    public String searchEmployee(
            @RequestParam(value="cpage", defaultValue= "1") int currentPage,
            @RequestParam("keyword") String keyword, Model model){

        int listCount = bservice.selectSearchCount(keyword);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        ArrayList<Employee> list = bservice.searchEmployee(keyword, pi);

        model.addAttribute("list", list);
        model.addAttribute("pi", pi);
        model.addAttribute("keyword", keyword);

        return "employee/empListView";

    }





}
