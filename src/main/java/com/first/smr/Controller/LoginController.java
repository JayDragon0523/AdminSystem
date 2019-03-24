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
public class LoginController{
	@Resource
	private AdminService administrationService;

	//	登陆页面
	@RequestMapping(value = {"/","/index.html",})
	public ModelAndView loginPage(){
		return new ModelAndView("login");
	}

	//	登陆验证
	@RequestMapping(value = "/loginCheck.html")
	public ModelAndView loginCheck(HttpServletRequest request, HttpServletResponse response, LoginCommand loginCommand)
			throws Exception {
		Admin a = administrationService.aLoginCheck(loginCommand.getUserName(), loginCommand.getPassword());
		if (a != null) {
			if (a.getIdentity().equals("组织管理员")) {
				request.getSession().setAttribute("OAdmin", a);
				request.getSession().setMaxInactiveInterval(1800);
				return new ModelAndView("compadmin");
			} else if (a.getIdentity().equals("系统管理员")) {
				request.getSession().setAttribute("SAdmin", a);
				request.getSession().setMaxInactiveInterval(1800);
				return new ModelAndView("sysadmin");
			}else{
				request.getSession().setAttribute("OAdmin", a);
				request.getSession().setMaxInactiveInterval(1800);
				return new ModelAndView("visitoradmin");
			}
		}else {
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
