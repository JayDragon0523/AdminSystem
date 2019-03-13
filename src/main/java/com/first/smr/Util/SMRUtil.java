package com.first.smr.Util;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.first.smr.DAO.ScheduleDAO;
import com.first.smr.POJO.Schedule;
import com.first.smr.POJO.ScheduleConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Component
public class SMRUtil {

    public SMRUtil() {
    }

    public RedisTemplate getRedisTemplate() {
        return redisTemplate;
    }

    public void setRedisTemplate(RedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public ScheduleDAO getScheduleDAO() {
        return scheduleDAO;
    }

    public void setScheduleDAO(ScheduleDAO scheduleDAO) {
        this.scheduleDAO = scheduleDAO;
    }

    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private ScheduleDAO scheduleDAO;

    //计算当前会议类型
    public String getConferenceType(ScheduleConfig scheduleConfig,int duration, int capacity) {

        String type = "0";
        if (duration < scheduleConfig.getSduration() && capacity > scheduleConfig.getCapacity())
            type = "A";
        else if (duration < scheduleConfig.getSduration() && capacity <= scheduleConfig.getCapacity())
            type = "B";
        if (duration >= scheduleConfig.getSduration()&& duration < scheduleConfig.getMduration() && capacity > scheduleConfig.getCapacity())
            type = "C";
        else if (duration >= scheduleConfig.getSduration() && duration < scheduleConfig.getMduration() && capacity <= scheduleConfig.getCapacity())
            type = "D";
        if (duration >= scheduleConfig.getMduration() && capacity > scheduleConfig.getCapacity())
            type = "E";
        else if (duration >= scheduleConfig.getMduration() && capacity <= scheduleConfig.getCapacity())
            type = "F";
        return type;
    }

    //计算检索优先级顺序
    public static String getPriority(ScheduleConfig scheduleConfig,String type) {
        String priority = "";
        switch (type) {
            case "A": {
                priority = scheduleConfig.getPriorityA();
                break;
            }
            case "B": {
                priority =scheduleConfig.getPriorityB();
                break;
            }
            case "C": {
                priority = scheduleConfig.getPriorityC();
                break;
            }
            case "D": {
                priority = scheduleConfig.getPriorityD();
                break;
            }
            case "E": {
                priority = scheduleConfig.getPriorityE();
                break;
            }
            case "F": {
                priority = scheduleConfig.getPriorityF();
                break;
            }
        }
        return priority;
    }

    //返回时间所在时间段
    public static String getSchedule(ScheduleConfig scheduleConfig,Date time,String type) {
        String startSchedule= "";
        int index=-1;
        try
        {
            if(type.equals("A")||type.equals("B"))
            {
                index= (int) ((time.getTime()-scheduleConfig.getStartTime())/(scheduleConfig.getsSchedule()*60*1000));
                startSchedule=scheduleConfig.getScheduleS().get(index);
            }
            else if(type.equals("C")||type.equals("D"))
            {
                index=(int) ((time.getTime()-scheduleConfig.getStartTime())/(scheduleConfig.getmSchedule()*60*1000));
                startSchedule= scheduleConfig.getScheduleM().get(index);
            }
            else if(type.equals("E")||type.equals("F"))
            {
                index= (int) ((time.getTime()-scheduleConfig.getStartTime())/(scheduleConfig.getlSchedule()*60*1000));
                startSchedule=scheduleConfig.getScheduleL().get(index);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return startSchedule;
    }

    //返回时间所在时间段的上一时间段
    public String getLastSchedule(ScheduleConfig scheduleConfig,Date time,String type) {

        String lastSchedule = "";
        int index=-1;
        if(type.equals("A")||type.equals("B"))
        {
            index= (int) ((time.getTime()-scheduleConfig.getStartTime())/(scheduleConfig.getsSchedule()*60*1000))-1;
            lastSchedule=scheduleConfig.getScheduleS().get(index);
            if(index<0)
                lastSchedule=scheduleConfig.getScheduleS().get(0);
        }
        else if(type.equals("C")||type.equals("D"))
        {
            index= (int) ((time.getTime()-scheduleConfig.getStartTime())/(scheduleConfig.getmSchedule()*60*1000))-1;
            lastSchedule=scheduleConfig.getScheduleM().get(index);
            if(index<0)
                lastSchedule=scheduleConfig.getScheduleM().get(0);
        }
        else if(type.equals("E")||type.equals("F"))
        {
            index= (int) ((time.getTime()-scheduleConfig.getStartTime())/(scheduleConfig.getlSchedule()*60*1000))-1;
            lastSchedule=scheduleConfig.getScheduleL().get(index);
            if(index<0)
                lastSchedule=scheduleConfig.getScheduleL().get(0);
        }

        return lastSchedule;
    }

    //计算会议室时间段
    public void setScheduleList(ScheduleConfig scheduleConfig,String type) {
        try {

            Long temp = scheduleConfig.getStartTime();
            Long endt = scheduleConfig.getEndTime();
            for (; temp < endt; ) {
                Date temp1 = new Date(temp);
                // System.out.println("time:"+temp);
                if(type.equals("短时"))
                {
                    temp = temp + scheduleConfig.getsSchedule() * 60 * 1000;
                    scheduleConfig.getScheduleS().add(scheduleConfig.getFormattter1().format(temp1));
                }
                else if(type.equals("中时"))
                {
                    temp = temp + scheduleConfig.getmSchedule() * 60 * 1000;
                    scheduleConfig.getScheduleM().add(scheduleConfig.getFormattter1().format(temp1));
                }
                else if(type.equals("长时"))
                {
                    temp=temp+scheduleConfig.getlSchedule()*60*1000;
                    scheduleConfig.getScheduleL().add(scheduleConfig.getFormattter1().format(temp1));
                }

                //System.out.println(ScheduleConfig.formattter1.format(temp1));
                //System.out.println(formattter1.format(temp2));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //根据公司编号从redis缓存中获取相关会议室参数
    public  ScheduleConfig getScheduleConfigFromRedis(BigInteger companyId)
    {
        ObjectMapper objectMapper=new ObjectMapper();
        ScheduleConfig scheduleConfig;
        String key="ScheduleConfig:"+companyId.toString();
        scheduleConfig=objectMapper.convertValue(redisTemplate.opsForValue().get(key),ScheduleConfig.class);
        return scheduleConfig;
    }

    //根据公司编号将相关会议室参数 存入redis缓存
    public  void setScheduleConfigToRedis(BigInteger companyId,ScheduleConfig scheduleConfig)
    {
        String key="ScheduleConfig:"+companyId.toString();
        redisTemplate.opsForValue().set(key,scheduleConfig);
    }

    public void printConfig(ScheduleConfig scheduleConfig)
    {
        System.out.println("priorityA:"+scheduleConfig.getPriorityA());
        System.out.println("priorityB:"+scheduleConfig.getPriorityB());
        System.out.println("priorityC:"+scheduleConfig.getPriorityC());
        System.out.println("priorityD:"+scheduleConfig.getPriorityD());
        System.out.println("priorityE:"+scheduleConfig.getPriorityE());
        System.out.println("priorityF:"+scheduleConfig.getPriorityF());
        System.out.println("-----------------------------------------------");
        System.out.println("Schedule--短时");
        System.out.println("    时间片：");
        System.out.println(scheduleConfig.getsSchedule());
        for(String temp:scheduleConfig.getScheduleS())
            System.out.println(temp);
        System.out.println("Schedule--中时");
        System.out.println("    时间片：");
        System.out.println(scheduleConfig.getmSchedule());
        for(String temp:scheduleConfig.getScheduleM())
            System.out.println(temp);
        System.out.println("Schedule--长时");
        System.out.println("    时间片：");
        System.out.println(scheduleConfig.getlSchedule());
        for(String temp:scheduleConfig.getScheduleL())
            System.out.println(temp);
        System.out.println("----------------------------------------------");



    }

    public  String getDayOfWeek(Date date)
    {
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
        String[] weekDays = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
        Calendar cal = Calendar.getInstance(); // 获得一个日历
        try {
            cal.setTime(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1; // 指示一个星期中的某天。
        if (w < 0)
            w = 0;
        return weekDays[w];
    }

    //保存会议室时间段
    @Transactional
    public void saveSchedule(List<BigInteger> placeIdList, List<String> scheduleList, BigInteger companyId, String dayOfWeek)
    {
        for(int i=0;i<placeIdList.size();i++)
        {
            for(int j=0;j<scheduleList.size();j++)
            {
                Schedule temp=new Schedule(companyId,placeIdList.get(i),scheduleList.get(j),"空闲",false,dayOfWeek);
                scheduleDAO.save(temp);
            }
        }
    }
}
