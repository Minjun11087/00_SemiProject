package com.kh.semi.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload-dir}") // properties 파일에서 키값 찾아서 value 주입해줌
    private String uploadDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("/uploadFiles/**") // 브라우저에서 접근할 url 패턴
                .addResourceLocations("file:///" + uploadDir); // 실제 os 경로

    }

    // 요청 url : localhost:8083/uploadFiles/파일명.png 을 보내도
    // 실제로는    localhost:8083/uploadFiles/ 가 요청되는것이 아니라
    //             c:/09_springboot-workspace/spring/uploadFiles 경로로 요청됨
}
