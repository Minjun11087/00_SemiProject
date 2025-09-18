package com.kh.semi.customer.controller;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.common.template.Pagination;
import com.kh.semi.customer.model.service.CustomerServiceImpl;
import com.kh.semi.customer.model.vo.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;

@Controller
public class CustomerController {

    @Autowired
    private CustomerServiceImpl cusService;

    @GetMapping("list.cus")
    private ModelAndView selectCusList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage, ModelAndView mv){
            int listCount = cusService.selectCusListCount();

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
        ArrayList<Customer> list = cusService.selectCusList(pi);

        mv.addObject("list", list)
                .addObject("pi", pi)
                .setViewName("customer/cusListView");

        return mv;
    }

}
