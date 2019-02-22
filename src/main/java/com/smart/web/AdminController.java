package com.smart.web;

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
        StringBuffer xml = new StringBuffer("<result>");
        for(int i = 0; i < 5; i++){
            xml.append("<showDepartList id='").append(i).append("'>");
            xml.append("<Dname>").append(resultList.get(i).getCname()).append("</Dname>");
            xml.append("</showDepartList>");
        }
        xml.append("<status>1</status>");
        xml.append("<func>updateDepartmentInformationList()</func>");
        xml.append("</result>");
        sendResponse(response, xml.toString());
    }

    private void sendResponse(HttpServletResponse response, String responseText)
            throws ServletException, IOException {
        response.setContentType("text/xml");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(responseText);
    }
}