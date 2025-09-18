package com.kh.semi.schedule.model.service;

import com.kh.semi.schedule.model.vo.Schedule;

import java.util.ArrayList;

public interface ScheduleService {
    ArrayList<Schedule> selectScheduleList();

    int insertSchedule(Schedule s);

    ArrayList<Schedule> confirmScheduleList();

    int denySchedule(int schNo);

    int progressSchedule(int schNo);
}
