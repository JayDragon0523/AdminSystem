package com.first.smr.Service;

import com.first.smr.DAO.AppointmentDAO;
import com.first.smr.DAO.PlaceDAO;
import com.first.smr.DAO.ScheduleDAO;
import com.first.smr.POJO.Appointment;
import com.first.smr.POJO.Schedule;
import com.first.smr.ScheduleConfig;
import com.first.smr.Util.SMRUtil;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Configuration
public class AdjustService {
    @Resource
    AppointmentDAO appointmentDAO;
    @Resource
    PlaceDAO placeDAO;
    @Resource
    ScheduleDAO scheduleDAO;


    //定时自适应
    @Scheduled(cron="0 0 2 ? * 1")
    public void adjust()
    {
        //自适应检索优先级
        System.out.println("自适应之前：");
        printConfig();
        adjustPriority("A");
        adjustPriority("B");
        adjustPriority("C");
        adjustPriority("D");
        adjustPriority("E");
        adjustPriority("F");
        //自适应时间段
        adjustSchedule();
        System.out.println("自适应之后：");
        printConfig();

    }

    //自适应检索优先级
    private void adjustPriority(String type)
    {
        List<Character> temp= appointmentDAO.getAppointmentOrderByType(type);
        String temp1= SMRUtil.getPriority(type);
        String priority=temp1;
        String temp2="";
        for(int i=0;i<temp.size();i++) {
            System.out.println("test:"+temp.get(i));
            temp2+=temp.get(i);
            if (priority.indexOf(temp.get(i)) != -1)
                temp1 = deleteString(temp1, temp.get(i));
        }
        priority=temp2+temp1;
        setPriority(type,priority);
    }


    //自适应会议室时间段
    @Transactional
    protected void adjustSchedule()
    {
        Date now=new Date();
        List<Appointment> appointmentList=appointmentDAO.findByStartTimeAfter(now);
        ScheduleConfig.sSchedule=appointmentDAO.getMinDuration("A","B");
        ScheduleConfig.mSchedule=appointmentDAO.getMinDuration("C","D");
        ScheduleConfig.lSchedule=appointmentDAO.getMinDuration("E","F");
        ScheduleConfig.schedule1.clear();
        ScheduleConfig.schedule2.clear();
        ScheduleConfig.schedule3.clear();
        SMRUtil.setScheduleList("短时");
        SMRUtil.setScheduleList("中时");
        SMRUtil.setScheduleList("长时");
        setSchedule();
        for(Appointment appointment:appointmentList)
        {
            String start=SMRUtil.getSchedule(appointment.getStartTime(),appointment.getType());
            String end=SMRUtil.getSchedule(appointment.getEndTime(),appointment.getType());
            scheduleDAO.updateStateForAppointmentById(appointment.getPlace_id(),start,end);
        }


    }


    public static String deleteString(String str, char delChar){
        String delStr = "";
        for (int i = 0; i < str.length(); i++) {
            if(str.charAt(i) != delChar){
                delStr += str.charAt(i);
            }
        }
        return delStr;
    }

    //设置会议室时间段
    private void setSchedule()
    {
        List<String> type1=new ArrayList<String>();
        List<String> type2=new ArrayList<String>();
        List<String> type3=new ArrayList<String>();
        type1.add("A");
        type1.add("B");
        type2.add("C");
        type2.add("D");
        type3.add("E");
        type3.add("F");
        List<BigInteger> placeIdList1=placeDAO.getPlaceIdByType(type1);
        List<BigInteger> placeIdList2=placeDAO.getPlaceIdByType(type2);
        List<BigInteger> placeIdList3=placeDAO.getPlaceIdByType(type3);
        saveSchedule(placeIdList1,ScheduleConfig.schedule1);
        saveSchedule(placeIdList2,ScheduleConfig.schedule2);
        saveSchedule(placeIdList3,ScheduleConfig.schedule3);

    }

    //保存会议室时间段
    @Transactional
    protected void saveSchedule(List<BigInteger> placeIdList, List<String> scheduleList)
    {
        for(int i=0;i<placeIdList.size();i++)
        {
            for(int j=0;j<scheduleList.size();j++)
            {
                Schedule temp=new Schedule(placeIdList.get(i),scheduleList.get(j),"空闲",false);
                scheduleDAO.save(temp);
            }
        }
    }

    //设置检索优先级
    private static void setPriority(String type,String priority)
    {
        switch (type)
        {
            case "A": {
                ScheduleConfig.priorityA=priority;
                break;
            }
            case "B": {
                ScheduleConfig.priorityB=priority ;
                break;
            }
            case "C": {
                ScheduleConfig.priorityC=priority;
                break;
            }
            case "D": {
                ScheduleConfig.priorityD=priority;
                break;
            }
            case "E": {
                ScheduleConfig.priorityE=priority;
                break;
            }
            case "F": {
                ScheduleConfig.priorityF=priority;
                break;
            }
        }
    }

    private void printConfig()
    {
        System.out.println("priorityA:"+ScheduleConfig.priorityA);
        System.out.println("priorityB:"+ScheduleConfig.priorityB);
        System.out.println("priorityC:"+ScheduleConfig.priorityC);
        System.out.println("priorityD:"+ScheduleConfig.priorityD);
        System.out.println("priorityE:"+ScheduleConfig.priorityE);
        System.out.println("priorityF:"+ScheduleConfig.priorityF);
        System.out.println("-----------------------------------------------");
        System.out.println("Schedule--短时");
        System.out.println("    时间片：");
        System.out.println(ScheduleConfig.sSchedule);
        for(String temp:ScheduleConfig.schedule1)
            System.out.println(temp);
        System.out.println("Schedule--中时");
        System.out.println("    时间片：");
        System.out.println(ScheduleConfig.mSchedule);
        for(String temp:ScheduleConfig.schedule2)
            System.out.println(temp);
        System.out.println("Schedule--长时");
        System.out.println("    时间片：");
        System.out.println(ScheduleConfig.lSchedule);
        for(String temp:ScheduleConfig.schedule3)
            System.out.println(temp);
        System.out.println("----------------------------------------------");



    }
}
