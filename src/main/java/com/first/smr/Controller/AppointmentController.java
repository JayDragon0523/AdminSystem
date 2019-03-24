package com.first.smr.Controller;

import com.first.smr.CommonResult;
import com.first.smr.POJO.Appointment;
import com.first.smr.POJO.Attendees;
import com.first.smr.Service.AppointmentService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/conference")
public class AppointmentController {
    @Resource
    AppointmentService appointmentService;

    //预约会议
    @RequestMapping(value = "/{identity}/appointment",method = {RequestMethod.POST,RequestMethod.GET})
    public CommonResult appointment(@PathVariable("identity") String identity,Appointment a,int capacity)
    {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        long startDay = 0; long endDay = 0;
        try {
//            Date dateStart = format.parse(a.getStime());
//            Date datEnd = format.parse(a.getEtime());
//            startDay = (dateStart.getTime());
//            endDay = (datEnd.getTime());
            a.setStartTime(Timestamp.valueOf(a.getStime()));
            a.setEndTime(Timestamp.valueOf(a.getEtime()));
            System.out.println(a.getStartTime());
        }catch (Exception e){
            e.printStackTrace();
        }
        return appointmentService.appointment(identity,a,capacity);
    }

    //取消预约
    @RequestMapping(value="/cancelAppointment",method= RequestMethod.GET)
    public CommonResult cancelAppointment(BigInteger appointmentId,HttpServletResponse response) throws ServletException, IOException {
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<status>1</status>");
        xml.append("<func>cancelSuccess();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
        return appointmentService.cancelAppointment(appointmentId);
    }

    //添加与会人员
    @RequestMapping(value="/{identity}/addAttendPerson",method = {RequestMethod.GET,RequestMethod.POST})
    public CommonResult addAttendPerson(@PathVariable("identity") String identity, @RequestParam(value = "meetingId") BigInteger meetingId, List<Attendees> attendees)
    {
        if(attendees.size()!=0)
            return appointmentService.addAttendPerson(identity,meetingId,attendees);
        else
            return new CommonResult(200,"无与会人员，请直接提交预约");
    }


    //查看近期会议
    @RequestMapping(value="/{identity}/getRecently",method = RequestMethod.GET)
    public CommonResult getRecently(@PathVariable("identity")String identity, BigInteger personId)
    {
        return appointmentService.getRecently(identity,personId);
    }

    //查看历史会议
    @RequestMapping(value="/{identity}/getHistory",method = RequestMethod.GET)
    public CommonResult getHistory(@PathVariable("identity")String identity, BigInteger personId)
    {
        return appointmentService.getHistory(identity,personId);
    }

    //获取已预约会议
    @RequestMapping(value="/{identity}/getAppointment",method = RequestMethod.GET)
    public CommonResult getAppointment( BigInteger personId,@PathVariable("identity")String identity)
    {
       return appointmentService.getAppointment(personId,identity);
    }

    //修改会议
    @RequestMapping(value="/alter",method = RequestMethod.POST)
    public CommonResult alterConference(Appointment appointment)
    {
        return appointmentService.alterConference(appointment);
    }

    private void sendResponse(HttpServletResponse response, String responseText)
            throws ServletException, IOException {
        response.setContentType("text/xml");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(responseText);
    }
}
