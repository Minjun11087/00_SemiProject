package com.kh.semi.approve.controller;

import com.kh.semi.approve.model.service.ApproveServiceImpl;
import com.kh.semi.approve.model.vo.Approvement;
import com.kh.semi.attachment.model.service.AttachmentServiceImpl;
import com.kh.semi.attachment.model.vo.Attachment;
import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.common.template.FilePath;
import com.kh.semi.common.template.MyFileRenamePolicy;
import com.kh.semi.common.template.Pagination;
import com.kh.semi.employee.model.vo.Employee;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.kh.semi.common.template.FilePath.UPLOAD_PATH;

@Controller
public class AppController {
    @Autowired
    private ApproveServiceImpl aService;
    @Autowired
    private AttachmentServiceImpl atService;

    @GetMapping("list.app")
    public ModelAndView selectListApp(@RequestParam(value = "cpage", defaultValue = "1") int currentPage, ModelAndView mv){
        int listCount = aService.selectListCount();
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 9);
        ArrayList<Approvement> list = aService.selectList(pi);

        mv.addObject("pi", pi)
                .addObject("list", list)
                .setViewName("appBoard/appList");


        return mv;
    }

    @GetMapping("detail.app")
    public String selectAppBoard(int ano, @RequestParam(value="attCategory", defaultValue="3") int attCategory, Model model, HttpSession session) {

        // 1. 게시글 조회
        Approvement a = aService.selectAppBoard(ano);
        model.addAttribute("a", a);

        Employee loginUser = (Employee) session.getAttribute("loginUser");
        int loginEmpNo = loginUser.getEmpNo();

        // 2. 권한/버튼 계산
        boolean canEdit = (a.getEmpNo() == loginEmpNo && "U".equals(a.getManagerStatus()));
        model.addAttribute("canEdit", canEdit);

        boolean managerApproved = "A".equals(a.getManagerStatus());
        boolean managerRejected = "D".equals(a.getManagerStatus());
        boolean finalApproved = "A".equals(a.getFinalStatus());
        boolean finalRejected = "D".equals(a.getFinalStatus());
        model.addAttribute("managerApproved", managerApproved);
        model.addAttribute("managerRejected", managerRejected);
        model.addAttribute("finalApproved", finalApproved);
        model.addAttribute("finalRejected", finalRejected);

        boolean showManagerButtons = (a.getManagerNo() == loginEmpNo && !managerApproved && !managerRejected);
        boolean showFinalButtons = (a.getFinalNo() == loginEmpNo && !finalApproved && !finalRejected);
        model.addAttribute("showManagerButtons", showManagerButtons);
        model.addAttribute("showFinalButtons", showFinalButtons);
        model.addAttribute("loginEmpNo", loginEmpNo);

        // 3. 첨부파일 목록 조회 추가
        List<Attachment> attachments = atService.selectAttachments(ano, attCategory); // DAO/Service에 구현 필요
        model.addAttribute("attachments", attachments);

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
    public String insertAppBoard(
            Approvement a,
            @RequestParam(value="uploadFiles", required=false) List<MultipartFile> files,
            @RequestParam(value="attCategory", defaultValue="3") int attCategory,
            HttpSession session,
            RedirectAttributes reattr) throws IOException {

        Employee loginUser = (Employee) session.getAttribute("loginUser");
        if (loginUser == null) {
            reattr.addFlashAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/login.me";
        }

        a.setEmpNo(loginUser.getEmpNo());

        int result = aService.insertAppBoard(a);
        if (result <= 0 || a.getAppNo() <= 0) {
            reattr.addFlashAttribute("errorMsg", "결재신청 실패");
            return "common/errorPage";
        }

        int appNo = a.getAppNo();
        int processedFileCount = 0;


        if (files != null && !files.isEmpty()) {
            File folder = new File(FilePath.UPLOAD_PATH);
            if (!folder.exists()) folder.mkdirs();

            for (MultipartFile file : files) {
                if (file.isEmpty()) continue;

                String originName = file.getOriginalFilename();
                String changeName = new MyFileRenamePolicy().rename(originName);

                File dest = new File(FilePath.UPLOAD_PATH + changeName);
                file.transferTo(dest);

                Attachment att = new Attachment();
                att.setAttOrigin(originName);
                att.setAttChangeName(changeName);
                att.setAttFilePath(FilePath.URL_PATH); // URL 기준 상대경로
                att.setAttCategory(attCategory);
                att.setRefNo(appNo);

                int insertAttResult = atService.insertAttachment(att);
                if (insertAttResult > 0) processedFileCount++;
            }
        }

        String message = processedFileCount > 0 ?
                "결재신청 성공 (첨부파일 " + processedFileCount + "개)" :
                "결재신청 성공";

        reattr.addFlashAttribute("alertMsg", message);
        return "redirect:/list.app";
    }





    @PostMapping("update.app")
    public String updateAppBoard(
            @ModelAttribute Approvement a,
            @RequestParam(value="uploadFiles", required=false) List<MultipartFile> files,
            @RequestParam(value="deleteFiles", required=false) List<Integer> deleteFiles,
            @RequestParam(value="attCategory", defaultValue="3") int attCategory,
            RedirectAttributes reattr,
            Model model) throws IOException {

        int result = aService.updateAppBoard(a);
        System.out.println("게시글 등록 결과: " + result);
        System.out.println("a.getAppNo(): " + a.getAppNo());
        System.out.println(a);
        if(result <= 0) {
            model.addAttribute("errorMsg", "결재사항 수정 실패");
            return "common/errorPage";
        }

        String savePath = UPLOAD_PATH;

        // 1️⃣ 삭제 처리
        if(deleteFiles != null) {
            for(Integer attNo : deleteFiles) {
                Attachment delAtt = atService.selectAttachmentByNo(attNo);
                atService.deleteAttachmentByNo(attNo);

                if(delAtt != null) {
                    File f = new File(delAtt.getAttFilePath() + delAtt.getAttChangeName());
                    if(f.exists()) f.delete();
                }
            }
        }

        // 2️⃣ 새 파일 업로드
        if(files != null) {
            for(MultipartFile file : files) {
                if(file.isEmpty()) continue;

                String originName = file.getOriginalFilename();
                String ext = originName.substring(originName.lastIndexOf(".") + 1).toLowerCase();

                // 확장자 + 용량 검사
                if(!List.of("jpg","jpeg","png","xls","xlsx","doc","docx", "ppt", "zip", "txt").contains(ext)) continue;
                if(file.getSize() > 20 * 1024 * 1024) continue;

                String changeName = new MyFileRenamePolicy().rename(originName);

                File dest = new File(FilePath.UPLOAD_PATH + changeName);
                file.transferTo(dest);

                Attachment att = new Attachment();
                att.setAttOrigin(originName);
                att.setAttChangeName(changeName);
                att.setAttFilePath(FilePath.URL_PATH);
                att.setRefNo(a.getAppNo());
                att.setAttCategory(attCategory);
                atService.insertAttachment(att);
                System.out.println(att);
            }
        }

        reattr.addFlashAttribute("alertMsg", "결재사항 수정 완료");
        return "redirect:detail.app?ano=" + a.getAppNo();
    }







    @PostMapping("updateForm.app")
    public String appUpdateForm(int ano, @RequestParam(value="attCategory", defaultValue="3") int attCategory, Model model) {
        Approvement a = aService.selectAppBoard(ano);

        // 첨부파일 조회 후 VO에 세팅
        List<Attachment> attachments = atService.selectAttachments(ano, attCategory);
        a.setAttachments(attachments);

        model.addAttribute("a", a);
        return "appBoard/appUpdateForm";
    }


    @GetMapping("/download.app")
    public void downloadFile(@RequestParam("fileName") String fileName,
                             @RequestParam("origin") String origin,
                             HttpServletResponse response) throws IOException {

        File file = new File(FilePath.UPLOAD_PATH + fileName);
        if (!file.exists()) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write("<script>alert('파일이 존재하지 않습니다.');history.back();</script>");
            return;
        }

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition",
                "attachment; filename=\"" + URLEncoder.encode(origin, "UTF-8").replaceAll("\\+", "%20") + "\"");
        response.setContentLengthLong(file.length());

        try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
             BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {
            byte[] buffer = new byte[1024];
            int len;
            while ((len = in.read(buffer)) != -1) {
                out.write(buffer, 0, len);
            }
        }
    }

    @PostMapping("/deleteAttachment.app")
    @ResponseBody
    public Map<String,Object> deleteAttachment(int attNo){
        Map<String,Object> result = new HashMap<>();
        try {
            Attachment att = atService.selectAttachmentByNo(attNo);
            if(att != null){
                File file = new File(att.getAttFilePath() + att.getAttChangeName());
                if(file.exists()) file.delete();
                atService.deleteAttachmentByNo(attNo);
                result.put("success", true);
            } else {
                result.put("success", false);
                result.put("message", "첨부파일 없음");
            }
        } catch(Exception e){
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }



}
