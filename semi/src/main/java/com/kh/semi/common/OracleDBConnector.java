package com.kh.semi.common;

import com.kh.semi.project.model.vo.Project;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OracleDBConnector {
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521/xe";
    private static final String USER = "semi";
    private static final String PASS = "semi";

    public static List<Project> fetchData() throws SQLException {
        List<Project> data = new ArrayList<>();

        // 먼저 간단한 쿼리로 테스트
        String query = "SELECT " +
                "       p.PJT_NO, p.EMP_NO, p.PJT_NAME, p.PJT_CONTENT" +
                "     , p.PJT_STARTDATE, p.PJT_ENDDATE, p.PJT_ENROLLDATE" +
                "     , p.PJT_COUNT, p.PJT_STATUS, p.PJT_TAGS" +
                "     , e.EMP_NAME" +
                "  FROM PROJECT_TB p" +
                "  JOIN EMPLOYEE_TB e ON p.EMP_NO = e.EMP_NO";

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Project project = new Project();
                project.setPjtNo(rs.getInt("PJT_NO"));
                project.setEmpNo(rs.getInt("EMP_NO"));
                project.setPjtName(rs.getString("PJT_NAME"));
                project.setPjtContent(rs.getString("PJT_CONTENT"));
                project.setPjtStartDate(rs.getDate("PJT_STARTDATE"));
                project.setPjtEndDate(rs.getDate("PJT_ENDDATE"));
                project.setPjtEnrollDate(rs.getDate("PJT_ENROLLDATE"));
                project.setPjtCount(rs.getInt("PJT_COUNT"));
                project.setPjtStatus(rs.getString("PJT_STATUS"));
                project.setPjtTags(rs.getString("PJT_TAGS"));
                project.setEmpName(rs.getString("EMP_NAME"));
                data.add(project);
            }
        }
        return data;
    }

    // 테이블 구조 확인용 메서드 (디버깅용)
    public static void checkTableStructure() throws SQLException {
        String query = "SELECT column_name, data_type FROM user_tab_columns WHERE table_name = 'PROJECT_TB' ORDER BY column_id";

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            System.out.println("=== PROJECT_TB 테이블 구조 ===");
            while (rs.next()) {
                System.out.println("컬럼명: " + rs.getString("column_name") +
                        ", 타입: " + rs.getString("data_type"));
            }
        }
    }
}