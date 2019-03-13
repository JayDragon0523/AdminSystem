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

    //账号登录
    public CommonResult accountLogin(String company,String jobnum,String pswd)
    {
        CommonResult result=new CommonResult();
        try
        {
            Staff temp=null;
            if(staffDAO.existsStaffByCompany(company)) {
                temp = staffDAO.findByJobnumAndCompany(jobnum, company);
                if (temp == null) {
                    result.setMsg("账号不存在或账号错误");
                    result.setResult("fail");
                } else if (!temp.getPswd().equals(pswd)) {
                    result.setMsg("密码错误");
                    result.setResult("fail");
                } else {
                    result.setMsg("登录成功");
                    if(temp.getFace_info()!=null)
                        temp.setIdentified(true);
                    else
                        temp.setIdentified(false);
                    result.setData(temp);
                }
            }
            else
            {
                result.setResult("fail");
                result.setMsg("匹配不到该公司，请确认输入正确");
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

    //账号登录
    public Staff login(String company,String jobnum,String pswd)
    {
        Staff temp=null;
        CommonResult result=new CommonResult();
        try
        {
            if(staffDAO.existsStaffByCompany(company)) {
                temp = staffDAO.findByJobnumAndCompany(jobnum, company);
                if (temp == null) {
                    result.setMsg("账号不存在或账号错误");
                    result.setResult("fail");
                } else if (!temp.getPswd().equals(pswd)) {
                    result.setMsg("密码错误");
                    result.setResult("fail");
                    return null;
                } else {
                    result.setMsg("登录成功");
                    if(temp.getFace_info()!=null)
                        temp.setIdentified(true);
                    else
                        temp.setIdentified(false);
                    result.setData(temp);
                }
            }
            else
            {
                result.setResult("fail");
                result.setMsg("匹配不到该公司，请确认输入正确");
                return null;
            }
        }
        catch(Exception e)
        {
            result.setStatus(500);
            result.setMsg("登录失败！");
            result.setResult("fail");
            return null;
        }
        return temp;
    }

    //修改密码
    @Transactional
    public CommonResult alterPass(BigInteger staffId,String oldPass,String newPass)
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
                Staff staff = staffDAO.getOne(staffId);
                if (staff.getPswd().equals(oldPass)) {
                    staff.setPswd(newPass);
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

    //注册
    @Transactional
    public CommonResult regist(Staff s)
    {
        CommonResult result=new CommonResult();
        Staff temp=staffDAO.findByJobnumAndCompany(s.getJobnum(),s.getCompany());
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
