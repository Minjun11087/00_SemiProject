package com.kh.semi.common;

import com.kh.semi.project.model.vo.Project;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;
import java.util.HashSet;

public class NotionAPIClient {

    private static final String NOTION_API_URL = "https://api.notion.com/v1";
    private static final String DATABASE_ID = "27752ecd519480e4b84fd1b64209cafb";
    private static final String NOTION_TOKEN = "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";
    private static final HttpClient httpClient = HttpClient.newHttpClient();
    private static final ObjectMapper objectMapper = new ObjectMapper();
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    /**
     * Notion 데이터베이스에서 기존 프로젝트명들을 조회
     */
    public static Set<String> getExistingProjectNames() throws IOException, InterruptedException {
        Set<String> existingProjects = new HashSet<>();

        // 모든 페이지를 조회 (필터 없이)
        String requestBody = "{}";

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(NOTION_API_URL + "/databases/" + DATABASE_ID + "/query"))
                .header("Authorization", "Bearer " + NOTION_TOKEN)
                .header("Content-Type", "application/json")
                .header("Notion-Version", "2022-06-28")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() == 200) {
            JsonNode responseJson = objectMapper.readTree(response.body());
            JsonNode results = responseJson.get("results");

            for (JsonNode page : results) {
                JsonNode properties = page.get("properties");

                // 실제 프로퍼티 이름을 찾기 위해 모든 프로퍼티를 확인
                properties.fieldNames().forEachRemaining(fieldName -> {
                    JsonNode property = properties.get(fieldName);
                    if (property.has("title")) {
                        JsonNode titleArray = property.get("title");
                        if (titleArray.isArray() && titleArray.size() > 0) {
                            String projectName = titleArray.get(0).get("plain_text").asText();
                            existingProjects.add(projectName);
                        }
                    }
                });
            }
        } else {
            System.err.println("Notion API 조회 실패: " + response.statusCode());
            System.err.println("Response: " + response.body());
        }

        return existingProjects;
    }

    /**
     * 프로젝트명이 이미 존재하는지 확인
     */
    public static boolean isProjectExists(String projectName) throws IOException, InterruptedException {
        Set<String> existingProjects = getExistingProjectNames();
        return existingProjects.contains(projectName);
    }

    /**
     * 새 페이지 생성
     */
    public static void createPage(Project project) throws IOException, InterruptedException {
        // 중복 체크
        if (isProjectExists(project.getPjtName())) {
            System.out.println("프로젝트 '" + project.getPjtName() + "'는 이미 존재합니다. 생성을 건너뜁니다.");
            return;
        }

        String requestBody = String.format("""
            {
                "parent": { "database_id": "%s" },
                "properties": {
                    "pjtName": {
                        "title": [{ "text": { "content": "%s" } }]
                    },
                    "pjtContent": {
                        "rich_text": [{ "text": { "content": "%s" } }]
                    },
                    "pjtStartDate": {
                        "rich_text": [{ "text": { "content": "%s" } }]
                    },
                    "pjtEndDate": {
                        "rich_text": [{ "text": { "content": "%s" } }]
                    },
                    "pjtStatus": {
                        "rich_text": [{ "text": { "content": "%s" } }]
                    },
                    "pjtTags": {
                        "rich_text": [{ "text": { "content": "%s" } }]
                    },
                    "empName": {
                        "rich_text": [{ "text": { "content": "%s" } }]
                    }
                }
            }
            """,
                DATABASE_ID,
                escapeJsonString(project.getPjtName()),
                escapeJsonString(project.getPjtContent()),
                escapeJsonString(dateToString(project.getPjtStartDate())),
                escapeJsonString(dateToString(project.getPjtEndDate())),
                escapeJsonString(project.getPjtStatus()),
                escapeJsonString(project.getPjtTags()),
                escapeJsonString(project.getEmpName())
        );

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(NOTION_API_URL + "/pages"))
                .header("Authorization", "Bearer " + NOTION_TOKEN)
                .header("Content-Type", "application/json")
                .header("Notion-Version", "2022-06-28")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() == 200) {
            System.out.println("페이지 생성 성공: " + project.getPjtName());
        } else {
            System.err.println("페이지 생성 실패: " + response.statusCode());
            System.err.println("Response: " + response.body());

            if (response.body().contains("Could not find property")) {
                System.out.println("프로퍼티 이름 확인이 필요합니다. Notion 데이터베이스의 실제 프로퍼티 이름을 확인해주세요.");
            }
        }
    }

    /**
     * JSON 문자열 이스케이프 처리
     */
    private static String escapeJsonString(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"")
                .replace("\\", "\\\\")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    /**
     * Date를 String으로 변환
     */
    private static String dateToString(Date date) {
        if (date == null) return "";
        return dateFormat.format(date);
    }

    /**
     * 데이터베이스 구조 확인 (디버그용)
     */
    public static void inspectDatabase() throws IOException, InterruptedException {
        System.out.println("=== 데이터베이스 구조 확인 ===");

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(NOTION_API_URL + "/databases/" + DATABASE_ID))
                .header("Authorization", "Bearer " + NOTION_TOKEN)
                .header("Content-Type", "application/json")
                .header("Notion-Version", "2022-06-28")
                .GET()
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() == 200) {
            JsonNode responseJson = objectMapper.readTree(response.body());
            JsonNode properties = responseJson.get("properties");

            System.out.println("실제 프로퍼티 목록:");
            properties.fieldNames().forEachRemaining(fieldName -> {
                JsonNode property = properties.get(fieldName);
                String type = property.get("type").asText();
                System.out.println("- \"" + fieldName + "\" (" + type + ")");
            });
        } else {
            System.err.println("데이터베이스 조회 실패: " + response.statusCode());
            System.err.println("Response: " + response.body());
        }
    }
}