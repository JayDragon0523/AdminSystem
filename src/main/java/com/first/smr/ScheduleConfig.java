package com.first.smr;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class ScheduleConfig {
    public static int sduration=30;//短时会议时长
    public static int mduration=60;//中时会议时长
    public static int sSchedule=20;//短时会议时间片
    public static int mSchedule=20;//中时会议时间片
    public static int lSchedule=20;//长时会议时间片
    public static int capacity=30;//会议室容量
    public static String start="08:00";//会议室开放时间
    public static String end="21:00";//会议室停止开放时间
    public static String priorityA="ACEBDF";//A类型会议检索优先级
    public static String priorityB="BADCFE";//B类型会议检索优先级
    public static String priorityC="CEADFB";//C类型会议检索优先级
    public static String priorityD="DCFEBA";//D类型会议检索优先级
    public static String priorityE="EDBFCA";//E类型会议检索优先级
    public static String priorityF="FEDCBA";//F类型会议检索优先级

    public static List<String> schedule1=new ArrayList<String>();//短时会议时间段
    public static List<String> schedule2=new ArrayList<String>();//中时会议时间段
    public static List<String> schedule3=new ArrayList<String>();//长时会议时间段
    public static SimpleDateFormat formattter1 = new SimpleDateFormat("HH:mm");
    public static long startTime;//会议室开放时间（毫秒）
    public static long endTime;//会议室停止开放时间（毫秒）
    static {
        try {
            endTime = formattter1.parse(ScheduleConfig.end).getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
    static {
        try {
            startTime = formattter1.parse(ScheduleConfig.start).getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
    public ScheduleConfig(){}

}
