package com.smart.web;
import com.smart.AdminService.AdministrationService;
import com.smart.pojo.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

@RestController
public class LoginController{
	@Resource
	private AdministrationService administrationService;

	//	登陆页面
	@RequestMapping(value = {"/","/index.html",})
	public ModelAndView loginPage(){
		return new ModelAndView("login");
	}

	//	登陆验证
	@RequestMapping(value = "/loginCheck.html")
	public ModelAndView loginCheck(HttpServletRequest request,HttpServletResponse response,LoginCommand loginCommand)
			throws Exception {
		Administrator a = administrationService.aLoginCheck(loginCommand.getUserName(), loginCommand.getPassword());
		if (a != null) {
			request.getSession().setAttribute("admin", a);
			if(a.getIdentity().equals("组织管理员"))
				return new ModelAndView("compadmin");
			else
				return new ModelAndView("sysadmin");
		} else {
			return new ModelAndView("login", "error", "用户名或密码错误。");
		}
	}

	private void sendResponse(HttpServletResponse response, String responseText)
			throws ServletException, IOException {
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(responseText);
	}

}
