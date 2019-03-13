package com.first.smr.Controller;

import com.first.smr.CommonResult;
import com.first.smr.Service.StaffService;
import com.first.smr.POJO.Staff;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.annotation.ModelAndViewResolver;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigInteger;

@RestController
@RequestMapping("/staff")
public class StaffController {
    @Resource
    StaffService staffService;
    //账号登录
    @RequestMapping(value = "/alogin",method = RequestMethod.GET)
    public CommonResult accountLogin(String company,String jobnum, String pswd)
    {
        return staffService.accountLogin(company,jobnum,pswd);
    }

    //账号登录
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public ModelAndView staffLogin(String jobnum, String pswd)
    {
        return new ModelAndView("stafflogin");
    }

    //账号登录
    @RequestMapping(value = "/loginCheck")
    public ModelAndView login(String company,String jobnum, String pswd, HttpServletRequest request)
    {
        Staff s = staffService.login(company,jobnum,pswd);
        if(s!=null){
            request.getSession().setAttribute("staff",s);
            request.getSession().setAttribute("staffId",s.getId());
            return new ModelAndView("staffAppointment");
        }
        else
            return new ModelAndView("stafflogin", "error", "用户名或密码错误!");
    }

    //职员注册
    @RequestMapping(value="/regist",method = RequestMethod.POST)
    public CommonResult regist(Staff s)
    {
        return staffService.regist(s);
    }

    //历史与会人员
    @RequestMapping(value = "/getPersonFromHistory",method = RequestMethod.GET)
   public CommonResult getPersonFromHistory(BigInteger staff_id)
   {
        return staffService.getPersonFromHistory(staff_id);
   }

}
