package com.first.smr.Controller;

import com.arcsoft.face.FaceFeature;
import com.arcsoft.face.FaceInfo;
import com.arcsoft.face.FaceSimilar;
import com.arcsoft.face.enums.ImageFormat;
import com.first.smr.CommonResult;
import com.first.smr.DAO.*;
import com.first.smr.FaceEngineConfig;
import com.first.smr.ImageInfo;
import com.first.smr.POJO.*;
import com.first.smr.Service.*;
import com.first.smr.POJO.Staff;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.io.File;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static com.first.smr.Util.ImageUtil.getRGBData;

@RestController
public class TestController {
    @Resource
    private ScheduleDAO scheduleDAO;
    @Resource
    private ConferenceMessDAO conferenceMessDAO;
    @Resource
    private StaffService staffService;
    @Resource
    private FaceService faceService;
    @Resource
    private AdjustService adjustService;
    @Resource
    private AppointmentService appointmentService;
    @Resource
    private VisitorService visitorService;
    @Resource
    private PlaceService placeService;
    @Resource
    private StaffDAO staffDAO;
    @Resource
    private PlaceDAO placeDAO;
    @Resource
    private AppointmentDAO appointmentDAO;

    @RequestMapping("/testStaffALogin")
    public CommonResult testStaffALogin()
    {
        String jobnum="39627";
        String pswd="J7O";
        return staffService.accountLogin(jobnum, pswd);
    }

    @RequestMapping("/testStaffRegist")
    @Transactional
    public CommonResult testStaffRegist()
    {
        Staff s=new Staff();
        s.setName("宁缺");
        s.setPhone("158690283947");
        s.setJobnum("35655");
        s.setPswd("1234");
        s.setCompany("Apple");
        s.setDepartment("销售");
        s.setId_num("51132119981052432");
        return staffService.regist(s);
    }

    @RequestMapping("/{identity}/testGetPlace")
    public CommonResult testGetPlace(@PathVariable("identity")String identity)
    {
       CommonResult result=new CommonResult();
        Place place=new Place();
        place.setAddress("浙江工业大学");
        place.setCapacity(20);
        place.setName("广A201");
        result.setData(place);
        return placeService.getPlaceMess(identity,BigInteger.valueOf(1));
    }

    @RequestMapping("/testJson")
    public CommonResult testJson()
    {
        CommonResult result=new CommonResult();
        List<RecommendResult> test=new ArrayList<RecommendResult>();
        RecommendResult R=new RecommendResult();
        RecommendResult R1=new RecommendResult();

       Recommend r=new Recommend();
       Recommend r1=new Recommend();
       r.setId(BigInteger.valueOf(1));
       r.setName("学堂");
       r.setAddress("书院后山");
       r.setIntroduction("学习的地方");
       r.setIntroduction("不能毁坏书桌");
       r.setDevice("书桌");
       r.setType("A");
       r.setCapacity(20);
       r1.setId(BigInteger.valueOf(2));
        r1.setName("教室");
        r1.setAddress("书院后山");
        r1.setIntroduction("学习的地方");
        r1.setIntroduction("不能毁坏书桌");
        r1.setDevice("书桌");
        r1.setType("B");
        r1.setCapacity(20);
       List<Recommend> test1=new ArrayList<Recommend>();
        List<Recommend> test2=new ArrayList<Recommend>();
       test1.add(r);
       test1.add(r1);
       test2.add(r);
       test2.add(r1);
       R.setRecommends(test1);
       R.setMessage("最优推荐");
       R1.setRecommends(test2);
       R1.setMessage("以下会议室在该时间之前存在会议，若会议未按时结束，请点击申请预留，系统将会为你分配预留会议室");
       test.add(R);
         test.add(R1);
         result.setMsg("获取可用会议室成功");
         result.setData(test);
       return result;
    }

    @RequestMapping("/{identity}/testGetAppointment")
    public CommonResult testGetAppointment(@PathVariable("identity")String identity)
    {
       // CommonResult result=new CommonResult();

            return appointmentService.getAppointment(BigInteger.valueOf(1),identity);

    }
/*
    @RequestMapping("/testSchedule")
    @Transactional
    public CommonResult testSchedule()
    {
        CommonResult result=new CommonResult();
        List<BigInteger> id=scheduleDAO.findReserveId();
        try {
            scheduleDAO.updateStateForReserveById(id);
            result.setMsg("yeah");
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setMsg("damn it!");
        }
        return result;
    }
*/
    @RequestMapping("/{identity}/testAppointment")
    @Transactional
    public CommonResult testAppointment(@PathVariable("identity")String identity)
    {
        Appointment a=new Appointment();
        List<Attendees> attendees=new ArrayList<Attendees>();
        Attendees attendees1=new Attendees(BigInteger.valueOf(17),"君陌");
        attendees1.setIdentity(identity);
        Attendees attendees2=new Attendees(BigInteger.valueOf(18),"宁缺");
        attendees2.setIdentity(identity);
        attendees.add(attendees1);
        attendees.add(attendees2);
        //a.setType("A");
        a.setCompanyId(BigInteger.valueOf(1));
        a.setIntroduction("讨论辩题");
        a.setOrderer_id(BigInteger.valueOf(1));
        a.setPlace_id(BigInteger.valueOf(1));
        a.setPlace_name("广A201");
        a.setDuration(30);
        SimpleDateFormat formattter1 = new SimpleDateFormat("HH:mm");
        try {
            Date d=null;
            d=formattter1.parse("19:00");
            Timestamp temp=new Timestamp(d.getTime());
            a.setStartTime(temp);
            d=formattter1.parse("19:30");
            temp.setTime(d.getTime());
            a.setEndTime(temp);
            a.setAttendees(attendees);

        } catch (ParseException e) {
            e.printStackTrace();
        }
        return appointmentService.appointment(identity,a);
    }

    @RequestMapping("/testCancelAppointment")
    public CommonResult testCancelAppointment()
    {
        return   appointmentService.cancelAppointment(BigInteger.valueOf(14));
    }

    @RequestMapping("/testSendMess")
    public CommonResult testSendMess()
    {
        return visitorService.sendMessage("15869028397");
    }

    @RequestMapping("/{identity}/testAddAttendee")
    public CommonResult testAddAttendee(@PathVariable("identity")String identity)
    {
       List<Attendees> attendeesList=new ArrayList<Attendees>();
        Attendees attendees=new Attendees(BigInteger.valueOf(3),"Alonzo2022");
        attendeesList.add(attendees);
        BigInteger meeting_id=BigInteger.valueOf(2);
        return appointmentService.addAttendPerson(identity,meeting_id,attendeesList);
    }

    @RequestMapping("/{identity}/testRecommend")
    public CommonResult testRecommend(@PathVariable("identity")String identity)
    {
        return placeService.getRecommendList(identity,"9:00","9:30",30,20);
    }

    @RequestMapping("/testGetPerson")
    public CommonResult testGetPerson()
    {
        return staffService.getPersonFromHistory(BigInteger.valueOf(2));
    }

    @RequestMapping("/{identity}/testGetRecently")
    public CommonResult testGetRecently(@PathVariable("identity")String identity)
    {
        return appointmentService.getRecently(identity,BigInteger.valueOf(2));
    }
    private int plusHundred(Float value) {
        BigDecimal target = new BigDecimal(value);
        BigDecimal hundred = new BigDecimal(100f);
        return target.multiply(hundred).intValue();

    }

    @RequestMapping("/{identity}/testGetHistory")
    public CommonResult testGetHistory(@PathVariable("identity")String identity)
    {
        return appointmentService.getHistory(identity,BigInteger.valueOf(1));
    }

    @RequestMapping("/testAddFace")
    @Transactional
    public CommonResult testFace()
    {
        CommonResult result=new CommonResult();
        ImageInfo imageInfo = getRGBData(new File("C:\\Users\\lenovo\\Pictures\\0dc81228b9e0780361824296d446ee20b847417e19d43-i143f3_fw658.jpg"));
       // ImageInfo imageInfo= ImageUtil.getRGBData(inputStream);
        //人脸检测
        try {
            if(imageInfo==null)
            {
                result.setStatus(500);
                result.setMsg("参数错误，请重新拍摄");
            }
            List<FaceInfo> faceInfoList = new ArrayList<FaceInfo>();
            FaceEngineConfig.faceEngine.detectFaces(imageInfo.getRgbData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList);
            //提取人脸特征
            FaceFeature faceFeature = new FaceFeature();
            FaceEngineConfig.faceEngine.extractFaceFeature(imageInfo.getRgbData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList.get(0), faceFeature);
            staffDAO.addFaceInfo(faceFeature.getFeatureData(), BigInteger.valueOf( 2));
            result.setMsg("人脸认证成功");
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("人脸认证失败");
        }
        return result;

    }

    @RequestMapping("/testFaceLogin")
    public CommonResult testFaceLogin()
    {
        CommonResult result=new CommonResult();

        ImageInfo imageInfo = getRGBData(new File("C:\\Users\\lenovo\\Pictures\\Camera Roll\\1474269840121.jpeg"));
        // ImageInfo imageInfo= ImageUtil.getRGBData(inputStream);
        //人脸检测
        try {
            List<FaceInfo> faceInfoList = new ArrayList<FaceInfo>();
            FaceEngineConfig.faceEngine.detectFaces(imageInfo.getRgbData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList);
            //提取人脸特征
            FaceFeature targetFaceFeature = new FaceFeature();
            FaceEngineConfig.faceEngine.extractFaceFeature(imageInfo.getRgbData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList.get(0), targetFaceFeature);
            FaceFeature sourceFaceFeature = new FaceFeature();
            byte[] faceFeature = null;
            faceFeature = staffDAO.getOne(BigInteger.valueOf(1)).getFace_info();
           // System.out.println("TESTFACELENGTHLLLL:"+faceFeature.length);
            if (faceFeature==null)
                result.setMsg("请先完成人脸认证");
            else {
                sourceFaceFeature.setFeatureData(faceFeature);
                FaceSimilar similar = new FaceSimilar();
                FaceEngineConfig.faceEngine.compareFaceFeature(sourceFaceFeature, targetFaceFeature, similar);
                if (plusHundred(similar.getScore()) > FaceEngineConfig.passRate) {
                    result.setMsg("人脸验证通过");
                    result.setData(plusHundred(similar.getScore()));
                }
                else
                    result.setMsg("无法识别人脸信息，请重试");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("人脸登录失败");
        }
        return result;
    }

    @RequestMapping("/test")
    public CommonResult test(String testV)
    {
        CommonResult result=new CommonResult();
        SimpleDateFormat formattter1 = new SimpleDateFormat("HH:mm");
        Date now=new Date();
        try {
          // result.setData(appointmentDAO.findByOrderer_idAndStarttimeBefore(BigInteger.valueOf(1),now));
           System.out.println("TESTVVVVVVVVVVVV:"+testV);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("failed");
        }
        return result;
    }

}
