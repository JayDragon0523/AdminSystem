package com.smart.AdminService;

import com.smart.AdminDao.ALoginDao;
import com.smart.pojo.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AdministrationService {

    @Resource
    private ALoginDao ALoginDao ;


    //检查管理员登陆
   public Administrator aLoginCheck(String account, String password){
        Administrator a = ALoginDao.findByAccount(account);
        if(a!=null && a.getPswd().equals(password))
            return a;
        else
            return null;
    }



}
