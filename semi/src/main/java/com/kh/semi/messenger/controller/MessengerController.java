package com.kh.semi.messenger.controller;

import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.messenger.model.service.MessengerService;
import com.kh.semi.messenger.model.vo.Message;
import jakarta.servlet.http.HttpSession;
import oracle.jdbc.proxy.annotation.Post;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;

@Controller
@RequestMapping("semi")
public class MessengerController {

    @Autowired
    private MessengerService msService;

    @GetMapping("main.ms")
    public String messenger(HttpSession session, Model model, RedirectAttributes redirectAttributes){

        Employee emp = (Employee)session.getAttribute("loginUser");

        int empNo = emp.getEmpNo();
        String empId = emp.getEmpId();

        ArrayList<Message> list = msService.selectMessage(empNo);

        int result = msService.updateMsOnline(empId);

        if(result > 0){
            model.addAttribute("list", list);
            return "common/messenger";
        }else{
            redirectAttributes.addFlashAttribute("errorMsg", "메신저 접속 불가");
            return "redirect:/";
        }

    }

    @PostMapping(value = "cr.ms", produces = "application/json; charset=utf-8")
    @ResponseBody
    public ArrayList<Message> chatroom(Message ms){

        ArrayList<Message> chatroom = msService.chatroom(ms);

        return chatroom;
    }

    @PostMapping(value = "wcr.ms", produces = "application/json; charset=utf-8")
    @ResponseBody
    public ArrayList<Message> wholeChatRoom(Message ms, HttpSession session){

        Employee emp = (Employee)session.getAttribute("loginUser");
        int myNo = emp.getEmpNo();

        ArrayList<Message> wholeChatRoom;

        if(ms.getEmpRno() == myNo){
            wholeChatRoom = msService.wholeChatRoomR(ms);
            return wholeChatRoom;
        }else if(ms.getEmpSno() == myNo){
            wholeChatRoom = msService.wholeChatRoomS(ms);
            return wholeChatRoom;
        }else{
            return null;
        }
    }

    @PostMapping("send.ms")
    @ResponseBody
    public String sendMessage(Message ms, Model model){ // 수신자 = loginUser.empNo, 발신자 = 발신자 번호 얻어와야함

        int result = msService.sendMessage(ms);

        if(result > 0){
            return "success";
        }else{
            model.addAttribute("errorMsg", "메세지 전송 실패");
            return "false";
        }

    }

    @PostMapping(value = "chatList.ms", produces = "application/json; charset=utf-8")
    @ResponseBody
    public ArrayList<Message> chatList(Message ms){

        ArrayList<Message> chatList = msService.chatList(ms);

        return chatList;
    }

    @GetMapping(value = "empList.ms", produces = "application/json; charset=utf-8")
    @ResponseBody
    public ArrayList<Employee> empListMs(){

        ArrayList<Employee> empList = msService.empListMs();

        return empList;
    }

    @PostMapping("update.ms")
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
