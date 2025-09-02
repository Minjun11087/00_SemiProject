package com.kh.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/semi")
public class SemiController {

    @GetMapping("/approval")
    public String approval(){
        return "board/approval";
    }

    @GetMapping("/appDetail")
    public String appDetail() {
        return "board/appDetail";
    }

    @GetMapping("/require")
    public String require(){
        return "common/require";
    }




}
