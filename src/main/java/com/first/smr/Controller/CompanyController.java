package com.first.smr.Controller;

import com.first.smr.CommonResult;
import com.first.smr.POJO.Company;
import com.first.smr.Service.CompanyService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/company")
public class CompanyController {
    @Resource
    CompanyService companyService;

    // 公司注册
    // 必须参数 name,address,register_num,head_name,head_phone  可选参数  introduction
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public CommonResult register(Company company){
        return companyService.register(company);
    }
}
