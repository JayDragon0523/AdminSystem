package com.smart.Interceptor;
import com.smart.pojo.Administrator;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class AdminLoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        super.afterCompletion(request, response, handler, ex);
        Administrator a = (Administrator) request.getSession().getAttribute("admin");
        if(a==null){
            request.setAttribute("error", "请先登录");
            request.getRequestDispatcher("index.html").forward(request, response);
        }
    }
}
