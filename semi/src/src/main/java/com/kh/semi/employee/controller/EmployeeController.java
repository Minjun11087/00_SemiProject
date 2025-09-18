package com.kh.semi.employee.controller;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.common.template.Pagination;
import com.kh.semi.employee.model.service.EmployeeService;
import com.kh.semi.employee.model.vo.Employee;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService eService;

    @Autowired
    private PasswordEncoder bcryptPasswordEncoder;

    @PostMapping("login.bo")
    public ModelAndView loginMember(Employee e, HttpSession session, RedirectAttributes redirectAttributes, ModelAndView mv) {
        Employee loginUser = eService.loginMember(e);
        if(loginUser != null && bcryptPasswordEncoder.matches(e.getEmpPwd(), loginUser.getEmpPwd())) {
            //로그인 성공
            session.setAttribute("loginUser", loginUser);
            mv.setViewName("project/main");
        }else {
            //로그인 실패
            mv.addObject("errorMsg", "로그인실패");
            mv.setViewName("redirect:/");

        }

        return mv;

    }

    @RequestMapping("enrollForm.bo")
    public String enrollForm() {
        return "employee/employeeEnrollForm";

    }

    @PostMapping("insert.bo")
    // jsp의 name값을 vo의 필드명과 동일하게!!
    public String insertMember(Employee e, Model model, RedirectAttributes redirectAttributes) {

        String encPwd = bcryptPasswordEncoder.encode(e.getEmpPwd());

        e.setEmpPwd(encPwd);
        int result = eService.insertMember(e);

        if(result > 0) {//성공 -> 메인페이지 url재요청

            redirectAttributes.addFlashAttribute("alertMsg", "회원가입 성공");
            return "redirect:/";
        }else {
           redirectAttributes.addFlashAttribute("alertMsg", "회원가입 실패");
           return "employee/employeeEnrollForm";
        }


    }

    @GetMapping("myPage.bo")
    public String myPage() {

        return "Employee/mypage";

    }

    @PostMapping("update.bo")
    public String updateMember(Employee e, Model model, HttpSession session, RedirectAttributes redirectAttributes) {

        int result = eService.updateMember(e);

        if(result > 0) { //성공

            Employee updateMem = eService.loginMember(e);
            session.setAttribute("loginUser", updateMem);

            redirectAttributes.addFlashAttribute("alertMsg", "변경 성공!");
            return "Employee/mypage";
        }else {//실패
            redirectAttributes.addFlashAttribute("alertMsg", "정보 변경 실패");
            return "Employee/myPage";

        }

    }

    @PostMapping("delete.bo")
    public String deleteMember(String empId, String empPwd, Model model, HttpSession session, RedirectAttributes redirectAttributes) {

        Employee loginUser = (Employee) session.getAttribute("loginUser");

        if(loginUser == null && bcryptPasswordEncoder.matches(empPwd, loginUser.getEmpPwd())) {
            redirectAttributes.addFlashAttribute("alertMsg", "비밀번호가 다릅니다.");
            return "Employee/myPage";

        }


        int result = eService.deleteMember(empId);

        if(result > 0) {//성공
            session.setAttribute("empId", empId);
            session.removeAttribute("empId");
            redirectAttributes.addFlashAttribute("alertMsg", "회원탈퇴 성공");
            return "redirect:/";
        }else {//삭제
            redirectAttributes.addFlashAttribute("alertMsg", "회원탈퇴 실패");
            return "Employee/myPage";
        }

    }

    @ResponseBody
    @RequestMapping("idCheck.me")
    public String idCheck(String checkId, Model model) {

        int count = eService.idCheck(checkId);

        return count > 0 ?  "NNNNN" : "NNNNY";

    }


    @GetMapping("list.emp")
    public ModelAndView selectList(@RequestParam(value="cpage", defaultValue = "1") int currentPage, ModelAndView mv){

        int listCount = eService.selectListCount();

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        ArrayList<Employee> list = eService.selectList(pi);

        mv.addObject("pi", pi)
                .addObject("list", list)
                .setViewName("employee/empListView");

        return mv;
    }


    @GetMapping("detail.emp")
    public String selectEmployee(int eno, Model model){

        Employee emp = eService.selectEmployee(eno);

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

        int listCount = eService.selectSearchCount(keyword);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        ArrayList<Employee> list = eService.searchEmployee(keyword, pi);

        model.addAttribute("list", list);
        model.addAttribute("pi", pi);
        model.addAttribute("keyword", keyword);

        return "employee/empListView";

    }



}
