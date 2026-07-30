package com.springboot.config;

import org.springframework.boot.web.embedded.tomcat.TomcatConnectorCustomizer;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.stereotype.Component;

@Component
public class TomcatConfig implements WebServerFactoryCustomizer<TomcatServletWebServerFactory> {

    @Override
    public void customize(TomcatServletWebServerFactory factory) {

        factory.addConnectorCustomizers((TomcatConnectorCustomizer) connector -> {

            connector.setProperty("maxFileCount", "1000");
            connector.setProperty("maxPartCount", "1000");
            connector.setProperty("maxPostSize", "209715200");

            connector.setMaxParameterCount(10000);

            System.out.println("===== TOMCAT MULTIPART CONFIG LOADED =====");
        });
    }
}