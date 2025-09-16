package com.kh.semi.schedule.controller;

import com.kh.semi.project.model.vo.Project;
import com.kh.semi.schedule.model.service.ScheduleServiceImpl;
import com.kh.semi.schedule.model.vo.Schedule;
import jakarta.servlet.http.HttpSession;
import oracle.jdbc.proxy.annotation.Post;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;

@Controller
public class ScheduleController {

    @Autowired
    private ScheduleServiceImpl sService;

    @GetMapping("list.sd")
    public ModelAndView schedule(ModelAndView mv){

        ArrayList<Schedule> plist = sService.selectScheduleList();

        mv.addObject("plist", plist).setViewName("schedule/scheduleList");
        return mv;
    }
    @GetMapping("enrollForm.sd")
    public String enrollFormSchedule(){
        return "schedule/scheduleCreate";
    }


    @PostMapping("insert.sd")
    public String insertSchedule(Schedule s, Model model, RedirectAttributes  redirectAttributes){
        int result = sService.insertSchedule(s);

        if(result>0) {//성공
            redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 일정 등록");
            return "redirect:/list.sd";
        }else {//실패
            model.addAttribute("errorMsg", "일정등록 실패 ");
            return "common/errorPage";
        }

    }


    @GetMapping("confirm.sd")
    public String confirmSchedule(HttpSession session, Model model) {
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        if (loginUser == null || !"D3".equals(loginUser.getDeptCode())) {
            model.addAttribute("errorMsg", "접근할 수 있는 권한이 없습니다.");
            return "common/errorPage";
        } else {
            return "schedule/scheduleConfirm";
        }
    }


}
