package com.kh.semi;

import com.kh.semi.common.NotionAPIClient;
import com.kh.semi.common.OracleDBConnector;
import com.kh.semi.project.model.vo.Project;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Set;
import java.util.HashSet;

@SpringBootApplication
public class SemiApplication {

    public static void main(String[] args) throws IOException, InterruptedException {
        SpringApplication.run(SemiApplication.class, args);

        // 디버그: 데이터베이스 구조 확인 (처음 한 번만 실행)
        // NotionAPIClient.inspectDatabase();

        List<Project> projects = null;
        try {
            // Notion에서 기존 프로젝트 목록 조회
            System.out.println("기존 프로젝트 목록을 조회 중...");
            Set<String> existingProjects = NotionAPIClient.getExistingProjectNames();
            System.out.println("기존 프로젝트 " + existingProjects.size() + "개 발견");

            projects = OracleDBConnector.fetchData();
            int newProjectCount = 0;
            int duplicateCount = 0;

            for (Project project : projects) {
                // 중복 체크 (프로젝트명 기준)
                if (existingProjects.contains(project.getPjtName())) {
                    System.out.println("=== 중복 프로젝트 스킵 ===");
                    System.out.println("프로젝트명: " + project.getPjtName() + " (이미 존재함)");
                    System.out.println("====================");
                    duplicateCount++;
                    continue;
                }

                System.out.println("=== 새 프로젝트 전송 ===");
                System.out.println("프로젝트명: " + project.getPjtName());
                System.out.println("내용: " + project.getPjtContent());
                System.out.println("시작일: " + project.getPjtStartDate());
                System.out.println("종료일: " + project.getPjtEndDate());
                System.out.println("상태: " + project.getPjtStatus());
                System.out.println("태그: " + project.getPjtTags());
                System.out.println("담당자: " + project.getEmpName());
                System.out.println("====================");

                NotionAPIClient.createPage(project);
                newProjectCount++;
                Thread.sleep(100);
            }

            System.out.println("\n=== 실행 결과 ===");
            System.out.println("신규 생성: " + newProjectCount + "개");
            System.out.println("중복 스킵: " + duplicateCount + "개");
            System.out.println("===============");

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }
}