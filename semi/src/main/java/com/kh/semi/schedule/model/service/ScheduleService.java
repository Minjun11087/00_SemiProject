package com.kh.semi.schedule.model.service;

import com.kh.semi.schedule.model.vo.Schedule;

import java.util.ArrayList;

public interface ScheduleService {
    ArrayList<Schedule> selectScheduleList();

}
