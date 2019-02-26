package com.first.smr;
import com.arcsoft.face.EngineConfiguration;
import com.arcsoft.face.FunctionConfiguration;
import com.first.smr.Util.SMRUtil;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

//@Configuration 相当于把该类作为spring的xml配置文件中的<beans>，作用为：配置spring容器(应用上下文)
//@ComponentScan 会自动扫描包路径下面的所有@Controller、@Service、@Repository、@Component 的类
//@EnableAutoConfiguration
@SpringBootApplication
@EnableTransactionManagement
public class Application extends SpringBootServletInitializer {//①继承Servlet初始化器
    public static void main (String []args) throws Exception{
        SpringApplication.run(Application.class,args);
        SMRUtil.setScheduleList("短时");
        SMRUtil.setScheduleList("中时");
        SMRUtil.setScheduleList("长时");
        Date start = null;
        SimpleDateFormat formattter1 = new SimpleDateFormat("HH:mm");
        try {
            start = formattter1.parse("8:30");
            String temp=SMRUtil.getSchedule(start,"A");
            System.out.println(temp);
            // ScheduleConfig.sSchedule=40;
            //SMRUtil.setScheduleList("短时");
            //System.out.println(SMRUtil.getSchedule(formattter1.parse("8:30"),"A"));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        //激活人脸识别引擎
        //  System.out.println("fsdfsfds:"+System.getProperty("java.io.tmpdir"));
        FaceEngineConfig.faceEngine.active(FaceEngineConfig.appId, FaceEngineConfig.sdkKey);
        EngineConfiguration engineConfiguration = EngineConfiguration.builder().functionConfiguration(
                FunctionConfiguration.builder()
                        .supportAge(true)
                        .supportFace3dAngle(true)
                        .supportFaceDetect(true)
                        .supportFaceRecognition(true)
                        .supportGender(true)
                        .build()).build();
        //初始化引擎
        FaceEngineConfig.faceEngine.init(engineConfiguration);
    }

    //②重写configure方法
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
        return application.sources(Application.class);
    }
}
