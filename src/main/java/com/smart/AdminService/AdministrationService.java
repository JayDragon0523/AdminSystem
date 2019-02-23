package com.smart.AdminService;

import com.smart.AdminDao.ALoginDao;
import com.smart.AdminDao.DepartmentDao;
import com.smart.AdminDao.StaffDao;
import com.smart.pojo.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AdministrationService {

    @Resource
    private ALoginDao ALoginDao ;
    @Resource
    private DepartmentDao departmentDao ;
    @Resource
    private StaffDao staffDao ;

    //检查管理员登陆
   public Administrator aLoginCheck(String account, String password){
        Administrator a = ALoginDao.findByAccount(account);
        if(a!=null && a.getPswd().equals(password))
            return a;
        else
            return null;
    }

    //获取公司部门列表
    public List<Department> getDepartmentList(String id){
        return departmentDao.find(id);
    }

    //部门职员信息
    public List<Staff> getDepartmentStaff(String dname){
        return staffDao.find(dname);
    }

}
