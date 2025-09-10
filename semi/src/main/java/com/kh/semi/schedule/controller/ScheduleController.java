package com.kh.semi.schedule.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ScheduleController {
    @GetMapping("list.sd")
    public String schedule(){
        return "schedule/scheduleList";
    }
}
