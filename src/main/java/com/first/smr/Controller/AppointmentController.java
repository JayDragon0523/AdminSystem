package com.first.smr.Controller;

import com.first.smr.CommonResult;
import com.first.smr.POJO.Appointment;
import com.first.smr.POJO.Attendees;
import com.first.smr.Service.AppointmentService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

@RestController
@RequestMapping("/conference")
public class AppointmentController {
    @Resource
    AppointmentService appointmentService;

    //预约会议
    @RequestMapping(value = "/{identity}/appointment",method = RequestMethod.POST)
    public CommonResult appointment(@PathVariable("identity") String identity, Appointment a)
    {
        return appointmentService.appointment(identity,a);
    }

    //取消预约
    @RequestMapping(value="/cancelAppointment",method= RequestMethod.GET)
    public CommonResult cancelAppointment(BigInteger appointmentId)
    {
        return appointmentService.cancelAppointment(appointmentId);
    }

    //添加与会人员
    @RequestMapping(value="/{identity}/addAttendPerson",method = RequestMethod.POST)
    public CommonResult addAttendPerson(@PathVariable("identity") String identity, @RequestParam(value = "meetingId") BigInteger meetingId, List<Attendees> attendees)
    {
        return appointmentService.addAttendPerson(identity,meetingId,attendees);
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


}
