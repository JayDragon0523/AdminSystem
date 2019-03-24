package com.first.smr.Service;

import com.first.smr.CommonResult;
import com.first.smr.DAO.AppointmentDAO;
import com.first.smr.DAO.AttendeesDAO;
import com.first.smr.DAO.ConferenceMessDAO;
import com.first.smr.DAO.ScheduleDAO;
import com.first.smr.POJO.Appointment;
import com.first.smr.POJO.Attendees;
import com.first.smr.POJO.ConferenceMess;
import com.first.smr.POJO.ScheduleConfig;
import com.first.smr.Util.SMRUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class AppointmentService {
    @Resource
    AppointmentDAO appointmentDAO;
    @Resource
    ConferenceMessDAO conferenceMessDAO;
    @Resource
    ScheduleDAO scheduleDAO;
    @Resource
    AttendeesDAO attendeesDAO;
    @Resource
    SMRUtil smrUtil;

    //预约会议
    @Transactional
    public CommonResult appointment(String identity,Appointment a,int capacity)
    {
        CommonResult result=new CommonResult();
        try{
            ScheduleConfig scheduleConfig=smrUtil.getScheduleConfigFromRedis(a.getCompanyId());
            String type=smrUtil.getConferenceType(scheduleConfig,a.getDuration(),capacity);
            SimpleDateFormat formattter1 = new SimpleDateFormat("HH:mm");
            String start=SMRUtil.getSchedule(scheduleConfig, formattter1.parse(a.getStime().substring(11,16)),type);
            String end=SMRUtil.getSchedule(scheduleConfig,formattter1.parse(a.getEtime().substring(11,16)),type);
            a.setType(type);
            a.setOrdererType(identity);
            appointmentDAO.save(a);
            if(a.getAttendees()==null) {
                System.out.println("无历史与会人员");
            }else{
                for (Attendees attendees : a.getAttendees()) {
                    attendees.setAppointmentId(a.getId());
                }
                attendeesDAO.saveAll(a.getAttendees());
            }
            result.setMsg("预约成功");
            result.setData(a.getId());
            String dayOfWeek=smrUtil.getDayOfWeek(a.getStartTime());
            scheduleDAO.updateStateForAppointment(a.getPlace_id(),start,end,a.getCompanyId(),dayOfWeek);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("预约失败");
            result.setResult("fail");
        }
        return result;
    }

    //取消会议
    @Transactional
    public CommonResult cancelAppointment(BigInteger appointmentId)
    {
        CommonResult result=new CommonResult();
        try {
            Appointment a = appointmentDAO.findOne(appointmentId);
            appointmentDAO.delete(a);
            //appointmentDAO.deleteById(appointmentId);
            result.setMsg("取消预约会议成功");
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            System.out.println(e.getMessage());
            result.setMsg("取消预约会议失败");
            result.setResult("fail");
        }
        return result;
    }

    //添加与会人员
    @Transactional
    public CommonResult addAttendPerson(String identity,BigInteger meeting_id, List<Attendees>attendeesList)
    {

        CommonResult result=new CommonResult();
        try {
            for (Attendees attendees: attendeesList) {
                attendees.setAppointmentId(meeting_id);
                attendees.setIdentity(identity);
                attendeesDAO.save(attendees);
            }
            result.setMsg("添加与会人员成功");
            result.setData(meeting_id);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("添加与会人员失败");
            result.setResult("fail");
        }
        return result;
    }

    //查看最近需要出席的会议
    public CommonResult getRecently(String identity,BigInteger personId)
    {
        CommonResult result=new CommonResult();
        try
        {
            List<BigInteger> idList=appointmentDAO.getAppointmentId(personId,"未出席",identity);
            if(idList.size() == 0){
                result.setStatus(500);
                result.setMsg("最近没有需要出席的会议");
                result.setResult("fail");
            }else {
                for (int i = 0; i < idList.size(); i++)
                    System.out.println("TT:" + idList.get(i));
                List<ConferenceMess> recent = conferenceMessDAO.findByAppointmentIdIn(idList);
                result.setMsg("获取最近需要出席的会议成功");
                result.setData(recent);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取最近需要出席的会议失败");
            result.setResult("fail");
        }
        return result;
    }

    //获取已预约会议
    public CommonResult getAppointment(BigInteger personId,String identity)
    {
        CommonResult result=new CommonResult();
        try
        {
            List<Appointment> temp=appointmentDAO.getAppointmentByOrderer_id(personId,identity);
            List<BigInteger> appointmentIdList=new ArrayList<BigInteger>();
            List<ConferenceMess> conferenceMessList;
            for(Appointment appointment:temp)
            {
                Date now=new Date();
                if( appointment.getStartTime().after(now))
                    appointmentIdList.add(appointment.getId());
            }
            if(appointmentIdList.isEmpty())
                result.setMsg("暂无已预约会议");
            else {
                conferenceMessList = conferenceMessDAO.findByAppointmentIdIn(appointmentIdList);
                result.setMsg("获取预约会议成功");
                result.setData(conferenceMessList);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取预约会议失败");
            result.setResult("fail");
        }
        return result;
    }

    //查看历史会议
    public CommonResult getHistory(String identity,BigInteger id)
    {
        CommonResult result=new CommonResult();
        try
        {
            List<BigInteger> idList=appointmentDAO.getAppointmentId(id,"已出席",identity);
            if(idList.size() == 0){
                result.setStatus(500);
                result.setMsg("无历史会议");
                result.setResult("fail");
            }else {
                List<ConferenceMess> history = conferenceMessDAO.findByAppointmentIdIn(idList);
                result.setMsg("获取历史会议成功");
                result.setData(history);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取历史会议失败");
            result.setResult("fail");
        }
        return result;
    }

    //修改会议
    public CommonResult alterConference(Appointment appointment)
    {
        CommonResult result=new CommonResult();
        try {
            appointmentDAO.save(appointment);
            result.setMsg("修改会议信息成功");
            result.setData(appointment.getId());
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("修改会议信息失败");
            result.setResult("fail");
        }
        return result;
    }
}
