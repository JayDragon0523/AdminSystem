package com.first.smr.Service;

import com.first.smr.DAO.*;
import com.first.smr.CommonResult;
import com.first.smr.POJO.*;
import com.first.smr.Util.RandomUtil;
import com.first.smr.Util.SendUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.math.BigInteger;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

@Service
public class AdminService {
    @Resource
    AdminDAO adminDAO;
    @Resource
    VisitorDAO visitorDAO;
    @Resource
    CompanyDAO companyDAO;
    @Resource
    PlaceDAO placeDAO;
    @Resource
    StaffDAO staffDAO;
    @Resource
    AppointmentDAO appointmentDAO;
    @Resource
    private ALoginDao ALoginDao ;
    @Resource
    private DepartmentDao departmentDao ;


    //检查管理员登陆
    public Admin aLoginCheck(String account, String password){
        Admin a = ALoginDao.findByAccount(account);
        if(a!=null && a.getPswd().equals(password))
            return a;
        else
            return null;
    }

    //获取公司部门列表
    public List<Department> getDepartmentList(BigInteger id){
        return departmentDao.find(id);
    }

    //部门职员信息
    public List<Staff> getDepartmentStaff(String dname){
        return staffDAO.find(dname);
    }
    //@Transactional
    /*
    * 系统管理员通过账号密码进行登录
    * @param a:管理员持久化对象
    * @return 如果账号密码身份匹配，那么返回"登录成功"
    *                           否则返回"用户名或密码错误"
     */
    public CommonResult SLogin(Admin a, HttpServletRequest request){
        CommonResult result=new CommonResult();
        try{
            boolean adminIsNull=false;
            Admin aFind=adminDAO.findByAccountAndPswdAndIdentity(a.getAccount(),a.getPswd(),"系统管理员");
            if(aFind==null){
                adminIsNull=true;
            }
            if(!adminIsNull){
                result.setMsg("登录成功");
                // 存入session
                request.getSession().setAttribute("SAdmin",aFind);
            }
            else{
                result.setMsg("用户名或密码错误");
            }
        }
        catch(Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("登录失败");
        }
        return result;
    }

    /*
     * 组织管理员通过账号密码进行登录
     * @param a:管理员持久化对象
     * @return 如果账号密码身份匹配，那么返回"登录成功"
     *                               否则返回"用户名或密码错误"
     */
    public CommonResult OLogin(Admin a, HttpServletRequest request){
        CommonResult result=new CommonResult();
        try{
            boolean adminIsNull=false;
            Admin aFind=adminDAO.findByAccountAndPswdAndIdentityAndCompanyId(a.getAccount(),a.getPswd(),"组织管理员",a.getCompanyId());
            if(aFind==null){
                adminIsNull=true;
            }
            if(!adminIsNull){
                // 存入session
                request.getSession().setAttribute("OAdmin",aFind);
            }
            else{
                result.setResult("fail");
                result.setMsg("用户名或密码或所属公司错误");
            }
        }
        catch(Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("登录失败");
        }
        return result;
    }

    /*
    * 组织管理员注册
    * @param a:管理员持久化对象
    * @return: 如果该账号存在，那么返回"账号已存在"
    *                          否则返回"申请中"
    * */
    public CommonResult ORegister(Admin a){
        CommonResult result=new CommonResult();
        try{
            boolean adminIsNull=false;
            a.setIdentity("组织管理员");
            if(adminDAO.findByAccountAndIdentityAndCompanyId(a.getAccount(),a.getIdentity(),a.getCompanyId())==null){
                adminIsNull=true;
            }
            if(adminIsNull){
                a.setState("申请中");
                adminDAO.save(a);
            }
            else{
                result.setResult("fail");
                result.setMsg("账号已存在");
                return result;
            }
        }catch(Exception e){
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("注册失败");
        }
        return result;
    }

    /*
    * 系统管理员增加系统管理员
    * @param admin:管理员对象
    * @return
    * */
    public CommonResult SAddSAdmin(Admin admin){
        CommonResult result = new CommonResult();
        try{
            admin.setIdentity("系统管理员");
            Admin aFind=adminDAO.findByAccountAndIdentity(admin.getAccount(),admin.getIdentity());
            if(aFind==null){
                adminDAO.save(admin);
            }
            else{
                result.setStatus(500);
                result.setMsg("该账号已存在");
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员修改个人信息
    * @param admin:  管理员对象
    * @param request:HttpServletRequest对象
    * @return
    * */
    public CommonResult SUpdateSelf(Admin admin, HttpServletRequest request){
        CommonResult result = new CommonResult();
        try {
            Admin aInSession=(Admin)request.getSession().getAttribute("SAdmin");
            admin.setId(aInSession.getId());
            admin.setIdentity(aInSession.getIdentity());
            boolean isExist=false;
            if(!aInSession.getAccount().equals(admin.getAccount())){
                Admin aFind=adminDAO.findByAccountAndIdentity(admin.getAccount(),admin.getIdentity());
                if(aFind!=null) isExist=true;
            }
            if(isExist){
                result.setStatus(500);
                result.setMsg("该账号已存在");
            }
            else {
                adminDAO.save(admin);
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员注销个人账号
    * @param request: HttpServletRequest对象
    * @return
    * */
    public CommonResult SDeleteSelf(HttpServletRequest request){
        CommonResult result = new CommonResult();
        try {
            Admin aInSession=(Admin)request.getSession().getAttribute("SAdmin");
            adminDAO.delete(aInSession);
            request.getSession().removeAttribute("SAdmin");
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员同意组织管理员的注册
    * @param a:管理员持久化对象
    * @return: 如果修改成功，那么返回"修改成功"
    *          如果账号不存在，那么返回"该管理员对象不存在"
    *          否则返回"修改失败"
    * */
    public CommonResult SReviewOAdmin(Admin a){
        CommonResult result=new CommonResult();
        try{
            boolean adminIsNull=false;
            Admin admin=adminDAO.findAdminById(a.getId());
            if(admin==null){
                adminIsNull=true;
            }
            if(adminIsNull){
                result.setStatus(404);
                result.setResult("fail");
                result.setMsg("该管理员对象不存在");
            }
            else {
                admin.setState("申请成功");
                adminDAO.save(admin);
            }
        }catch(Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("修改失败");
        }
        return result;
    }

    /*
     * 系统管理员分页查询所有组织管理员信息
     * @param pagenum: 页码（第1页为0）
     * @param:size     一页大小
     * @param:account  组织管理员名（可以为空）
     * @return: 查询结果集
     * */
    public CommonResult SFindOAdmins(int pagenum, int size, String account){
        CommonResult result=new CommonResult();
        Pageable pageable=getPageable(pagenum,size);
        Page page;
        try{
            if(account==null) page=adminDAO.findAllByIdentity("组织管理员", pageable);
            else page=adminDAO.findByAccountContainingAndIdentity(account, "组织管理员", pageable);
            result.setData(page);
        }catch (Exception e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员增加组织管理员
    * @param admin : 管理员对象
    * @return
    * */
    public CommonResult SAddOAdmin(Admin admin){
        CommonResult result=new CommonResult();
        try{
            if(admin.getCompanyId()==null||admin.getCompany().getName()==null){
                result.setStatus(500);
                result.setMsg("所属公司不能为空");
                return result;
            }
            admin.setIdentity("组织管理员");
            Admin aFind=adminDAO.findByAccountAndIdentityAndCompanyId(admin.getAccount(),admin.getIdentity(),admin.getCompanyId());
            if(aFind==null) {
                admin.setState("申请成功");
                adminDAO.save(admin);
            }
            else{
                result.setStatus(500);
                result.setMsg("该登陆账号已存在");
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员修改组织管理员
    * @param admin:管理员对象
    * @return
    * */
    public CommonResult SUpdateOAdmin(Admin admin){
        CommonResult result = new CommonResult();
        try{
            Admin aFind=adminDAO.findAdminById(admin.getId());
            admin.setCompanyId(aFind.getCompanyId());
            admin.setState(aFind.getState());
            admin.setIdentity(aFind.getIdentity());
            boolean isExist=false;
            if(!aFind.getAccount().equals(admin.getAccount())){
                Admin aFind1=adminDAO.findByAccountAndIdentity(admin.getAccount(),admin.getIdentity());
                if(aFind1!=null) isExist=true;
            }
            if(isExist){
                result.setStatus(500);
                result.setMsg("该账号已存在");
            }
            else{
                adminDAO.save(admin);
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员删除组织管理员
    * @param admin: 管理员对象
    * @return
    * */
    public CommonResult SDeleteOAdmin(Admin admin){
        CommonResult result=new CommonResult();
        try{
            adminDAO.delete(admin);
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员增加本公司组织管理员
    * @param admin:   管理员对象
    * @param request: HttpServletRequest对象
    * @return
    * */
    public CommonResult OAddOAdmin(Admin admin, HttpServletRequest request){
        CommonResult result = new CommonResult();
        try{
            Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
            admin.setCompanyId(aInSession.getCompanyId());
            admin.setIdentity("组织管理员");
            Admin aFind=adminDAO.findByAccountAndIdentityAndCompanyId(admin.getAccount(),admin.getIdentity(),admin.getCompanyId());
            if(aFind==null){
                admin.setState("申请中");
                adminDAO.save(admin);
            }
            else{
                result.setStatus(500);
                result.setMsg("该登陆账号已存在");
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员修改个人信息
    * @param admin:  管理员对象
    * @param request HttpServletRequest对象
    * @return
    * */
    public CommonResult OUpdateSelf(Admin admin, HttpServletRequest request){
        CommonResult result = new CommonResult();
        try{
            Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
            admin.setId(aInSession.getId());
            admin.setIdentity(aInSession.getIdentity());
            admin.setCompanyId(aInSession.getCompanyId());
            admin.setState(aInSession.getState());
            boolean isExist=false;
            if(!aInSession.getAccount().equals(admin.getAccount())){
                Admin aFind=adminDAO.findByAccountAndIdentity(admin.getAccount(),admin.getIdentity());
                if(aFind!=null) isExist=true;
            }
            if(isExist) {
                result.setStatus(500);
                result.setMsg("该账号已存在");
            }
            else{
                adminDAO.save(admin);
                request.getSession().setAttribute("OAdmin",admin);
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员注销自身账号
    * @param request: HttpServletRequest对象
    * @return
    * */
    public CommonResult ODeleteSelf(HttpServletRequest request){
        CommonResult result=new CommonResult();
        try{
            Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
            adminDAO.delete(aInSession);
            request.getSession().removeAttribute("OAdmin");
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 得到分页的方式
    * @param pagenum: 页码（第1页为0）
    * @param size   : 一页大小
    * @param sort:    排序方式（暂时没写）
    * return: 返回分页方式
    * */
    private Pageable getPageable(int pagenum, int size){
        Sort sort = new Sort(Sort.Direction.ASC, "id");
        return new PageRequest(pagenum,size,sort);
    }

    /*
    * 系统管理员分页查询所有游客信息
    * @param pagenum: 页码（第1页为0）
    * @param:size     一页大小
    * @param:name     游客名（可以为空）
    * return: 查询结果集
    * */
    public CommonResult SFindVisitors(int pagenum, int size, String name){
        CommonResult result=new CommonResult();
        Pageable pageable=getPageable(pagenum,size);
        Page page;
        try {
            if (name == null) page = visitorDAO.findAll(pageable);
            else page = visitorDAO.findByNameContaining(name, pageable);
            result.setData(page);
        }catch (Exception e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员增加游客
    * @param visitor; 游客对象
    * @return
    * */
    public CommonResult SAddVisitor(Visitor visitor){
        CommonResult result = new CommonResult();
        try {
            Visitor vFind=visitorDAO.findByPhone(visitor.getPhone());
            if(vFind==null){
                visitorDAO.save(visitor);
            }
            else{
                result.setStatus(500);
                result.setMsg("电话已经被注册");
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员修改游客
    * @param visitor:游客对象
    * @return
    * */
    public CommonResult SUpdateVisitor(Visitor visitor){
        CommonResult result = new CommonResult();
        try {
            visitorDAO.save(visitor);
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员删除游客
    * @param visitor: 游客对象
    * @return
    * */
    public CommonResult SDeleteVisitor(Visitor visitor){
        CommonResult result = new CommonResult();
        try {
            visitorDAO.delete(visitor);
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员分页查询所有公司信息
    * @param:pagenum: 页码（第1页为0）
    * @param:size     一页大小
    * @param:name     公司名（可以为空）
    * @return: 查询结果集
    * */
    public CommonResult SFindCompanies(int pagenum,int size,String name){
        CommonResult result=new CommonResult();
        Pageable pageable=getPageable(pagenum,size);
        Page page;
        try{
            if(name==null) page=companyDAO.findAll(pageable);
            else page=companyDAO.findByNameContaining(name,pageable);
            result.setData(page);
        }catch (Exception e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员增加公司
    * @param company: 公司对象
    * @return
    * */
    public CommonResult SAddCompany(Company company){
        CommonResult result = new CommonResult();
        try{
            Company cFind=companyDAO.findByName(company.getName());
            if(cFind==null){
                company.setState("申请成功");
                companyDAO.save(company);
            }
            else{
                result.setStatus(500);
                result.setMsg("该公司名已存在");
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员修改公司
    * @param company: 公司对象
    * @return
    * */
    public CommonResult SUpdateCompany(Company company){
        CommonResult result = new CommonResult();
        try{
            Company cFind=companyDAO.findCompanyById(company.getId());
            boolean isExist=false;
            if(!cFind.getName().equals(company.getName())){
                Company cFind1=companyDAO.findByName(company.getName());
                if(cFind1!=null) isExist=true;
            }
            if(isExist){
                result.setStatus(500);
                result.setMsg("该公司名已存在");
            }
            else {
                company.setState(cFind.getState());
                companyDAO.save(company);
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员删除公司
    * @param company: 公司对象
    * @return
    * */
    public CommonResult SDeleteCompany(Company company){
        CommonResult result = new CommonResult();
        try{
            companyDAO.delete(company);
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 系统管理员审核公司
    * */
    public CommonResult SReviewCompany(Company company){
        CommonResult result = new CommonResult();
        try{
            Company cFind=companyDAO.findCompanyById(company.getId());
            cFind.setState("申请成功");
            companyDAO.save(cFind);
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员分页查询本公司的场地信息
    * @param:pagenum: 页码（第1页为0）
    * @param:size     一页大小
    * @param:name     场地名（可以为空）
    * @param:request  HttpServletRequest对象，用来得到session
    * @return: 查询结果集
    * */
    public CommonResult OFindPlaces(int pagenum, int size, String name, HttpServletRequest request){
        CommonResult result=new CommonResult();
        Pageable pageable=getPageable(pagenum,size);
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        Page page;
        try {
            if (name == null) page = placeDAO.findByCompanyId(aInSession.getCompanyId(), pageable);
            else page = placeDAO.findByNameContainingAndCompanyId(name, aInSession.getCompanyId(), pageable);
            result.setData(page);
        }catch (Exception e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员分页查询本公司的职员信息
    * @param:pagenum: 页码（第1页为0）
    * @param:size     一页大小
    * @param:name     职员名（可以为空）
    * @param:request  HttpServletRequest对象，用来得到session
    * @return: 查询结果集
    * */
    public CommonResult OFindStaffs(int pagenum, int size, String name, HttpServletRequest request){
        CommonResult result=new CommonResult();
        Pageable pageable=getPageable(pagenum,size);
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        Page page;
        try {
            if (name == null) page = staffDAO.findByCompanyId(aInSession.getCompanyId(), pageable);
            else page = staffDAO.findByNameContainingAndCompanyId(name, aInSession.getCompanyId(), pageable);
            result.setData(page);
        }catch (Exception e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员分页查询本公司的预约情况
    * @param:pagenum: 页码（第1页为0）
    * @param:size     一页大小
    * @param:time     日期 格式：yyyy-MM-dd（可以为空）
    * @param:request  HttpServletRequest对象，用来得到session
    * @return: 查询结果集
    * */
    public CommonResult OFindAppointments(int pagenum, int size, Date time, HttpServletRequest request){
        CommonResult result=new CommonResult();
        Pageable pageable=getPageable(pagenum,size);
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        Page page = null;
        try {
            if(time==null){
                page=appointmentDAO.findByCompanyId(aInSession.getCompanyId(),pageable);
                result.setData(page);
            }
            else{
                Calendar before_cal = Calendar.getInstance();
                Calendar after_cal = Calendar.getInstance();
                before_cal.setTime(time);
                after_cal.setTime(time);
                before_cal.add(Calendar.SECOND, -1);
                after_cal.add(Calendar.DATE,1);
                String before_sdf = before_cal.get(Calendar.YEAR) + "-" + (before_cal.get(Calendar.MONTH)+1) + "-" + before_cal.get(Calendar.DAY_OF_MONTH) + " "
                        + before_cal.get(Calendar.HOUR_OF_DAY) + ":" + before_cal.get(Calendar.MINUTE) + ":" + before_cal.get(Calendar.SECOND);
                String after_sdf = after_cal.get(Calendar.YEAR) + "-" + (after_cal.get(Calendar.MONTH)+1) + "-" + after_cal.get(Calendar.DAY_OF_MONTH) + " "
                        + after_cal.get(Calendar.HOUR_OF_DAY) + ":" + after_cal.get(Calendar.MINUTE) + ":" + after_cal.get(Calendar.SECOND);
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Timestamp before_timestamp=new Timestamp(0);
                Timestamp after_timestamp=new Timestamp(0);
                java.util.Date before_date = format.parse(before_sdf);
                java.util.Date after_date = format.parse(after_sdf);
                before_timestamp.setTime(before_date.getTime());
                after_timestamp.setTime(after_date.getTime());
                if(appointmentDAO==null) System.out.println("null");
                page=appointmentDAO.findByStartTimeAfterAndStartTimeBeforeAndCompanyId(before_timestamp, after_timestamp, aInSession.getCompanyId(), pageable);
                result.setData(page);
            }
        }catch (Exception e){
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员增加或修改场地
    * @param:place   场地对象
    * @param:request HttpServletRequest对象
    * @return:
    * */
    public CommonResult OAddOrUpdatePlace(Place place, HttpServletRequest request){
        CommonResult result=new CommonResult();
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        try{
            place.setCompanyId(aInSession.getCompanyId());
            place.setCompany_name(aInSession.getCompany().getName());
            placeDAO.save(place);
        }catch(Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员删除场地
    * @param:place  场地对象
    * @return
    * */
    public CommonResult ODeletePlace(Place place){
        CommonResult result=new CommonResult();
        try{
            placeDAO.delete(place);
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员增加或修改职员信息
    * @param staff:   职员对象
    * @param request: HttpServletRequest对象
    * @return
    * */
    public CommonResult OAddOrUpdateStaff(Staff staff, HttpServletRequest request){
        CommonResult result = new CommonResult();
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        try{
            staff.setCompany(aInSession.getCompany().getName());
            staff.setCompanyId(aInSession.getCompanyId());
            staffDAO.save(staff);
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员删除职员信息
    * @param staff: 职员对象
    * @return
    * */
    public CommonResult ODeleteStaff(Staff staff){
        CommonResult result = new CommonResult();
        try {
            staffDAO.delete(staff);
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员添加或修改预约信息
    * @param:appointment 预约对象
    * @param:request     HttpServletRequest对象
    * @return
    * */
    public CommonResult OAddOrUpdateAppointment(Appointment appointment, HttpServletRequest request){
        CommonResult result = new CommonResult();
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        try{
            appointment.setCompanyId(aInSession.getCompanyId());
            appointment.setOrderer_id(aInSession.getId());
            appointmentDAO.save(appointment);
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员删除预约信息
    * @param:appointment 预约对象
    * @return
    * */
    public CommonResult ODeleteAppointment(Appointment appointment){
        CommonResult result = new CommonResult();
        try{
            appointmentDAO.delete(appointment);
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 组织管理员审核预约
    * @param appointment:预约对象
    * @return
    * */
    public CommonResult OReviewAppointment(Appointment appointment){
        CommonResult result = new CommonResult();
        try{
            Appointment aFind=appointmentDAO.getOne(appointment.getId());
            //aFind.setState("申请成功");
            appointmentDAO.save(aFind);
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    /*
    * 发送验证码短信
    * @param phone: 手机号码
    * @return
    * */
    public CommonResult sendMessage(String phone){
        CommonResult result=new CommonResult();
        int random= RandomUtil.getRandNum();
        SendUtil send=new SendUtil();
        try {
            send.sendMess(phone,random);
            result.setMsg("信息发送成功");
            result.setData(random);
        } catch (IOException e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("信息发送失败");
        }
        return result;
    }

}
