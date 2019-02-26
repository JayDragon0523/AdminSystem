package com.first.smr.Controller;

import com.first.smr.CommonResult;
import com.first.smr.Service.StaffService;
import com.first.smr.POJO.Staff;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.math.BigInteger;

@RestController
@RequestMapping("/staff")
public class StaffController {
    @Resource
    StaffService staffService;
    //账号登录
    @RequestMapping(value = "/alogin",method = RequestMethod.GET)
    public CommonResult accountLogin(String jobnum, String pswd)
    {
       return staffService.accountLogin(jobnum,pswd);
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
