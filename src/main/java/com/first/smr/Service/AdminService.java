package com.first.smr.Service;

import ch.qos.logback.core.encoder.EchoEncoder;
import com.first.smr.Application;
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
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.basic.BasicIconFactory;
import java.io.IOException;
import java.math.BigInteger;
import java.util.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

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
    @Resource
    private EvaluationDAO evaluationDAO;
    @Resource
    VisitorAppointmentDAO visitorAppointmentDAO;


    //检查管理员登陆
    public Admin aLoginCheck(String account, String password){
        Admin a = ALoginDao.findByAccount(account);
        if(a!=null && a.getPswd().equals(password))
            return a;
        else
            return null;
    }
    //更改管理员手机号
    @Transactional
    public boolean updateAdmin(String account,Admin a){
        Admin aa = ALoginDao.findByAccount(account);
        aa.setPhone(a.getPhone());
        ALoginDao.save(aa);
        return true;
    }
    //更新管理员密码信息
    @Transactional
    public boolean adminSafe(String account,Admin a){
        Admin aa = ALoginDao.findByAccount(account);
        aa.setPswd(a.getPswd());
        ALoginDao.save(aa);
        return true;
    }

    //获取公司部门列表
    public List<Department> getDepartmentList(BigInteger id){
        return departmentDao.find(id);
    }
    //具体职员信息
    public Staff getTheStaff(String jobnum){
        return staffDAO.findByJobnum(jobnum);
    }
    //部门职员信息
    public List<Staff> getDepartmentStaff(String dname,BigInteger cpid){
        return staffDAO.find(dname,cpid);
    }
    //更新管理员人脸信息
    public CommonResult updateFaceInfo(HttpServletRequest request,byte[] face_info){
        CommonResult result=new CommonResult();
        Admin aInSession1=(Admin)request.getSession().getAttribute("OAdmin");
        Admin aInSession2=(Admin)request.getSession().getAttribute("SAdmin");
        try{
            if(aInSession1!=null){
                aInSession1.setFace_info(face_info);
                result.setMsg("更新成功");
                // 存入session
                request.getSession().setAttribute("OAdmin",aInSession1);
            }else{
                aInSession2.setFace_info(face_info);
                result.setMsg("更新成功");
                // 存入session
                request.getSession().setAttribute("SAdmin",aInSession2);
            }
        }
        catch(Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("更新失败");
        }
        return result;
    }
    //具体预约信息
    public Appointment getTheAppointment(BigInteger id){
        return appointmentDAO.findOne(id);
    }
    //具体场地信息
    public Place getThePlace(BigInteger id){
        return placeDAO.findOne(id);
    }
    //具体组织信息
    public Company getTheCompany(BigInteger id){
        return companyDAO.findCompanyById(id);
    }
    //具体管理员信息
    public Admin getTheAdmin(BigInteger id){
        return adminDAO.findAdminById(id);
    }
    //具体管理员信息
    public Visitor getTheVisitor(BigInteger id){
        return visitorDAO.findOne(id);
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

    //系统管理员拒绝组织管理员的注册
    public CommonResult SDisagreeOAdmin(Admin a){
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
                admin.setState("申请失败");
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
        List<Admin> page;
        try{
            if(account==null) page=adminDAO.findAllByIdentity("组织管理员");
            else page=adminDAO.findByAccountContainingAndIdentity(account, "组织管理员");
            result.setCount(page.size());
            result.setData(page);
        }catch (Exception e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    public CommonResult SFindSAdmins(int pagenum, int size, String account){
        CommonResult result=new CommonResult();
        Pageable pageable=getPageable(pagenum,size);
        List<Admin> page;
        try{
            if(account==null) page=adminDAO.findAllByIdentity("系统管理员");
            else page=adminDAO.findByAccountContainingAndIdentity(account, "系统管理员");
            result.setCount(page.size());
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
            if(admin.getCompanyId()==null){
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
     * 组织管理员申请
     * @param admin : 管理员对象
     * @return
     * */
    public boolean OAdminApply(Admin admin){
        CommonResult result=new CommonResult();
        try{
            if(admin.getCompanyId()==null){
                result.setStatus(500);
                result.setMsg("所属公司不能为空");
                return false;
            }
            admin.setIdentity("组织管理员");
            Admin aFind=adminDAO.findByAccountAndIdentityAndCompanyId(admin.getAccount(),admin.getIdentity(),admin.getCompanyId());
            if(aFind==null) {
                admin.setState("申请中");
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
            return false;
        }
        return true;
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
     * 系统管理员寻找游客评价
     * @param evaluation: 游客评价对象
     * @return
     * */
    public CommonResult OFindEvaluations(int pagenum, int size, HttpServletRequest request){
        CommonResult result=new CommonResult();
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        Pageable pageable=getPageable(pagenum,size);
        List<Evaluation> page;
        List<Place> places;
        List<BigInteger> placeId = new ArrayList<>();
        try {
            places = placeDAO.findByCompanyId(aInSession.getCompanyId());
            for (int i = 0; i < places.size(); i++) {
                placeId.add(places.get(i).getId());
            }
            page = evaluationDAO.findByCompanyId(placeId);
            result.setCount(page.size());
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
     * 组织管理员删除游客评价
     * @param evaluation: 游客评价对象
     * @return
     * */
    public CommonResult ODeleteEvaluation(BigInteger id){
        CommonResult result = new CommonResult();
        Evaluation ee = evaluationDAO.findOne(id);
        try {
            evaluationDAO.delete(ee);
        }catch (Exception e){
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
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
        List<Visitor> page;
        try {
            if (name == null) page = visitorDAO.findAll();
            else page = visitorDAO.findByNameContaining(name);
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
        List<Company> page;
        try{
            if(name==null) page=companyDAO.findAll();
            else page=companyDAO.findByNameContaining(name);
            result.setCount(page.size());
            result.setData(page);
        }catch (Exception e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }
        return result;
    }

    //系统管理员分页查询所有公司申请记录
    public CommonResult SFindApplyCompanies(int pagenum,int size,String name){
        CommonResult result=new CommonResult();
        Pageable pageable=getPageable(pagenum,size);
        List<Company> page;
        try{
            if(name==null) page=companyDAO.findApplyAll();
            else page=companyDAO.findByNameContaining2(name);
            result.setCount(page.size());
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
     * 公司申请
     * @param company: 公司对象
     * @return
     * */
    public boolean companyApply(Company company){
        CommonResult result = new CommonResult();
        try{
            Company cFind=companyDAO.findByName(company.getName());
            if(cFind==null){
                company.setState("申请中");
                companyDAO.save(company);
            }
            else{
                result.setStatus(500);
                result.setMsg("该公司名已存在");
                return false;
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
            return false;
        }
        return true;
    }

    /*
    * 系统管理员增加公司
    * @param company: 公司对象
    * @return
    * */
    public boolean SAddCompany(Company company){
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
                return false;
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
            return false;
        }
        return true;
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

    //拒绝申请
    public CommonResult SDisagreeApply(Company company){
        CommonResult result = new CommonResult();
        Company c = companyDAO.findCompanyById(company.getId());
        try{
            c.setState("申请失败");
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
        List<Place> page;
        try {
            if (aInSession == null) System.out.println("null");
            if (name == null) page = placeDAO.findByCompanyId(aInSession.getCompanyId());
            else page = placeDAO.findByNameContainingAndCompanyId(name, aInSession.getCompanyId());
            result.setData(page);
            result.setCount(page.size());
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
    public CommonResult OFindStaffAppointments(java.sql.Date time, BigInteger place_id, HttpServletRequest request){
        CommonResult result=new CommonResult();
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        List list = null;
        try {
            if(time==null&&place_id==null){
                list=appointmentDAO.findByCompanyIdAndOrdererType(aInSession.getCompanyId(),"staff");
                result.setData(list);
            }
            else if(time!=null){
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
                System.out.println(before_timestamp);
                System.out.println(after_timestamp);
                if(place_id==null){
                    list=appointmentDAO.findByStartTimeAfterAndStartTimeBeforeAndCompanyIdAndOrdererType(before_timestamp, after_timestamp, aInSession.getCompanyId(),"staff");
                    result.setData(list);
                }
                else if(place_id!=null){
                    list=appointmentDAO.findByPlace_idAndStartTimeAfterAndStartTimeBeforeAndCompanyIdAndOrdererType(place_id, before_timestamp, after_timestamp, aInSession.getCompanyId(),"staff");
                    result.setData(list);
                }
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
     * 组织管理员分页查询本公司游客的预约情况
     * */
    public List<VisitorAppointment> OFindVisitorAppointments(java.sql.Date time, BigInteger place_id, String state, HttpServletRequest request){
        CommonResult result = new CommonResult();
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        List<VisitorAppointment> list = new ArrayList<>();
        try{
            Timestamp before_timestamp=new Timestamp(0);
            Timestamp after_timestamp=new Timestamp(0);
            if(time!=null){
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
                java.util.Date before_date = format.parse(before_sdf);
                java.util.Date after_date = format.parse(after_sdf);
                before_timestamp.setTime(before_date.getTime());
                after_timestamp.setTime(after_date.getTime());
            }
            if(time==null && place_id==null && state==null){
                list=visitorAppointmentDAO.findByAppointment_CompanyId(aInSession.getCompanyId());
                result.setData(list);
            }
            else if(time!=null && place_id==null && state==null){
                list=visitorAppointmentDAO.findByAppointment_StartTimeAfterAndAppointment_StartTimeBeforeAndAppointment_CompanyId(before_timestamp, after_timestamp, aInSession.getCompanyId());
                result.setData(list);
            }
            else if(time==null && place_id!=null && state==null){
                list=visitorAppointmentDAO.findByAppointment_Place_idAndAppointment_CompanyId(place_id, aInSession.getCompanyId());
                result.setData(list);
            }
            else if(time==null && place_id==null && state!=null){
                list=visitorAppointmentDAO.findByStateAndAppointment_CompanyId(state, aInSession.getCompanyId());
                result.setData(list);
            }
            else if(time!=null && place_id!=null && state==null){
                list=visitorAppointmentDAO.findByAppointment_Place_idAndAppointment_StartTimeAfterAndAppointment_StartTimeBeforeAndAppointment_CompanyId(place_id ,before_timestamp, after_timestamp, aInSession.getCompanyId());
                result.setData(list);
            }
            else if(time==null && place_id!=null && state!=null){
                list=visitorAppointmentDAO.findByStateAndAppointment_Place_idAndAppointment_CompanyId(state, place_id, aInSession.getCompanyId());
                result.setData(list);
            }
            else if(time!=null && place_id==null && state!=null){
                list=visitorAppointmentDAO.findByStateAndAppointment_StartTimeAfterAndAppointment_StartTimeBeforeAndAppointment_CompanyId(state, before_timestamp, after_timestamp, aInSession.getCompanyId());
                result.setData(list);
            }
            else if(time!=null && place_id!=null && state!=null){
                list=visitorAppointmentDAO.findByStateAndAppointment_Place_idAndAppointment_StartTimeAfterAndAppointment_StartTimeBeforeAndAppointment_CompanyId(state, place_id, before_timestamp, after_timestamp, aInSession.getCompanyId());
                result.setData(list);
            }
        }catch (Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
        }

        return list;
    }


    /*
     * 组织管理员分页查询申请预约情况
     * @param:pagenum: 页码（第1页为0）
     * @param:size     一页大小
     * @param:time     日期 格式：yyyy-MM-dd（可以为空）
     * @param:request  HttpServletRequest对象，用来得到session
     * @return: 查询结果集
     * */
    public CommonResult OFindApplyAppointments(int pagenum, int size, Date time, HttpServletRequest request){
        System.out.println("time:"+time);
        CommonResult result=new CommonResult();
        Pageable pageable=getPageable(pagenum,size);
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        List<Appointment> page = null;
        //time = null;
        try {
            if(time==null){
                if(aInSession==null) System.out.println("null");
                page=appointmentDAO.findApply(aInSession.getCompanyId());
                System.out.println("size:"+page.size());
                result.setCount(page.size());
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
                page=appointmentDAO.findByStartTimeAfterAndStartTimeBeforeAndCompanyIdAndOrdererType(before_timestamp, after_timestamp, aInSession.getCompanyId(),"visitor");
                System.out.println("appointment size:"+page.size());
                result.setCount(page.size());
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

    //组织管理员同意申请
    public CommonResult OAgreeApply(BigInteger id){
        CommonResult result = new CommonResult();
        try{
            VisitorAppointment a = visitorAppointmentDAO.findVisitorAppointmentById(id);
            a.setState("申请成功");
            visitorAppointmentDAO.save(a);
        }catch (Exception e){
            result.setStatus(500);
            result.setMsg("error");
        }
        return result;
    }

    //组织管理员拒绝申请
    public CommonResult ODisagreeApply(BigInteger id){
        CommonResult result = new CommonResult();
        try{
            VisitorAppointment a = visitorAppointmentDAO.findVisitorAppointmentById(id);
            a.setState("申请失败");
            visitorAppointmentDAO.save(a);
        }catch (Exception e){
            result.setStatus(500);
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
    public boolean OAddOrUpdatePlace(Place place, HttpServletRequest request){
        CommonResult result=new CommonResult();
        Admin aInSession=(Admin)request.getSession().getAttribute("OAdmin");
        try{
            place.setCompanyId(aInSession.getCompanyId());
            place.setCompany(companyDAO.findCompanyById(aInSession.getCompanyId()));
            placeDAO.save(place);
        }catch(Exception e){
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("error");
            return false;
        }
        return true;
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
            e.printStackTrace();
            System.out.println("datanull");
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
    public CommonResult ODeleteStaff(BigInteger id){
        CommonResult result = new CommonResult();
        Staff staff = staffDAO.findByStaffId(id);
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
