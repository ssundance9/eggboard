package com.eggtec.eggboard.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.eggtec.eggboard.model.User;
import com.eggtec.eggboard.util.Constants;

public class BaseController {
    
    public HttpServletRequest getRequest() {
        RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)requestAttributes).getRequest();
        return request;
    }
    
    public HttpSession getSession() {
        HttpServletRequest request = this.getRequest();
        return request.getSession();
    }
    
    public User getUser() {
        HttpServletRequest request = this.getRequest();
        HttpSession session = this.getSession();
        
        String uri = request.getRequestURI();
        
        if (StringUtils.contains(uri, "/frt") || StringUtils.contains(uri, "/user")) {
            return (User) session.getAttribute("user");
        } else if (StringUtils.contains(uri, "/adm")) {
            return (User) session.getAttribute("admin");
        } else {
            return null;
        }
    }
    
    public String getViewPrepix() {
        return (String) getRequest().getAttribute(Constants.ViewPrepixName);
        //return "/m";
    }
    
}
