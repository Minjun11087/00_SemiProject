package com.kh.semi.common.template;

public class FilePath {

    // 실행 경로 기준 (프로젝트 루트/semi/uploadFiles/)
    public static final String UPLOAD_PATH =
            System.getProperty("user.dir") + "/uploadFiles/";

    // URL 매핑용 (정적 리소스로 제공 시 사용)
    public static final String URL_PATH = "/uploadFiles/";
}
