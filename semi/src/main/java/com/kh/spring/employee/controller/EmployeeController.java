package com.kh.spring.employee.controller;

import com.kh.spring.employee.model.service.EmployeeService;
import com.kh.spring.employee.model.vo.Employee;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService eService;

    @Autowired
    private PasswordEncoder bcryptPasswordEncoder;

    @PostMapping("login.me")
    public ModelAndView loginMember(Employee e, HttpSession session, ModelAndView mv) {
        Employee loginUser = eService.loginMember(e);

        if(loginUser != null && bcryptPasswordEncoder.matches(e.getEmpPwd(), loginUser.getEmpPwd())) {
            //로그인 성공
            session.setAttribute("loginUser", loginUser);
            mv.setViewName("redirect:/");
        }else {
            //로그인 실패
            mv.addObject("errorMsg", "로그인실패");
            mv.setViewName("common/errorPage");
        }
        return mv;

    }

}
