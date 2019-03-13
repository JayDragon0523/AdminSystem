package com.first.smr.Service;

import com.first.smr.CommonResult;
import com.first.smr.DAO.PlaceDAO;
import com.first.smr.DAO.VisitorDAO;
import com.first.smr.DAO.VisitorScheduleDAO;
import com.first.smr.POJO.Visitor;
import com.first.smr.POJO.VisitorSchedule;
import com.first.smr.Util.RandomUtil;
import com.first.smr.Util.SendUtil;
import org.omg.CORBA.COMM_FAILURE;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.io.IOException;
import java.math.BigInteger;
import java.util.List;

@Service
@RequestMapping("/visitor")
public class VisitorService {
    @Resource
    VisitorDAO visitorDAO;
    @Resource
    PlaceDAO placeDAO;
    @Resource
    VisitorScheduleDAO visitorScheduleDAO;
    @Transactional

    //账号登录
    public CommonResult accountLogin(String phone,String pswd)
    {
        CommonResult result=new CommonResult();
        try
        {
           Visitor temp=visitorDAO.findByPhone(phone);
            if(temp==null)
            {
                result.setMsg("用户不存在或账号错误");
                result.setResult("fail");
            }
            else
            {
                result.setMsg("用户存在");
                if(temp.getFace_info()!=null)
                    temp.setIdentified(true);
                else
                    temp.setIdentified(false);
                result.setData(temp);
            }
            /*
            else if(temp.getPswd().equals(pswd))
            {
                result.setMsg("登录成功");
                result.setData(temp.getId());
            }
            else
            {
                result.setMsg("密码错误");
                result.setResult("fail");
            }*/

        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("登录失败");
            result.setResult("fail");
        }
        return result;
    }

    //修改密码
    @Transactional
    public CommonResult alterPass(BigInteger visitorId,String oldPass,String newPass)
    {
        CommonResult result=new CommonResult();
        try
        {
            if(newPass==null)
            {
                result.setMsg("密码不能为空");
                result.setResult("fail");
            }
            else {
                Visitor visitor = visitorDAO.getOne(visitorId);
                if (visitor.getPswd().equals(oldPass)) {
                    visitor.setPswd(newPass);
                    result.setMsg("修改密码成功");
                } else {
                    result.setMsg("原密码不正确");
                    result.setResult("fail");
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setMsg("修改密码失败");
            result.setResult("fail");
            result.setStatus(500);
        }
        return  result;
    }

    //游客注册
    @Transactional
    public CommonResult regist(Visitor v)
    {
        CommonResult result=new CommonResult();
        try
        {
            Visitor temp=visitorDAO.findByPhone(v.getPhone());
            if(temp==null)
            {
                visitorDAO.save(v);
                result.setMsg("注册成功");
                result.setData(v.getId());
            }
            else
            {
                result.setResult("fail");
                result.setMsg("该账号已注册，请勿重复注册");
            }
        }
        catch (Exception e)
        {
            System.out.println(e);
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("注册失败");
        }
        return result;
    }

    /*
    获取历史与会人员
    @param id   预约人的唯一标识
     */
    public CommonResult getPersonFromHistory(BigInteger staffId)
    {
        CommonResult result=new CommonResult();
        try {
            List<BigInteger> meeting_id = visitorDAO.findMeetingIdByStaff_id(staffId);
            List<BigInteger> staff_id = visitorDAO.findStaffIdByMeetingId(meeting_id);
            List<Visitor> person = visitorDAO.getPersonFromHistory(staff_id);
            result.setMsg("获取与会人员成功");
            result.setData(person);
        }
        catch (Exception e)
        {
            result.setResult("fail");
            result.setStatus(500);
            result.setMsg("获取与会人员失败");

        }
        return result;
    }

    //发送短信验证码
    public CommonResult sendMessage(String phone)
    {
        CommonResult result=new CommonResult();
        int random= RandomUtil.getRandNum();
        SendUtil send=new SendUtil();
        try {
            send.sendMess(phone,random);
            result.setMsg("信息发送成功");
            result.setData(random);
        } catch (IOException e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("信息发送失败");
            result.setResult("fail");
        }
        return result;
    }

    //获取场地时间表
    public CommonResult getPlaceSchedule(BigInteger placeId)
    {
        CommonResult result=new CommonResult();
        try{
            List<VisitorSchedule> visitorScheduleList=visitorScheduleDAO.findAllByPlaceId(placeId);
            if(visitorScheduleList.size()==0)
            {
                result.setMsg("该商家未设置开放时间");
                result.setResult("fail");
            }
            else {
                result.setMsg("获取场地时间表成功");
                result.setData(visitorScheduleList);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取场地时间表失败");
            result.setResult("fail");
        }
        return result;
    }


}
