package com.kh.semi.common;

import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.messenger.model.service.MessengerService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class loginController {

    @Autowired
    private MessengerService msService;

    @Autowired
    private PasswordEncoder bcryptPasswordEncoder;

    @PostMapping("login.me")
    public ModelAndView loginEmp(Employee emp, HttpSession session, ModelAndView mv){

        Employee loginUser = msService.loginEmp(emp);

        if(loginUser != null && bcryptPasswordEncoder.matches(emp.getEmpPwd(), loginUser.getEmpPwd())) {
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

    @GetMapping("enrollForm.me")
    public String enrollForm(){

        return "common/enrollForm";
    }

    @PostMapping("insert.me")
    public String insertEmp(Employee emp, Model model, RedirectAttributes redirectAttributes){
        String encPwd = bcryptPasswordEncoder.encode(emp.getEmpPwd());

        //System.out.println(encPwd);
        emp.setEmpPwd(encPwd); // Member객체에 userPwd에 평문이 아닌 암호문으로 변경

        System.out.println(emp);

        int result = msService.insertEmp(emp);

        if(result > 0) {//성공 -> 메인페이지 url재요청
            // 타임 리프에서는 세션 값을 자동으로 지우지 않기 때문에 1회성 메시지를 처리할 수 있는 것으로 사용
            redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 회원가입 되었습니다!");
            return "redirect:/";
        }else {
            model.addAttribute("errorMsg", "회원가입실팽");
            return "common/errorPage";
        }
    }

    @GetMapping("/mainTest.do")
    public String mainTest(){

        return "common/mainTest";
    }
}
