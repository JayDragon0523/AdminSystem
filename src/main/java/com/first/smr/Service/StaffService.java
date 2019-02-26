package com.first.smr.Service;

import com.first.smr.CommonResult;
import com.first.smr.DAO.StaffDAO;
import com.first.smr.POJO.Staff;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

@Service
public class StaffService {
    @Resource
    StaffDAO staffDAO;
    @Transactional

    /*登录*/
    //账号登录
    public CommonResult accountLogin(String jobnum,String pswd)
    {
        CommonResult result=new CommonResult();
        try
        {
            Staff temp=staffDAO.findByJobnum(jobnum);
            if(temp==null)
            {
                result.setMsg("用户不存在或账号错误");
                result.setResult("fail");
            }
            else if(!temp.getPswd().equals(pswd))
            {
                result.setMsg("密码错误");
                result.setResult("fail");
            }
            else
            {
                result.setMsg("登录成功");
                result.setData(temp.getId());
            }
        }
        catch(Exception e)
        {
            result.setStatus(500);
            result.setMsg("登录失败！");
            result.setResult("fail");
        }
        return result;
    }



    //注册
    @Transactional
    public CommonResult regist(Staff s)
    {
        CommonResult result=new CommonResult();
        Staff temp=staffDAO.findByJobnum(s.getJobnum());
        try {
            if(temp==null)
            {
                staffDAO.save(s);
                result.setMsg("注册成功");
                result.setData(s.getId());
            }
            else
            {
                result.setMsg("该账号已注册，请勿重复注册");
                result.setResult("fail");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("注册失败");
            result.setResult("fail");
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
            List<BigInteger> meeting_id = staffDAO.findMeetingIdByStaff_id(staffId);
            List<BigInteger> staff_id = staffDAO.findStaffIdByMeetingId(meeting_id);
            List<Staff> person = staffDAO.getPersonFromHistory(staff_id);
            result.setMsg("获取与会人员成功");
            result.setData(person);
        }
        catch (Exception e)
        {
            result.setStatus(500);
            result.setMsg("获取与会人员失败");
            result.setResult("fail");
        }
        return result;
    }
}
