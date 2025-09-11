package com.kh.semi.schedule.controller;

import com.kh.semi.project.model.vo.Project;
import com.kh.semi.schedule.model.service.ScheduleServiceImpl;
import com.kh.semi.schedule.model.vo.Schedule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

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




}
