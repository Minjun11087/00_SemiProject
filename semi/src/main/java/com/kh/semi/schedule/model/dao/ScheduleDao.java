package com.kh.semi.schedule.model.dao;

import com.kh.semi.schedule.model.vo.Schedule;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class ScheduleDao {
    public ArrayList<Schedule> selectScheduleList(SqlSessionTemplate sqlSession) {
        return (ArrayList)sqlSession.selectList("scheduleMapper.selectScheduleList");

    }
}
