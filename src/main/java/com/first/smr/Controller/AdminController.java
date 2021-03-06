package com.first.smr.Controller;

import com.alibaba.fastjson.JSON;
import com.first.smr.POJO.*;
import com.first.smr.CommonResult;
import com.first.smr.Service.AdminService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigInteger;
import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

    //管理员信息更新
    @RequestMapping(value="/updateAdmin",method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView updateAdmin(HttpServletRequest request, Admin a){
        Admin tp = (Admin) request.getSession().getAttribute("OAdmin");
        if(admin.updateAdmin(tp.getAccount(),a)){
            return  null;
        }
        else
            return new ModelAndView("errorPage","error","管理员信息更新失败");
    }
    //组织管理员和发布管理员密码更新
    @RequestMapping(value="/OAdminSafe",method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView OAdminSafe(HttpServletRequest request, Admin a){
        Admin b = (Admin) request.getSession().getAttribute("OAdmin");
        if (admin.adminSafe(b.getAccount(), a)) {
            return null;
        } else
            return new ModelAndView("errorPage", "error", "管理员密码修改失败");
    }

    //系统管理员密码更新
    @RequestMapping(value="/SAdminSafe",method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView SAdminSafe(HttpServletRequest request, Admin a){
        Admin b = (Admin) request.getSession().getAttribute("SAdmin");
        if(admin.adminSafe(b.getAccount(),a)) {
            return null;
        }
        else
            return new ModelAndView("errorPage","error","管理员密码修改失败");
    }
    //人脸信息的上传
    @RequestMapping(value="/UploadFaceInfo",method= RequestMethod.POST)
    public ModelAndView testUploadFile(HttpServletRequest request, MultipartHttpServletRequest multiReq) throws IOException {
        MultipartFile mf = multiReq.getFile("file");
        String strPath = "D:\\masterSpring\\AdminSystem\\src\\main\\webapp\\data\\faceInfo\\";
        if (mf.isEmpty()) {
            File f = new File(strPath + "\\" + "无新图片" + ".txt");
            try {
                FileWriter fw = new FileWriter(f);
                fw.write("未上传文件");
                fw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            try {
                File ee = new File(strPath + "\\admin");
                if (!ee.exists())
                    ee.mkdirs();
                mf.transferTo(new File(strPath + "\\" + mf.getOriginalFilename()));
                String str = strPath + "\\" + mf.getOriginalFilename();
                byte[] faceInfo = str.getBytes();
                admin.updateFaceInfo(request, faceInfo);
                return null;
            } catch (Exception e) {
                e.printStackTrace();
                return new ModelAndView("errorPage", "error", "人脸信息更新失败");
            }
        }
        return null;
    }
    //获取具体职员
    @RequestMapping(value="/theStaff",method = {RequestMethod.GET,RequestMethod.POST})
    public void getTheStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jobnum = request.getParameter("jobnum");
        Admin a = (Admin) request.getSession().getAttribute("admin");
        Staff s =admin.getTheStaff(jobnum);
        int count = 1;
        List<Staff> result = new ArrayList<>();
        result.add(s);
        result= Page.Page(result,request.getParameter("page"),request.getParameter("limit"));
        String ret = JSON.toJSONString(result);
        ret="{\"code\":0,\"msg\":\"\",\"count\": "+count+",\"data\":"+ret+"}";
        sendResponse(response,ret);
    }
    //将职员信息存入session
    @RequestMapping(value="/setStaff",method = {RequestMethod.GET,RequestMethod.POST})
    public void setStaff(String jobnum,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        Staff s =admin.getTheStaff(jobnum);
        request.getSession().setAttribute("staff",s);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<staffInfo>");
        xml.append("<id>").append(s.getId()).append("</id>");
        xml.append("<name>").append(s.getName()).append("</name>");
        xml.append("<sex>").append(s.getSex()).append("</sex>");
        xml.append("<companyId>").append(s.getCompanyId()).append("</companyId>");
        xml.append("<jobnum>").append(s.getJobnum()).append("</jobnum>");
        xml.append("<department>").append(s.getDepartment()).append("</department>");
        xml.append("<pswd>").append(s.getPswd()).append("</pswd>");
        xml.append("<id_num>").append(s.getCompanyId()).append("</id_num>");
        xml.append("<phone>").append(s.getPhone()).append("</phone>");
        xml.append("<face_info>").append(s.getFace_info()).append("</face_info>");
        xml.append("</staffInfo>");
        xml.append("<status>1</status>");
        xml.append("<func>setStaffSuccess();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    // 系统管理员账号密码登录
    @RequestMapping(value = "/SLogin",method = RequestMethod.POST)
    public CommonResult SLogin(Admin a, HttpServletRequest request) { return admin.SLogin(a,request); }

    // 组织管理员账号密码登录
    // 必须参数 account,pswd,companyId
    @RequestMapping(value = "/OLogin",method = RequestMethod.POST)
        public  ModelAndView OLogin(Admin a, HttpServletRequest request)
    {
        admin.OLogin(a,request);
        return new ModelAndView("compadmin");
    }

    // 组织管理员注册
    @RequestMapping(value = "/ORegister",method = RequestMethod.POST)
    public CommonResult ORegister(Admin a){
        return admin.ORegister(a);
    }

    /************************************/
    /*          系统管理员管理          */
    /************************************/

    //将组织管理员信息存入session
    @RequestMapping(value="/setOAdmin",method = {RequestMethod.GET,RequestMethod.POST})
    public void setOAdmin(BigInteger id,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        Admin a = admin.getTheAdmin(id);
        request.getSession().setAttribute("admin",a);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<status>1</status>");
        xml.append("<func>setOAdminSuccess();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    // 系统管理员分页查询所有系统管理员信息
    @RequestMapping(value = "/SFindSAdmins",method = RequestMethod.GET)
    public CommonResult SFindSAdmins(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int limit, @RequestParam(required = false) String account){
        return admin.SFindSAdmins(page,limit,account);
    }
    // 系统管理员增加系统管理员
    // 必须参数 account,pswd,id_num,phone
    @RequestMapping(value = "/SAddSAdmin")
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
    @RequestMapping(value = "/SReviewOAdmin",method = {RequestMethod.GET,RequestMethod.POST})
    public CommonResult SReviewOAdmin(Admin a){ return admin.SReviewOAdmin(a); }

    // 系统管理员拒绝组织管理员申请
    @RequestMapping(value = "/SDisagreeOAdmin",method = {RequestMethod.GET,RequestMethod.POST})
    public CommonResult SDisagreeOAdmin(Admin a){
        return admin.SDisagreeOAdmin(a);
    }

    // 系统管理员分页查询所有组织管理员信息
    @RequestMapping(value = "/SFindOAdmins",method = RequestMethod.GET)
    public CommonResult SFindOAdmins(@RequestParam(defaultValue = "0") int pagenum, @RequestParam(defaultValue = "5") int size, @RequestParam(required = false) String account){ return admin.SFindOAdmins(pagenum,size,account); }

    // 系统管理员增加组织管理员
    // 必须参数 id_num,account,pswd,phone,companyId
    @RequestMapping(value = "/SAddOAdmin")
    public CommonResult SAddOAdmin(Admin a){
        return admin.SAddOAdmin(a);
    }

    // 组织管理员申请
    // 必须参数 id_num,account,pswd,phone,companyId
    @RequestMapping(value = "/OAdminApply")
    public ModelAndView OAdminApply(Admin a){
        if(admin.OAdminApply(a))
            return null;
        else
            return new ModelAndView("errorPage","error","增加组织管理员信息失败");
    }

    // 0
    // 必须参数 id,id_num,account,pswd,phone
    @RequestMapping(value = "/SUpdateOAdmin", method = RequestMethod.POST)
    public CommonResult SUpdateOAdmin(Admin a){
        return admin.SUpdateOAdmin(a);
    }

    // 系统管理员删除组织管理员
    // 必须参数 id
    @RequestMapping(value = "/SDeleteOAdmin")
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

    //将组织管理员信息存入session
    @RequestMapping(value="/setVisitor",method = {RequestMethod.GET,RequestMethod.POST})
    public void setVisitor(BigInteger id,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        Visitor v = admin.getTheVisitor(id);
        request.getSession().setAttribute("visitor",v);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<status>1</status>");
        xml.append("<func>setVisitorSuccess();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    // 系统管理员分页查询所有游客信息
    @RequestMapping(value = "/SFindVisitors",method = RequestMethod.GET)
    public CommonResult SFindVisitors(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int limit, @RequestParam(required = false) String name){ return admin.SFindVisitors(page,limit,name); }

    // 系统管理员增加游客
    // 必须参数 phone,name,pswd,id_num  可选参数 account sex credit_num
    @RequestMapping(value = "/SAddVisitor", method = RequestMethod.POST)
    public void SAddVisitor(Visitor visitor){
        admin.SAddVisitor(visitor);
    }

    // 系统管理员修改游客
    // 必须参数 id,phone,pswd,name,id_num  可选参数 account sex credit_num
    @RequestMapping(value = "/SUpdateVisitor")
    public CommonResult SUpdateVisitor(Visitor visitor){
        return admin.SUpdateVisitor(visitor);
    }

    // 系统管理员删除游客
    // 必须参数 id
    @RequestMapping(value = "/SDeleteVisitor")
    public CommonResult SDeleteVisitor(Visitor visitor){
        return admin.SDeleteVisitor(visitor);
    }

    // 组织管理员分页查询所有游客评价
    @RequestMapping(value = "/OFindEvaluations",method = RequestMethod.GET)
    public CommonResult OFindEvaluation(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int limit,HttpServletRequest request){
        return admin.OFindEvaluations(page,limit,request);
    }

    // 组织管理员分页查询所有游客评价
    @RequestMapping(value = "/OFindStaffEvaluations",method = RequestMethod.GET)
    public CommonResult OFindStaffEvaluations(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int limit,HttpServletRequest request){
        return admin.OFindStaffEvaluations(page,limit,request);
    }

    // 组织管理员删除游客评价
    // 必须参数 id
    @RequestMapping(value = "/ODeleteEvaluation")
    public CommonResult ODeleteEvaluation(BigInteger id){
        return admin.ODeleteEvaluation(id);
    }

    /************************************/
    /*             公司管理             */
    /************************************/

    // 公司申请
    // 必须参数 name,address,register_num,head_name,head_phone,introduction
    @RequestMapping(value = "/companyApply")
    public  void companyApply(Company company,HttpServletRequest request){
        SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
        BigInteger bigInteger = null;
        try {
            if(company.getOpen_time() == null) company.setOpen_time(new Time(df.parse("08:00:00").getTime()));
            if(company.getClose_time() == null) company.setClose_time(new Time(df.parse("18:00:00").getTime()));
            admin.companyApply(company);
            bigInteger = admin.getTheComanpy(company.getName());
            request.getSession().setAttribute("companyId",bigInteger);
            System.out.println(bigInteger);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    // 系统管理员分页查询所有公司申请
    @RequestMapping(value = "/SFindApplyCompanies",method = RequestMethod.GET)
    public CommonResult SFindApplyCompanies(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int limit, @RequestParam(required = false) String name){
        return admin.SFindApplyCompanies(page,limit,name);
    }

    // 系统管理员分页查询所有公司信息
    @RequestMapping(value = "/SFindCompanies",method = RequestMethod.GET)
    public CommonResult SFindCompanies(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int limit, @RequestParam(required = false) String name){ return admin.SFindCompanies(page,limit,name); }

    // 系统管理员增加公司
    // 必须参数 name,address,register_num,head_name,head_phone  可选参数  introduction
    @RequestMapping(value = "/SAddCompany", method = RequestMethod.POST)
    public  ModelAndView SAddCompany(Company company){
        if (admin.SAddCompany(company))
            return null;
        else
            return new ModelAndView("errorPage","error","添加公司信息失败");
    }

    // 系统管理员修改公司
    // 必须参数 id,name,address,register_num,head_name,head_phone  可选参数  introduction
    @RequestMapping(value = "/SUpdateCompany", method = RequestMethod.POST)
    public CommonResult SUpdateCompany(Company company){
        return admin.SUpdateCompany(company);
    }

    // 系统管理员拒绝申请
    // 必须参数 id
    @RequestMapping(value = "/SDisagreeApply",method = {RequestMethod.GET,RequestMethod.POST})
    public void SDisagreeApply(Company company,HttpServletResponse response) throws ServletException, IOException {
        admin.SDisagreeApply(company);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<status>1</status>");
        xml.append("<func>opSuccess();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    // 系统管理员删除公司
    // 必须参数 id
    @RequestMapping(value = "/SDeleteCompany",method = {RequestMethod.GET,RequestMethod.POST})
    public void SDeleteCompany(Company company){
        admin.SDeleteCompany(company);
    }

    // 系统管理员审核公司
    // 必须参数 id
    @RequestMapping(value = "/SReviewCompany", method = {RequestMethod.GET,RequestMethod.POST})
    public void SReviewCompany(Company company,HttpServletResponse response) throws ServletException, IOException {
        admin.SReviewCompany(company);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<status>1</status>");
        xml.append("<func>opSuccess();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    //将组织信息存入session
    @RequestMapping(value="/setCompany",method = {RequestMethod.GET,RequestMethod.POST})
    public void setCompany(BigInteger id,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        Company c =admin.getTheCompany(id);
        request.getSession().setAttribute("company",c);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<status>1</status>");
        xml.append("<func>setCompanySuccess();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    //将注册时的公司信息存入session
    @RequestMapping(value="/setCompanyInfoTemp",method = {RequestMethod.GET,RequestMethod.POST})
    public void setCompanyInfoTemp(Company c, HttpServletRequest request, HttpServletResponse response, MultipartRequest multiReq) throws ServletException, IOException {
        request.getSession().setAttribute("company",c);
//        MultipartFile mf = multiReq.getFile("file");
//        String strPath = "..//..//..//..//..//..//webapp//data//companyImage//" + c.getId() + c.getName();
//        if (mf.isEmpty()) {
//            File f = new File(strPath + "//" + "无营业执照上传" + ".txt");
//            try {
//                FileWriter fw = new FileWriter(f);
//                fw.write("未上传文件");
//                fw.close();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        } else {
//            File ee = new File(strPath);
//            if (!ee.exists())
//                ee.mkdirs();
//            mf.transferTo(new File(strPath+"//"+mf.getOriginalFilename()));
//        }
    }

    // 提交注册时session中的公司信息
    // 必须参数 name,address,register_num,head_name,head_phone  可选参数  introduction
    @RequestMapping(value = "/UploadCompanyInfo")
    public  ModelAndView UploadCompanyInfo(HttpServletRequest request){
        Company company = (Company) request.getSession().getAttribute("company");
        if (admin.SAddCompany(company))
            return null;
        else
            return new ModelAndView("errorPage","error","添加公司信息失败");
    }


    /************************************/
    /*             场地管理             */
    /************************************/

    // 发布管理员增加场地
    // 必须参数 name,address,type  可选参数 introduction,device,instruction,cost,capacity,location
    @RequestMapping(value = "/RAddPlace", method = RequestMethod.POST)
    public CommonResult RAddPlace(Place place, HttpServletRequest request){
        return admin.RAddPlace(place, request);
    }

    //发布管理员进行场地图片的上传
    @RequestMapping(value="/VAdminImagesUpload",method= RequestMethod.POST)
    public ModelAndView VAdminImagesUpload(HttpServletRequest request, MultipartHttpServletRequest multiReq,Place place) throws IOException {
        try {
            admin.RAddPlace(place,request);
            List<MultipartFile> mf = multiReq.getFiles("file");
            String strPath = "D:\\masterSpring\\AdminSystem\\src\\main\\webapp\\data\\placeImage\\" + place.getId() + place.getName();
            String relPath = "/src/main/webapp/data/placeImage/" + place.getId() + place.getName();
            List<PlaceImage> placeImages = new ArrayList<>();
            for (int i = 0; i < mf.size(); i++) {
                PlaceImage placeImage = new PlaceImage();
                if (mf.get(i).isEmpty()) {
                    File f = new File(strPath + "\\" + "该场地无预览" + ".txt");
                    try {
                        FileWriter fw = new FileWriter(f);
                        fw.write("管理员未上传文件");
                        fw.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } else {
                    File ee = new File(strPath);
                    if (!ee.exists())
                        ee.mkdirs();
                    mf.get(i).transferTo(new File(strPath + "\\" + mf.get(i).getOriginalFilename()));
                    placeImage.setPlaceId(place.getId());
                    placeImage.setPortrait(relPath + '/' + mf.get(i).getOriginalFilename());
                    placeImages.add(placeImage);
                }
            }
            admin.OAddPlaceImages(placeImages);
        }catch (Exception e){
            e.printStackTrace();
            return new ModelAndView("errorPage");
        }
        return null;
    }


    //进行场地图片的上传
    @RequestMapping(value="/imagesUpload",method= RequestMethod.POST)
    public ModelAndView testUploadFile(HttpServletRequest request, MultipartHttpServletRequest multiReq,Place place) throws IOException {
        try {
            admin.OAddPlace(place,request);
            List<MultipartFile> mf = multiReq.getFiles("file");
            String strPath = "D:\\masterSpring\\AdminSystem\\src\\main\\webapp\\data\\placeImage\\" + place.getId() + place.getName();
            String relPath = "/src/main/webapp/data/placeImage/" + place.getId() + place.getName();
            List<PlaceImage> placeImages = new ArrayList<>();
            for (int i = 0; i < mf.size(); i++) {
                PlaceImage placeImage = new PlaceImage();
                if (mf.get(i).isEmpty()) {
                    File f = new File(strPath + "\\" + "该场地无预览" + ".txt");
                    try {
                        FileWriter fw = new FileWriter(f);
                        fw.write("管理员未上传文件");
                        fw.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } else {
                    File ee = new File(strPath);
                    if (!ee.exists())
                        ee.mkdirs();
                    mf.get(i).transferTo(new File(strPath + "\\" + mf.get(i).getOriginalFilename()));
                    placeImage.setPlaceId(place.getId());
                    placeImage.setPortrait(relPath + '/' + mf.get(i).getOriginalFilename());
                    placeImages.add(placeImage);
                }
            }
            admin.OAddPlaceImages(placeImages);
        }catch (Exception e){
            e.printStackTrace();
            return new ModelAndView("errorPage");
        }
        return null;
    }

    // 组织管理员增加场地图片
    @RequestMapping(value = "/OAddPlaceImages", method = RequestMethod.POST)
    public CommonResult OAddPlaceImages(List<PlaceImage> placeImages){
        return admin.OAddPlaceImages(placeImages);
    }

    //组织管理员设置会议室相关参数
    @RequestMapping(value = "/setScheduleConfig",method = RequestMethod.POST)
    public void setScheduleConfig(ScheduleConfig scheduleConfig)
    {
        admin.setScheduleConfig(scheduleConfig);
    }

    //组织管理员修改会议室相关参数
    @RequestMapping(value = "/alterScheduleConfig",method=RequestMethod.POST)
    public CommonResult alterScheduleConfig(ScheduleConfig scheduleConfig)
    {
        return admin.updateScheduleConfig(scheduleConfig);
    }


    // 组织管理员分页查询本公司的场地信息
    // 无必须参数
    @RequestMapping(value = "/OFindPlaces",method = RequestMethod.GET)
    public CommonResult OFindPlaces(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int limit, @RequestParam(required = false) String name, HttpServletRequest request){
        return admin.OFindPlaces(page, limit, name, request);
    }

    // 组织管理员增加或修改场地
    // 增加必须参数 name,address
    // 修改必须参数 id,name,address
    @RequestMapping(value = "/OAddOrUpdatePlace", method = RequestMethod.POST)
    public boolean OAddOrUpdatePlace(Place place, HttpServletRequest request){
        return admin.OAddOrUpdatePlace(place, request);}

    // 组织管理员修改场地
    // 必须参数 id,name,address,type 可选参数 introduction,device,instruction,cost,capacity,location
    @RequestMapping(value = "/OUpdatePlace", method = RequestMethod.POST)
    public CommonResult OUpdatePlace(Place place, HttpServletRequest request){ return admin.OUpdatePlace(place, request);}

    // 组织管理员删除场地
    // 必须参数 id
    @RequestMapping(value = "/ODeletePlace")
    public CommonResult ODeletePlace(Place place){ return admin.ODeletePlace(place); }

    //将场地信息存入session
    @RequestMapping(value="/setPlace",method = {RequestMethod.GET,RequestMethod.POST})
    public void setPlace(BigInteger id,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        Place p = admin.getThePlace(id);
        request.getSession().setAttribute("place",p);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<placeInfo>");
        xml.append("<id>").append(p.getId()).append("</id>");
        xml.append("<type>").append(p.getType()).append("</type>");
        xml.append("<name>").append(p.getName()).append("</name>");
        xml.append("<address>").append(p.getAddress()).append("</address>");
        xml.append("<capacity>").append(p.getCapacity()).append("</capacity>");
        xml.append("<introduction>").append(p.getIntroduction()).append("</introduction>");
        xml.append("<device>").append(p.getDevice()).append("</device>");
        xml.append("<instruction>").append(p.getInstruction()).append("</instruction>");
        xml.append("<cost>").append(p.getCost()).append("</cost>");
        xml.append("</placeInfo>");
        xml.append("<status>1</status>");
        xml.append("<func>setPlaceSuccess();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    /************************************/
    /*             职员管理             */
    /************************************/

    // 获取下拉列表部门
    @RequestMapping(value = "/getDepartmentOptions", method = {RequestMethod.GET,RequestMethod.POST})
    public CommonResult getDepartmentOptions(HttpServletRequest request){
        return admin.getDepartmentOptions(request);
    }

    // 组织管理员分页查询本公司的职员信息
//    @RequestMapping(value = "/OFindStaffs",method = RequestMethod.GET)
//    public CommonResult OFindStaffs(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int limit, @RequestParam(required = false) String name, HttpServletRequest request){
//        return admin.OFindStaffs(page, limit, name, request);
//    }

    // 组织管理员增加或修改职员信息
    // 增加必须参数 department,id_num,jobnum,name,phone,pswd
    // 修改必须参数 id,department,id_num,jobnum,name,phone,pswd
    @RequestMapping(value = "/OAddOrUpdateStaff", method = RequestMethod.POST)
    public void OAddOrUpdateStaff(Staff staff, HttpServletRequest request){
        admin.OAddOrUpdateStaff(staff, request);
    }

    // 组织管理员删除职员信息
    // 必须参数 id
    @RequestMapping(value = "/ODeleteStaff")
    public CommonResult ODeleteStaff(HttpServletRequest request,BigInteger staff_id){
        return admin.ODeleteStaff(staff_id);
    }

    /************************************/
    /*             预约管理             */
    /************************************/

    //查询一周内会议安排
    @RequestMapping(value = "/OFindStaffAppointmentsInWeek", method = {RequestMethod.GET,RequestMethod.POST})
    public CommonResult OFindStaffAppointmentsInWeek(@RequestParam Date time, @RequestParam BigInteger place_id, HttpServletRequest request){
        return admin.OFindStaffAppointmentsInWeek(time, place_id, request);
    }

    //获取会议人数
    @RequestMapping(value = "/queryAttendeesList", method = RequestMethod.GET)
    public void queryPeopleNum(BigInteger id, HttpServletResponse response)
            throws ServletException, IOException {
        List<Attendees> resultList = admin.getPeopleNum(id);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<num>").append(resultList.size()).append("</num>");
        xml.append("<status>1</status>");
        xml.append("<func>returnPeopleNum()</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    //将预约信息存入session
    @RequestMapping(value="/setAppointment",method = {RequestMethod.GET,RequestMethod.POST})
    public void setAppointment(BigInteger id,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        Appointment a = admin.getTheAppointment(id);
        request.getSession().setAttribute("appointment",a);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<appointmentInfo>");
        xml.append("<id>").append(a.getId()).append("</id>");
        xml.append("<orderer_id>").append(a.getOrderer_id()).append("</orderer_id>");
        xml.append("<ordererType>").append(a.getOrdererType()).append("</ordererType>");
        xml.append("<startTime>").append(a.getStartTime()).append("</startTime>");
        xml.append("<endTime>").append(a.getEndTime()).append("</endTime>");
        xml.append("<place_id>").append(a.getPlace_id()).append("</place_id>");
        xml.append("<place_name>").append(a.getPlace_name()).append("</place_name>");
        xml.append("<companyId>").append(a.getCompanyId()).append("</companyId>");
        xml.append("<type>").append(a.getType()).append("</type>");
        xml.append("</appointmentInfo>");
        xml.append("<status>1</status>");
        xml.append("<func>setAppointmentSuccess();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    // 组织管理员查询本公司职员的预约情况
    @RequestMapping(value = "/OFindStaffAppointments", method = RequestMethod.GET)
    public  CommonResult OFindStaffAppointments(@RequestParam(required = false) java.sql.Date time, @RequestParam(required = false) BigInteger place_id, HttpServletRequest request){
        return admin.OFindStaffAppointments(time, place_id, request);
    }

    // 组织管理员查询本公司游客的预约情况
    @RequestMapping(value = "/OFindVisitorAppointments", method = RequestMethod.GET)
    public void OFindVisitorAppointments(@RequestParam(required = false) Date time, @RequestParam(required = false) BigInteger place_id, @RequestParam(required = false) String state, HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        List<VisitorAppointment> resultList = admin.OFindVisitorAppointments(time,place_id,state,request);
        System.out.println(resultList.size());
        StringBuffer xml = new StringBuffer();
        xml.append("{");
        xml.append("\"code\":0,\"msg\":\"\",\"count\": " + resultList.size() + ",\"data\":[");
        for (int i = 0; i < resultList.size(); i++) {
            VisitorAppointment temp = resultList.get(i);
            xml.append("{\"id\":\"" + temp.getId() + "\",\"orderer_id\":\" " + temp.getAppointment().getOrderer_id() +
                    "\",\"appointment_id\":\"" + temp.getAppointment_id() +"\",\"duration\":\"" + temp.getAppointment().getDuration()+
                    "\",\"ordererType\":\"" + temp.getAppointment().getOrdererType() + "\",\"startTime\":\"" + temp.getAppointment().getStartTime() +
                    "\",\"endTime\":\"" + temp.getAppointment().getEndTime() + "\",\"place_id\":\"" + temp.getAppointment().getPlace_id() +
                    "\",\"place_name\":\"" + temp.getAppointment().getPlace_name()+"\",\"companyId\":\"" + temp.getAppointment().getCompanyId()+
                    "\",\"type\":\"" + temp.getAppointment().getType()+"\",\"state\":\"" + temp.getState()+ "\"}");
            if (i < (resultList.size() - 1))
                xml.append(",");
        }
        xml.append("]}");
        sendResponse(response, xml.toString());
    }

    // 组织管理员分页查询申请预约情况
    @RequestMapping(value = "/OFindApplyAppointments")
    public  CommonResult OFindApplyAppointments(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int limit, @RequestParam(required = false) java.sql.Date time, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommonResult result = admin.OFindApplyAppointments(page,limit,time,request);
        return result;
    }

    // 组织管理员同意申请预约申请
    @RequestMapping(value = "/OAgreeApply")
    public  CommonResult OAgreeApply(BigInteger id,HttpServletResponse response) throws ServletException, IOException {
        CommonResult result = admin.OAgreeApply(id);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<status>1</status>");
        xml.append("<func>refreshVisitorAppointmentList();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
        return result;
    }

    // 组织管理员拒绝申请预约申请
    @RequestMapping(value = "/ODisagreeApply")
    public  CommonResult ODisagreeApply(BigInteger id,HttpServletResponse response) throws ServletException, IOException {
        CommonResult result = admin.ODisagreeApply(id);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<status>1</status>");
        xml.append("<func>refreshVisitorAppointmentList();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
        return result;
    }


    // 组织管理员添加或修改预约信息
    // 增加必须参数 startTime,endTime,place_id,place_name,type,duration
    // 修改必须参数 id,startTime,endTime,place_id,place_name,type,duration
    @RequestMapping(value = "/OAddOrUpdateAppointment", method = {RequestMethod.GET,RequestMethod.POST})
    public void OAddOrUpdateAppointment(Appointment appointment, HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        admin.OAddOrUpdateAppointment(appointment, request);
        StringBuffer xml = new StringBuffer("<result>");
        xml.append("<status>1</status>");
        xml.append("<func>setNewPlaceSuccess();</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    // 组织管理员删除职员预约信息
    // 必须参数 id
    @RequestMapping(value = "/ODeleteAppointment", method = RequestMethod.POST)
    public CommonResult ODeleteAppointment(Appointment appointment){
        return admin.ODeleteAppointment(appointment);
    }

    // 组织管理员删除游客预约信息
    // 必须参数 id
    @RequestMapping(value = "/ODeleteVisitorAppointment", method = RequestMethod.POST)
    public CommonResult ODeleteVisitorAppointment(VisitorAppointment visitorAppointment){
        return admin.ODeleteVisitorAppointment(visitorAppointment);
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
    public void queryDepartmentList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Admin a = (Admin) request.getSession().getAttribute("OAdmin");
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
    public void getEmployee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dname = request.getParameter("dname");
        Admin a = (Admin) request.getSession().getAttribute("OAdmin");
        List<Staff> result =admin.getDepartmentStaff(dname,a.getCompanyId());
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
