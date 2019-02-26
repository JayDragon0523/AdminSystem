package com.first.smr.Controller;

import com.first.smr.CommonResult;
import com.first.smr.POJO.Visitor;
import com.first.smr.Service.VisitorService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.math.BigInteger;

@RestController
@RequestMapping("/visitor")
public class VisitorController {
    @Resource
    VisitorService visitorService;

    //发送验证码
    @RequestMapping(value = "/sendMess",method = RequestMethod.GET)
    public CommonResult sendMess(String phone)
    {
        return visitorService.sendMessage(phone);
    }

    //注册
    @RequestMapping(value="/regist",method= RequestMethod.POST)
    public CommonResult regist(Visitor v)
    {
        return visitorService.regist(v);
    }

    //历史与会人员
    @RequestMapping(value = "/getPersonFromHistory",method = RequestMethod.GET)
    public CommonResult getPersonFromHistory(BigInteger visitor_id)
    {
        return visitorService.getPersonFromHistory(visitor_id);
    }

}
