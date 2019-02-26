package com.first.smr.Interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import javax.annotation.Resource;

@Configuration
public class InterceptorConfig extends WebMvcConfigurerAdapter {
    @Resource
    private AdminLoginInterceptor sloginInterceptor;
    public void addInterceptors(InterceptorRegistry registry) {
      //  registry.addInterceptor(sloginInterceptor).addPathPatterns("/stu/**").excludePathPatterns("/index.html").excludePathPatterns("/loginCheck.html");
       // registry.addInterceptor(tLoginInterceptor).addPathPatterns("/**").addPathPatterns("/**/**").excludePathPatterns("/stu/**").excludePathPatterns("/index.html").excludePathPatterns("/loginCheck.html").excludePathPatterns("/student");
        super.addInterceptors(registry);
    }
}
