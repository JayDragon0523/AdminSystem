package com.first.smr.Service;

import com.first.smr.CommonResult;
import com.first.smr.DAO.CompanyDAO;
import com.first.smr.POJO.Company;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CompanyService {
    @Resource
    CompanyDAO companyDAO;

    public CommonResult register(Company company){
        CommonResult result = new CommonResult();
        try {
            Company cFind=companyDAO.findByName(company.getName());
            if(cFind==null){
                company.setState("申请中");
                companyDAO.save(company);
            }
            else{
                result.setStatus(500);
                result.setMsg("该公司名已存在");
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }
}
