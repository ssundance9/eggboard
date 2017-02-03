package com.eggtec.eggboard.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class FrontInterceptor extends HandlerInterceptorAdapter {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        try {
            String url = request.getRequestURL().toString();
            if (StringUtils.contains(url, Constants.pcDomain)) {
                request.setAttribute(Constants.ViewPrepixName, Constants.PcViewPrepix);
            } else if (StringUtils.contains(url, Constants.mobileDomain)) {
                request.setAttribute(Constants.ViewPrepixName, Constants.MobileViewPrepix);
            } else if (StringUtils.contains(url, "www.localhost")) {
                request.setAttribute(Constants.ViewPrepixName, "");
            } else if (StringUtils.contains(url, "m.localhost")) {
                request.setAttribute(Constants.ViewPrepixName, "/m");
            }
            
            //user 세션값이 널일경우
            if (request.getSession().getAttribute("user") == null) {
                //로그인페이지로 redirect 
                response.sendRedirect("/user/loginView.do");    
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //널이 아니면 정상적으로 컨트롤러 호출
        return true;
    }
}
