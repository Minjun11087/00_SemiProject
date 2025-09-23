package com.kh.semi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling  // 스케줄링 활성화
public class SemiApplication {

    public static void main(String[] args) {
        SpringApplication.run(SemiApplication.class, args);

        // 애플리케이션 시작 메시지
        System.out.println("=================================");
        System.out.println("프로젝트 동기화 서비스가 시작되었습니다.");
        System.out.println("5분마다 Oracle DB → Notion 동기화 실행");
        System.out.println("=================================");

        // 기존의 main 메서드 동기화 로직은 모두 제거!
        // 이제 ProjectSyncService에서 스케줄러로 처리됩니다.
    }
}