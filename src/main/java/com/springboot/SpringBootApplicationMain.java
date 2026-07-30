package com.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class SpringBootApplicationMain extends SpringBootServletInitializer {

    public static void main(String[] args) {
        System.setProperty(
                "org.apache.tomcat.util.http.fileupload.FileUploadBase.maxPartCount",
                "1000"
        );

        SpringApplication.run(
                SpringBootApplicationMain.class,
                args
        );
    }	
}	