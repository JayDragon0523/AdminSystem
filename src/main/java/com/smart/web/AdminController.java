package com.smart.web;

import com.alibaba.fastjson.JSON;
import com.smart.pojo.*;
import com.smart.AdminService.AdministrationService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;

@Controller
public class AdminController{
    @Resource
    private AdministrationService adminservice;

    //获取公司的部门
    @RequestMapping(value = "/queryDepartmentList", method = RequestMethod.GET)
    public void queryTeachersLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Administrator a = (Administrator) request.getSession().getAttribute("admin");
        List<Department> resultList = adminservice.getDepartmentList(a.getCompany_id());
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
        List<Staff> result =adminservice.getDepartmentStaff(dname);
        int count = result.size();
        result=Page.Page(result,request.getParameter("page"),request.getParameter("limit"));
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