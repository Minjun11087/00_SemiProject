package com.kh.semi.messenger.controller;

import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.messenger.model.service.MessengerService;
import com.kh.semi.messenger.model.vo.Message;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;

@Controller
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
            return "messenger/messenger";
        }else{
            redirectAttributes.addFlashAttribute("errorMsg", "메신저 접속 불가");
            return "redirect:/";
        }

    }

    @PostMapping(value = "scr.ms", produces = "application/json; charset=utf-8")
    @ResponseBody
    public ArrayList<Message> chatroom(Message ms){

        ArrayList<Message> selectChatroom = msService.chatroom(ms);

        return selectChatroom;
    }

    @PostMapping(value = "wcr.ms", produces = "application/json; charset=utf-8")
    @ResponseBody
    public ArrayList<Message> wholeChatRoom(Message ms, HttpSession session){

        Employee emp = (Employee)session.getAttribute("loginUser");
        int myNo = emp.getEmpNo();

        ArrayList<Message> wholeChatRoom = msService.getLatestMessagesForUser(myNo);

        return wholeChatRoom;
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
    public ArrayList<Message> chatList(@RequestParam int myEmpNo, @RequestParam int otherEmpNo){

        Message ms = new Message();
        ms.setEmpRno(otherEmpNo);
        ms.setEmpSno(myEmpNo);

        return msService.chatList(ms);
    }

    @GetMapping(value = "empList.ms", produces = "application/json; charset=utf-8")
    @ResponseBody
    public ArrayList<Employee> empListMs(){

        ArrayList<Employee> empList = msService.empListMs();

        return empList;
    }

    @PostMapping("updateStatus.ms")
    @ResponseBody
    public ResponseEntity<String> updateMsStatusAjax(@RequestParam String empId, @RequestParam String messengerStatus){

        int result;

        if(messengerStatus.equals("N")){
            result = msService.updateMsOnline(empId);
        } else {
            result = msService.updateMsOffline(empId);
        }

        if(result > 0){
            return ResponseEntity.ok("상태 업데이트 성공");
        } else {
            return ResponseEntity.status(500).body("상태 업데이트 실패");
        }
    }

    @PostMapping("exitChatRoom.ms")
    public String chatExit(String exitEmpId, int exitEmpRno, int exitEmpSno,
                           HttpSession session, RedirectAttributes redirectAttributes, Model model){

        Employee emp = (Employee)session.getAttribute("loginUser");
        int result = 0;

        if(emp.getEmpId().equals(exitEmpId)){
            result = msService.chatExit(exitEmpRno, exitEmpSno);

            if(result > 0){
                redirectAttributes.addFlashAttribute("alertMsg", "채팅방 나가기에 성공했습니다.");
                return "redirect:main.ms";
            }else{
                model.addAttribute("errorMsg", "채팅방 나가기 실패!");
                return "common/errorPage";
            }
        }else {
            model.addAttribute("errorMsg", "아이디가 일치하지 않습니다!");
            return "common/errorPage";
        }

    }

}
