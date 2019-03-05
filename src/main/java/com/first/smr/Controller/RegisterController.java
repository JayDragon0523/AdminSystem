package com.first.smr.Controller;

import com.first.smr.POJO.Admin;
import com.first.smr.Service.AdminService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
public class RegisterController {
    @Resource
    private AdminService administrationService;

    //	公司注册页面
    @RequestMapping(value = "/companyRegister")
    public ModelAndView compRegisterPage(){
        return new ModelAndView("compregister");
    }

    //	公司管理员注册页面
    @RequestMapping(value = "/OAdminRegister")
    public ModelAndView OAdminRegiterPage(){
        return new ModelAndView("OAdminregister");
    }

    private void sendResponse(HttpServletResponse response, String responseText)
            throws ServletException, IOException {
        response.setContentType("text/xml");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(responseText);
    }
}
