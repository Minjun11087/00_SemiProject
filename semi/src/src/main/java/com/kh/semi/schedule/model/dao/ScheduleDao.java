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

    public int insertSchedule(Schedule s, SqlSessionTemplate sqlSession) {
        return sqlSession.insert("scheduleMapper.insertSchedule", s);

    }

    public ArrayList<Schedule> confirmScheduleList(SqlSessionTemplate sqlSession) {
        return (ArrayList)sqlSession.selectList("scheduleMapper.confirmScheduleList");
    }

    public int denySchedule(SqlSessionTemplate sqlSession, int schNo) {
        return sqlSession.update("scheduleMapper.denySchedule", schNo);
    }

    public int progressSchedule(SqlSessionTemplate sqlSession, int schNo) {
        return sqlSession.update("scheduleMapper.progressSchedule", schNo);
    }
}
