package com.first.smr.POJO;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "scheduleconfig")
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
public class ScheduleConfig implements Serializable {

    private static final long serialVersionUID = -8440124395167218491L;
    public interface  externalView{}
    public interface internalView extends externalView{}
    @Id
    @Column(name = "company_id")
    private BigInteger companyId;
    @Column(name = "s_duration")
    private   int sduration=30;//短时会议时长
    @Column(name = "m_duration")
    private   int mduration=60;//中时会议时长
    @Column(name = "s_schedule")
    private   int sSchedule=20;//短时会议时间片
    @Column(name="m_schedule")
    private   int mSchedule=20;//中时会议时间片
    @Column(name = "l_schedule")
    private   int lSchedule=20;//长时会议时间片
    private int capacity=30;//会议室容量
    private   String start="08:00";//会议室开放时间
    private   String end="21:00";//会议室停止开放时间
    private   String priorityA="ACEBDF";//A类型会议检索优先级
    private   String priorityB="BADCFE";//B类型会议检索优先级
    private   String priorityC="CEADFB";//C类型会议检索优先级
    private   String priorityD="DCFEBA";//D类型会议检索优先级
    private   String priorityE="EDBFCA";//E类型会议检索优先级
    private   String priorityF="FEDCBA";//F类型会议检索优先级
    @Transient
    private   List<String> scheduleS=new ArrayList<String>();//短时会议时间段
    @Transient
    private   List<String> scheduleM=new ArrayList<String>();//中时会议时间段
    @Transient
    private   List<String> scheduleL=new ArrayList<String>();//长时会议时间段
    @Transient
    private   SimpleDateFormat formattter1 = new SimpleDateFormat("HH:mm");

    @Column(name="start_time")
    private   long startTime;//会议室开放时间（毫秒）
    @Column(name="end_time")
    private   long endTime;//会议室停止开放时间（毫秒）

    @JsonView(externalView.class)
    public BigInteger getCompanyId() {
        return companyId;
    }
    public void setCompanyId(BigInteger companyId) {
        this.companyId = companyId;
    }

    @JsonView(externalView.class)
    public int getSduration() {
        return sduration;
    }
    public void setSduration(int sduration) {
        this.sduration = sduration;
    }

    @JsonView(externalView.class)
    public int getMduration() {
        return mduration;
    }
    public void setMduration(int mduration) {
        this.mduration = mduration;
    }

    @JsonView(externalView.class)
    public int getsSchedule() {
        return sSchedule;
    }
    public void setsSchedule(int sSchedule) {
        this.sSchedule = sSchedule;
    }

    @JsonView(externalView.class)
    public int getmSchedule() {
        return mSchedule;
    }
    public void setmSchedule(int mSchedule) {
        this.mSchedule = mSchedule;
    }

    @JsonView(externalView.class)
    public int getlSchedule() {
        return lSchedule;
    }
    public void setlSchedule(int lSchedule) {
        this.lSchedule = lSchedule;
    }

    @JsonView(externalView.class)
    public int getCapacity() {
        return capacity;
    }
    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    @JsonView(externalView.class)
    public String getStart() {
        return start;
    }
    public void setStart(String start) {
        this.start = start;
    }

    @JsonView(externalView.class)
    public String getEnd() {
        return end;
    }
    public void setEnd(String end) {
        this.end = end;
    }

    @JsonView(internalView.class)
    public String getPriorityA() {
        return priorityA;
    }
    public void setPriorityA(String priorityA) {
        this.priorityA = priorityA;
    }

    @JsonView(internalView.class)
    public String getPriorityB() {
        return priorityB;
    }
    public void setPriorityB(String priorityB) {
        this.priorityB = priorityB;
    }

    @JsonView(internalView.class)
    public String getPriorityC() {
        return priorityC;
    }
    public void setPriorityC(String priorityC) {
        this.priorityC = priorityC;
    }

    @JsonView(internalView.class)
    public String getPriorityD() {
        return priorityD;
    }
    public void setPriorityD(String priorityD) {
        this.priorityD = priorityD;
    }

    @JsonView(internalView.class)
    public String getPriorityE() {
        return priorityE;
    }
    public void setPriorityE(String priorityE) {
        this.priorityE = priorityE;
    }

    @JsonView(internalView.class)
    public String getPriorityF() {
        return priorityF;
    }
    public void setPriorityF(String priorityF) {
        this.priorityF = priorityF;
    }

    @JsonView(internalView.class)
    public List<String> getScheduleS() {
        return scheduleS;
    }
    public void setScheduleS(List<String> scheduleS) {
        this.scheduleS = scheduleS;
    }

    @JsonView(internalView.class)
    public List<String> getScheduleM() {
        return scheduleM;
    }
    public void setScheduleM(List<String> scheduleM) {
        this.scheduleM = scheduleM;
    }

    @JsonView(internalView.class)
    public List<String> getScheduleL() {
        return scheduleL;
    }
    public void setScheduleL(List<String> scheduleL) {
        this.scheduleL = scheduleL;
    }

    public SimpleDateFormat getFormattter1() {
        return formattter1;
    }
    public void setFormattter1(SimpleDateFormat formattter1) {
        this.formattter1 = formattter1;
    }

    @JsonView(internalView.class)
    public long getStartTime() {
        return startTime;
    }
    public void setStartTime(long startTime) {
        this.startTime = startTime;
    }

    @JsonView(internalView.class)
    public long getEndTime() {
        return endTime;
    }
    public void setEndTime(long endTime) {
        this.endTime = endTime;
    }

    public ScheduleConfig()
    {
        try {
            this.startTime=formattter1.parse(start).getTime();
            this.endTime = formattter1.parse(end).getTime();
        }
        catch (ParseException e) {
            e.printStackTrace();
        }
    }
    public ScheduleConfig(BigInteger companyId)
    {
        this.companyId=companyId;
        try {
            this.startTime=formattter1.parse(start).getTime();
            this.endTime = formattter1.parse(end).getTime();
        }
        catch (ParseException e) {
            e.printStackTrace();
        }
    }
    public String check()
    {
        String result="right";
        if(getCompanyId()==null)
            result= "companyId不能为空";
        if(getSduration()==0)
            result= "sduration不能为空";
        if(getMduration()==0)
            result= "mduration不能为空";
        if(getmSchedule()==0)
            result= "mschedule不能为空";
        if(getsSchedule()==0)
            result= "sschedule不能为空";
        if(getlSchedule()==0)
            result= "lschedule不能为空";
        if(getCapacity()==0)
            result= "capacity不能为空";
        if(getPriorityA()==null)
            result= "priorityA不能为空";
        if(getPriorityB()==null)
            result= "priorityB不能为空";
        if(getPriorityC()==null)
            result= "priorityC不能为空";
        if(getPriorityD()==null)
            result= "priorityD不能为空";
        if(getPriorityE()==null)
            result= "priorityE不能为空";
        if(getPriorityF()==null)
            result= "priorityF不能为空";
        if(getStartTime()==0||getEndTime()==0)
        {
            try {
                this.startTime=formattter1.parse(start).getTime();
                this.endTime = formattter1.parse(end).getTime();
            } catch (ParseException e) {
                e.printStackTrace();
            }

        }
        return  result;
    }
}
