package com.kh.semi.messenger.controller;

import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.messenger.model.service.MessengerService;
import com.kh.semi.messenger.model.vo.Message;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;

@Controller
@RequestMapping("/semi")
public class MessengerController {

    @Autowired
    private MessengerService msService;

    @GetMapping("/main.ms")
    public String messenger(HttpSession session, Model model){

        return "common/messenger";
    }

    @PostMapping(value = "/cr.ms", produces = "application/JSON; charset=utf-8")
    @ResponseBody
    public ArrayList<Message> chatroom(Message ms, Model model){

        ArrayList<Message> chatroom = msService.chatroom(ms);
        model.addAttribute("chatroom", chatroom);

        return chatroom;
    }

    @PostMapping("/send.ms")
    public String sendMessage(Message ms, Model model){ // 수신자 = loginUser.empNo, 발신자 = 발신자 번호 얻어와야함

        int result = msService.sendMessage(ms);

        if(result > 0){
            return "success";
        }else{
            model.addAttribute("errorMsg", "메세지 전송 실패");
            return "false";
        }

    }

    @PostMapping(value = "/chatList.ms", produces = "application/JSON; charset=utf-8")
    @ResponseBody
    public ArrayList<Message> chatList(Message ms, Model model){

        ArrayList<Message> chatList = msService.chatList(ms);
        model.addAttribute("chatList", chatList);

        return chatList;
    }

    @GetMapping(value = "/empList.ms", produces = "application/JSON; charset=utf-8")
    @ResponseBody
    public ArrayList<Employee> empListMs(Model model){

        ArrayList<Employee> empList = msService.empListMs();

        model.addAttribute("empList", empList);

        return empList;
    }

    @PostMapping("/update.ms")
    public String updateMsStatus(Employee emp){ // 나중에 emp객체를 loginUser로 수정하면댐

        String msStatus = emp.getMessengerStatus();
        String empId = emp.getEmpId();

        int result;

        if(msStatus.equals("N")){
            result = msService.updateMsOnline(empId);
        }else{
            result = msService.updateMsOffline(empId);
        }

        if(result > 0){
            return "redirect:messenger";
        }else{
            return "common/errorPage";
        }


    }

}
