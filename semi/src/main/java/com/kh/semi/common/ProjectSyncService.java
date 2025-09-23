package com.kh.semi.common;

import com.kh.semi.common.template.NotionAPIClient;
import com.kh.semi.project.model.vo.Project;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Set;

@Service
public class ProjectSyncService {

    @Scheduled(fixedDelay = 10000) // 10초마다
    public void syncProjectsToNotion() {
        try {
            System.out.println("=== 프로젝트 동기화 시작 ===");

            // 완전한 클래스명으로 호출
            Set<String> existingProjects = NotionAPIClient.getExistingProjectNames();
            System.out.println("기존 프로젝트 " + existingProjects.size() + "개 발견");

            // 완전한 클래스명으로 호출
            List<Project> projects = OracleDBConnector.fetchData();
            int newProjectCount = 0;
            int duplicateCount = 0;

            for (Project project : projects) {
                if (existingProjects.contains(project.getPjtName())) {
                    duplicateCount++;
                    continue;
                }

                System.out.println("=== 새 프로젝트 발견 ===");
                System.out.println("프로젝트명: " + project.getPjtName());
                System.out.println("담당자: " + project.getEmpName());
                System.out.println("===================");

                // 완전한 클래스명으로 호출
                NotionAPIClient.createPage(project);
                newProjectCount++;
                Thread.sleep(100);
            }

            if (newProjectCount > 0 || duplicateCount > 0) {
                System.out.println("\n=== 동기화 결과 ===");
                System.out.println("신규 생성: " + newProjectCount + "개");
                System.out.println("기존 프로젝트: " + duplicateCount + "개");
                System.out.println("================");
            } else {
                System.out.println("새로운 프로젝트가 없습니다.");
            }

        } catch (SQLException | IOException | InterruptedException e) {
            System.err.println("동기화 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }
}