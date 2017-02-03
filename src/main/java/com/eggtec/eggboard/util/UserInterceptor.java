package com.eggtec.eggboard.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class UserInterceptor extends HandlerInterceptorAdapter {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

}
