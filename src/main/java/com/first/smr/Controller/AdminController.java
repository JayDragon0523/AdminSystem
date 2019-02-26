package com.first.smr.Controller;

import com.alibaba.fastjson.JSON;
import com.first.smr.POJO.*;
import com.first.smr.CommonResult;
import com.first.smr.Service.AdminService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@RestController
@RequestMapping("/admin")
public class AdminController {
    @Resource
    AdminService admin;

    /*
    管理员分两种，系统管理员和组织管理员，在写接口的时候为了区分两种管理员，用不同的前缀来标识
    系统管理员： 前缀 S ，表示System
    组织管理员： 前缀 O ，表示Organization
     */

    // 系统管理员账号密码登录
    @RequestMapping(value = "/SLogin",method = RequestMethod.POST)
    public CommonResult SLogin(Admin a, HttpServletRequest request) { return admin.SLogin(a,request); }

    // 组织管理员账号密码登录
    // 必须参数 account,pswd,companyId
    @RequestMapping(value = "/OLogin",method = RequestMethod.POST)
    public CommonResult OLogin(Admin a, HttpServletRequest request)
    {
        return admin.OLogin(a,request);
    }

    // 组织管理员注册
    @RequestMapping(value = "/ORegister",method = RequestMethod.POST)
    public CommonResult ORegister(Admin a){
        return admin.ORegister(a);
    }

    /************************************/
    /*          系统管理员管理          */
    /************************************/

    // 系统管理员增加系统管理员
    // 必须参数 account,pswd,id_num,phone
    @RequestMapping(value = "/SAddSAdmin", method = RequestMethod.POST)
    public CommonResult SAddSAdmin(Admin a){
        return admin.SAddSAdmin(a);
    }

    // 系统管理员修改个人信息
    // 必须参数 account,pswd,id_num,phone
    @RequestMapping(value = "/SUpdateSelf", method = RequestMethod.POST)
    public CommonResult SUpdateSelf(Admin a, HttpServletRequest request){
        return admin.SUpdateSelf(a,request);
    }

    // 系统管理员注销个人账号
    // 无必须参数
    @RequestMapping(value = "/SDeleteSelf", method = RequestMethod.POST)
    public CommonResult SDeleteSelf(HttpServletRequest request){
        return admin.SDeleteSelf(request);
    }

    /************************************/
    /*          组织管理员管理          */
    /************************************/

    // 系统管理员审核组织管理员
    @RequestMapping(value = "/SReviewOAdmin",method = RequestMethod.POST)
    public CommonResult SReviewOAdmin(Admin a){ return admin.SReviewOAdmin(a); }

    // 系统管理员分页查询所有组织管理员信息
    @RequestMapping(value = "/SFindOAdmins",method = RequestMethod.GET)
    public CommonResult SFindOAdmins(@RequestParam(defaultValue = "0") int pagenum, @RequestParam(defaultValue = "5") int size, @RequestParam(required = false) String account){ return admin.SFindOAdmins(pagenum,size,account); }

    // 系统管理员增加组织管理员
    // 必须参数 id_num,account,pswd,phone,companyId,company_name
    @RequestMapping(value = "/SAddOAdmin", method = RequestMethod.POST)
    public CommonResult SAddOAdmin(Admin a){
        return admin.SAddOAdmin(a);
    }

    // 0
    // 必须参数 id,id_num,account,pswd,phone
    @RequestMapping(value = "/SUpdateOAdmin", method = RequestMethod.POST)
    public CommonResult SUpdateOAdmin(Admin a){
        return admin.SUpdateOAdmin(a);
    }

    // 系统管理员删除组织管理员
    // 必须参数 id
    @RequestMapping(value = "/SDeleteOAdmin", method = RequestMethod.POST)
    public CommonResult SDeleteOAdmin(Admin a){
        return admin.SDeleteOAdmin(a);
    }

    // 组织管理员增加本公司组织管理员
    // 必须参数 id_num,account,pswd,phone
    @RequestMapping(value = "/OAddOAdmin", method = RequestMethod.POST)
    public CommonResult OAddOAdmin(Admin a, HttpServletRequest request){
        return admin.OAddOAdmin(a,request);
    }

    // 组织管理员修改个人信息
    // 必须参数 id_num,account,pswd,phone
    @RequestMapping(value = "/OUpdateSelf", method = RequestMethod.POST)
    public CommonResult OUpdateSelf(Admin a, HttpServletRequest request){
        return admin.OUpdateSelf(a, request);
    }

    // 组织管理员注销自身账号
    // 无必须参数
    @RequestMapping(value = "/ODeleteSelf", method = RequestMethod.POST)
    public CommonResult ODeleteSelf(HttpServletRequest request){
        return admin.ODeleteSelf(request);
    }

    /************************************/
    /*             游客管理             */
    /************************************/

    // 系统管理员分页查询所有游客信息
    @RequestMapping(value = "/SFindVisitors",method = RequestMethod.GET)
    public CommonResult SFindVisitors(@RequestParam(defaultValue = "0") int pagenum, @RequestParam(defaultValue = "5") int size, @RequestParam(required = false) String name){ return admin.SFindVisitors(pagenum,size,name); }

    // 系统管理员增加游客
    // 必须参数 phone,name,pswd,id_num  可选参数 account sex credit_num
    @RequestMapping(value = "/SAddVisitor", method = RequestMethod.POST)
    public CommonResult SAddVisitor(Visitor visitor){
        return admin.SAddVisitor(visitor);
    }

    // 系统管理员修改游客
    // 必须参数 id,phone,pswd,name,id_num  可选参数 account sex credit_num
    @RequestMapping(value = "/SUpdateVisitor", method = RequestMethod.POST)
    public CommonResult SUpdateVisitor(Visitor visitor){
        return admin.SUpdateVisitor(visitor);
    }

    // 系统管理员删除游客
    // 必须参数 id
    @RequestMapping(value = "/SDeleteVisitor", method = RequestMethod.POST)
    public CommonResult SDeleteVisitor(Visitor visitor){
        return admin.SDeleteVisitor(visitor);
    }

    /************************************/
    /*             公司管理             */
    /************************************/

    // 系统管理员分页查询所有公司信息
    @RequestMapping(value = "/SFindCompanies",method = RequestMethod.GET)
    public CommonResult SFindCompanies(@RequestParam(defaultValue = "0") int pagenum, @RequestParam(defaultValue = "5") int size, @RequestParam(required = false) String name){ return admin.SFindCompanies(pagenum,size,name); }

    // 系统管理员增加公司
    // 必须参数 name,address,register_num,head_name,head_phone  可选参数  introduction
    @RequestMapping(value = "/SAddCompany", method = RequestMethod.POST)
    public CommonResult SAddCompany(Company company){
        return admin.SAddCompany(company);
    }

    // 系统管理员修改公司
    // 必须参数 id,name,address,register_num,head_name,head_phone  可选参数  introduction
    @RequestMapping(value = "/SUpdateCompany", method = RequestMethod.POST)
    public CommonResult SUpdateCompany(Company company){
        return admin.SUpdateCompany(company);
    }

    // 系统管理员删除公司
    // 必须参数 id
    @RequestMapping(value = "/SDeleteCompany", method = RequestMethod.POST)
    public CommonResult SDeleteCompany(Company company){
        return admin.SDeleteCompany(company);
    }

    // 系统管理员审核公司
    // 必须参数 id
    @RequestMapping(value = "/SReviewCompany", method = RequestMethod.POST)
    public CommonResult SReviewCompany(Company company){
        return admin.SReviewCompany(company);
    }

    /************************************/
    /*             场地管理             */
    /************************************/

    // 组织管理员分页查询本公司的场地信息
    // 无必须参数
    @RequestMapping(value = "/OFindPlaces",method = RequestMethod.GET)
    public CommonResult OFindPlaces(@RequestParam(defaultValue = "0") int pagenum, @RequestParam(defaultValue = "5") int size, @RequestParam(required = false) String name, HttpServletRequest request){ return admin.OFindPlaces(pagenum, size, name, request); }

    // 组织管理员增加或修改场地
    // 增加必须参数 name,address
    // 修改必须参数 id,name,address
    @RequestMapping(value = "/OAddOrUpdatePlace", method = RequestMethod.POST)
    public CommonResult OAddOrUpdatePlace(Place place, HttpServletRequest request){ return admin.OAddOrUpdatePlace(place, request);}

    // 组织管理员删除场地
    // 必须参数 id
    @RequestMapping(value = "/ODeletePlace", method = RequestMethod.POST)
    public CommonResult ODeletePlace(Place place){ return admin.ODeletePlace(place); }

    /************************************/
    /*             职员管理             */
    /************************************/

    // 组织管理员分页查询本公司的职员信息
    @RequestMapping(value = "/OFindStaffs",method = RequestMethod.GET)
    public CommonResult OFindStaffs(@RequestParam(defaultValue = "0") int pagenum, @RequestParam(defaultValue = "5") int size, @RequestParam(required = false) String name, HttpServletRequest request){ return admin.OFindStaffs(pagenum, size, name, request);}

    // 组织管理员增加或修改职员信息
    // 增加必须参数 department,id_num,jobnum,name,phone,pswd
    // 修改必须参数 id,department,id_num,jobnum,name,phone,pswd
    @RequestMapping(value = "/OAddOrUpdateStaff", method = RequestMethod.POST)
    public CommonResult OAddOrUpdateStaff(Staff staff, HttpServletRequest request){ return admin.OAddOrUpdateStaff(staff, request); }

    // 组织管理员删除职员信息
    // 必须参数 id
    @RequestMapping(value = "/ODeleteStaff", method = RequestMethod.POST)
    public CommonResult ODeleteStaff(Staff staff){
        return admin.ODeleteStaff(staff);
    }

    /************************************/
    /*             预约管理             */
    /************************************/

    // 组织管理员分页查询本公司的预约情况
    @RequestMapping(value = "/OFindAppointments", method = RequestMethod.GET)
    public  CommonResult OFindAppointments(@RequestParam(defaultValue = "0") int pagenum, @RequestParam(defaultValue = "5") int size, @RequestParam(required = false) Date time, HttpServletRequest request){ return admin.OFindAppointments(pagenum, size, time, request);}

    // 组织管理员添加或修改预约信息
    // 增加必须参数 startTime,endTime,place_id,place_name,type,duration
    // 修改必须参数 id,startTime,endTime,place_id,place_name,type,duration
    @RequestMapping(value = "/OAddOrUpdateAppointment", method = RequestMethod.POST)
    public CommonResult OAddOrUpdateAppointment(Appointment appointment, HttpServletRequest request){ return admin.OAddOrUpdateAppointment(appointment, request);}

    // 组织管理员删除预约信息
    // 必须参数 id
    @RequestMapping(value = "/ODeleteAppointment", method = RequestMethod.POST)
    public CommonResult ODeleteAppointment(Appointment appointment){
        return admin.ODeleteAppointment(appointment);
    }

    // 组织管理员审核预约
    // 必须参数 id
    @RequestMapping(value = "/OReviewAppointment", method = RequestMethod.POST)
    public CommonResult OReviewAppointment(Appointment appointment){
        return admin.OReviewAppointment(appointment);
    }

    // 发送验证码短信
    // 必须参数 phone
    @RequestMapping(value = "/sendMess", method = RequestMethod.POST)
    public CommonResult sendMess(String phone){
        return admin.sendMessage(phone);
    }


    //获取公司的部门
    @RequestMapping(value = "/queryDepartmentList", method = RequestMethod.GET)
    public void queryTeachersLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Admin a = (Admin) request.getSession().getAttribute("admin");
        List<Department> resultList = admin.getDepartmentList(a.getCompanyId());
        StringBuffer xml = new StringBuffer("<result>");
        for(int i = 0; i < resultList.size(); i++){
            xml.append("<showDepartList id='").append(i).append("'>");
            xml.append("<Dname>").append(resultList.get(i).getPm().getDepartment_name()).append("</Dname>");
            xml.append("</showDepartList>");
        }
        xml.append("<status>1</status>");
        xml.append("<func>updateDepartmentInformationList()</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    //获取部门职员
    @RequestMapping(value="/department_employee",method = {RequestMethod.GET,RequestMethod.POST})
    public void getJudge(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dname = request.getParameter("dname");
        List<Staff> result =admin.getDepartmentStaff(dname);
        int count = result.size();
        result= Page.Page(result,request.getParameter("page"),request.getParameter("limit"));
        String ret = JSON.toJSONString(result);
        ret="{\"code\":0,\"msg\":\"\",\"count\": "+count+",\"data\":"+ret+"}";
        sendResponse(response,ret);
    }

    private void sendResponse(HttpServletResponse response, String responseText)
            throws ServletException, IOException {
        response.setContentType("text/xml");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(responseText);
    }
}
