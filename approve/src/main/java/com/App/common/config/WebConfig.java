package com.App.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    // application.properties파일에서 키값을 찾아 value를 주입해줌.
        // -> 외부파일의 경로를 주입해줄것임.
    @Value("${file.upload-dir}")
    private String uploadDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("/uploadFiles/**") // 브라우저에서 접근할 url 패턴
                .addResourceLocations("file:///" + uploadDir);    // 실제 os 경로
        /*
            요청 url : localhost:8083/uploadFiles/파일명.png를 보내도,
                실제로는 localhost:8083/uploadFiles/ 가 요청되는 것이 아니라,
                properties 파일에 작성한 (C:/09_springboot-workspace/spring/uploadFiles/) 경로로 요청됨.
        */

    }

}
