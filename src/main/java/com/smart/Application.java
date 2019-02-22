package com.smart;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.transaction.annotation.EnableTransactionManagement;

//@Configuration 相当于把该类作为spring的xml配置文件中的<beans>，作用为：配置spring容器(应用上下文)
//@ComponentScan 会自动扫描包路径下面的所有@Controller、@Service、@Repository、@Component 的类
//@EnableAutoConfiguration
@SpringBootApplication
@EnableTransactionManagement
public class Application extends SpringBootServletInitializer {//①继承Servlet初始化器
    public static void main (String []args) throws Exception{
        SpringApplication.run(Application.class,args);
    }

    //②重写configure方法
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
        return application.sources(Application.class);
    }
}
