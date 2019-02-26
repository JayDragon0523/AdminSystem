package com.first.smr.Util;


import com.first.smr.ScheduleConfig;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class SMRUtil {

    public SMRUtil() {
    }

    //计算当前会议类型
    public String getConferenceType(int duration, int capacity) {
        String type = "0";
        if (duration < ScheduleConfig.sduration && capacity > ScheduleConfig.capacity)
            type = "A";
        else if (duration < ScheduleConfig.sduration && capacity <= ScheduleConfig.capacity)
            type = "B";
        if (duration >= ScheduleConfig.sduration && duration < ScheduleConfig.mduration && capacity > ScheduleConfig.capacity)
            type = "C";
        else if (duration >= ScheduleConfig.sduration && duration < ScheduleConfig.mduration && capacity <= ScheduleConfig.capacity)
            type = "D";
        if (duration >= ScheduleConfig.mduration && capacity > ScheduleConfig.capacity)
            type = "E";
        else if (duration >= ScheduleConfig.mduration && capacity <= ScheduleConfig.capacity)
            type = "F";
        return type;
    }

    //计算检索优先级顺序
    public static String getPriority(String type) {
        String priority = "";
        switch (type) {
            case "A": {
                priority = ScheduleConfig.priorityA;
                break;
            }
            case "B": {
                priority =ScheduleConfig.priorityB;
                break;
            }
            case "C": {
                priority = ScheduleConfig.priorityC;
                break;
            }
            case "D": {
                priority = ScheduleConfig.priorityD;
                break;
            }
            case "E": {
                priority = ScheduleConfig.priorityE;
                break;
            }
            case "F": {
                priority = ScheduleConfig.priorityF;
                break;
            }
        }
        return priority;
    }

    //返回开始时间所在时间段
    public static String getSchedule(Date time,String type) {
        String startSchedule= "";
        int index=-1;
        /*
        System.out.println("startTime:"+ScheduleConfig.startTime);
        System.out.println("nowTime:"+time.getTime());
        System.out.println("index:"+(time.getTime()-ScheduleConfig.startTime));
        */
        try
        {
            if(type.equals("A")||type.equals("B"))
            {
                index= (int) ((time.getTime()-ScheduleConfig.startTime)/(ScheduleConfig.sSchedule*60*1000));
                startSchedule=ScheduleConfig.schedule1.get(index);
            }
            else if(type.equals("C")||type.equals("D"))
            {
                index=(int) ((time.getTime()-ScheduleConfig.startTime)/(ScheduleConfig.mSchedule*60*1000));
                startSchedule= ScheduleConfig.schedule2.get(index);
            }
            else if(type.equals("E")||type.equals("F"))
            {
                index= (int) ((time.getTime()-ScheduleConfig.startTime)/(ScheduleConfig.lSchedule*60*1000));
                startSchedule=ScheduleConfig.schedule3.get(index);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
         }
        return startSchedule;
    }

    //返回开始时间段的上一时间段
    public String getLastSchedule(Date time,String type) {

        String lastSchedule = "";
        int index=-1;
        if(type.equals("A")||type.equals("B"))
        {
            index= (int) ((time.getTime()-ScheduleConfig.startTime)/(ScheduleConfig.sSchedule*60*1000))-1;
            lastSchedule=ScheduleConfig.schedule1.get(index);
            if(index<0)
                lastSchedule=ScheduleConfig.schedule1.get(0);
        }
        else if(type.equals("C")||type.equals("D"))
        {
            index= (int) ((time.getTime()-ScheduleConfig.startTime)/(ScheduleConfig.mSchedule*60*1000))-1;
            lastSchedule=ScheduleConfig.schedule2.get(index);
            if(index<0)
                lastSchedule=ScheduleConfig.schedule2.get(0);
        }
        else if(type.equals("E")||type.equals("F"))
        {
            index= (int) ((time.getTime()-ScheduleConfig.startTime)/(ScheduleConfig.lSchedule*60*1000))-1;
            lastSchedule=ScheduleConfig.schedule3.get(index);
            if(index<0)
                lastSchedule=ScheduleConfig.schedule3.get(0);
        }

        return lastSchedule;
    }

    //计算会议室时间段
    public static  void setScheduleList(String type) {
        try {
            Long temp = ScheduleConfig.startTime;
            Long endt = ScheduleConfig.endTime;

            for (; temp < endt; ) {
                Date temp1 = new Date(temp);
               // System.out.println("time:"+temp);
                if(type.equals("短时"))
                {
                    temp = temp + ScheduleConfig.sSchedule * 60 * 1000;
                    ScheduleConfig.schedule1.add(ScheduleConfig.formattter1.format(temp1));
                }
                else if(type.equals("中时"))
                {
                    temp = temp + ScheduleConfig.mSchedule * 60 * 1000;
                    ScheduleConfig.schedule2.add(ScheduleConfig.formattter1.format(temp1));
                }
                else if(type.equals("长时"))
                {
                    temp=temp+ScheduleConfig.lSchedule*60*1000;
                    ScheduleConfig.schedule3.add(ScheduleConfig.formattter1.format(temp1));
                }
                //System.out.println(ScheduleConfig.formattter1.format(temp1));
                //System.out.println(formattter1.format(temp2));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }



}
