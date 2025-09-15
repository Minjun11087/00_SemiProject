package com.kh.semi.schedule.model.service;

import com.kh.semi.schedule.model.dao.ScheduleDao;
import com.kh.semi.schedule.model.vo.Schedule;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
@Service
public class ScheduleServiceImpl implements ScheduleService{

    @Autowired
    private ScheduleDao sDao;
    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public ArrayList<Schedule> selectScheduleList() {
        return sDao.selectScheduleList(sqlSession);
    }

    @Override
    public int insertSchedule(Schedule s) {
        return sDao.insertSchedule(s, sqlSession);
    }
}
