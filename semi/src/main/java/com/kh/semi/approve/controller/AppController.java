package com.kh.semi.approve.controller;

import com.kh.semi.approve.model.service.ApproveServiceImpl;
import com.kh.semi.approve.model.vo.Approvement;
import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.common.template.Pagination;
import com.kh.semi.employee.model.vo.Employee;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class AppController {
    @Autowired
    private ApproveServiceImpl aService;

    @GetMapping("list.app")
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
    public String selectAppBoard(int ano, Model model, HttpSession session) {
        Approvement a = aService.selectAppBoard(ano);
        model.addAttribute("a", a);
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        int loginEmpNo = loginUser.getEmpNo();

        boolean canEdit = (a.getEmpNo() == loginEmpNo && "U".equals(a.getManagerStatus()));
        model.addAttribute("canEdit", canEdit);

        // 승인 상태 계산
        boolean managerApproved = "A".equals(a.getManagerStatus());
        boolean managerRejected = "D".equals(a.getManagerStatus());
        boolean finalApproved = "A".equals(a.getFinalStatus());
        boolean finalRejected = "D".equals(a.getFinalStatus());
        model.addAttribute("managerApproved", managerApproved);
        model.addAttribute("managerRejected", managerRejected);
        model.addAttribute("finalApproved", finalApproved);
        model.addAttribute("finalRejected", finalRejected);

        // 버튼 표시 여부 계산
        boolean showManagerButtons = (a.getManagerNo() == loginEmpNo && !managerApproved && !managerRejected);
        boolean showFinalButtons = (a.getFinalNo() == loginEmpNo && !finalApproved && !finalRejected);
        model.addAttribute("showManagerButtons", showManagerButtons);
        model.addAttribute("showFinalButtons", showFinalButtons);
        model.addAttribute("loginEmpNo", loginEmpNo);

        return "appBoard/appView";
    }


    @PostMapping("updateStatus.app")
    @ResponseBody
    public Map<String, Object> updateStatus(@RequestBody Map<String, Object> req, HttpSession session) {
        int ano = Integer.parseInt(req.get("ano").toString());
        String status = req.get("status").toString();
        String type = req.get("type").toString();
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        int loginEmpNo = loginUser.getEmpNo();
        Approvement a = aService.selectAppBoard(ano);

        System.out.println("Request - ano: " + ano + ", status: " + status + ", type: " + type);
        System.out.println("Login - loginEmpNo: " + loginEmpNo);
        System.out.println("Approvement - managerNo: " + a.getManagerNo() + ", finalNo: " + a.getFinalNo());
        System.out.println("Status - managerStatus: " + a.getManagerStatus() + ", finalStatus: " + a.getFinalStatus());

        int result = 0;
        if ("manager".equals(type) && a.getManagerNo() == loginEmpNo && "U".equals(a.getManagerStatus())) {
            result = aService.updateManagerStatus(ano, status);
            System.out.println("updateManagerStatus result: " + result);
        } else if ("final".equals(type) && a.getFinalNo() == loginEmpNo && "U".equals(a.getFinalStatus())) {
            result = aService.updateFinalStatus(ano, status);
            System.out.println("updateFinalStatus result: " + result);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        return response;
    }








    @GetMapping("enrollForm.app")
    public String appEnrollForm(Model model){
        String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        model.addAttribute("today", today);
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
            return "redirect:common/errorPage";
        }
    }

    @PostMapping("updateForm.app")
    public String appUpdateForm(int ano, Model model){
        model.addAttribute("a", aService.selectAppBoard(ano));
        return "appBoard/appUpdateForm";
    }

    @PostMapping("update.app")
    public String updateAppBoard(Approvement a, Model model, RedirectAttributes reattr){

        int result = aService.updateAppBoard(a);
        if(result > 0){
            reattr.addFlashAttribute("alertMsg", "결재사항 수정완료");
            return "redirect:detail.app?ano=" + a.getAppNo();
        }else{
            model.addAttribute("errorMsg", "결재사항 수정 실패");
            return "common/errorPage";
        }
    }




}
