package com.kh.spring.employee.controller;

import com.kh.spring.employee.model.service.EmployeeService;
import com.kh.spring.employee.model.vo.Employee;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService eService;

    @Autowired
    private PasswordEncoder bcryptPasswordEncoder;

    @PostMapping("login.bo")
    public String loginMember(Employee e, HttpSession session, RedirectAttributes redirectAttributes) {
        Employee loginUser = eService.loginMember(e);

        if(loginUser != null && bcryptPasswordEncoder.matches(e.getEmpPwd(), loginUser.getEmpPwd())) {
            //로그인 성공
            return "redirect:/menubar";
        }else {
            //로그인 실패
            redirectAttributes.addFlashAttribute("alertMsg", "로그인실패");
            return "redirect:/";
        }
        

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

    @GetMapping("myPage.me")
    public String myPage() {

        return "employee/myPage";

    }

    @PostMapping("update.me")
    public String updateMember(Employee e, Model model, HttpSession session, RedirectAttributes redirectAttributes) {

        int result = eService.updateMember(e);

        if(result > 0) { //성공

            Employee updateMem = eService.loginMember(e);
            session.setAttribute("loginUser", updateMem);

            redirectAttributes.addFlashAttribute("alertMsg", "변경 성공!");
            return "redirect:myPage.me";
        }else {//실패
            redirectAttributes.addFlashAttribute("alertMsg", "정보 변경 실패");
            return "employee/myPage";

        }

    }

    @PostMapping("delete.me")
    public String deleteMember(String empId, String empPwd, Model model, HttpSession session, RedirectAttributes redirectAttributes) {

        Employee loginUser = (Employee) session.getAttribute("loginUser");

        if(loginUser == null && bcryptPasswordEncoder.matches(empPwd, loginUser.getEmpPwd())) {
            redirectAttributes.addFlashAttribute("alertMsg", "비밀번호가 다릅니다.");
            return "employee/myPage";

        }


        int result = eService.deleteMember(empId);

        if(result > 0) {//성공
            session.setAttribute("empId", empId);
            session.removeAttribute("empId");
            redirectAttributes.addFlashAttribute("alertMsg", "회원탈퇴 성공");
            return "redirect:/";
        }else {//삭제
            redirectAttributes.addFlashAttribute("alertMsg", "회원탈퇴 실패");
            return "employee/myPage";
        }

    }

    @ResponseBody
    @RequestMapping("idCheck.me")
    public String idCheck(String checkId, Model model) {

        int count = eService.idCheck(checkId);

        return count > 0 ?  "NNNNN" : "NNNNY";

    }

}
