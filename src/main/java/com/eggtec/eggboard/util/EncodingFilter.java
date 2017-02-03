package com.eggtec.eggboard.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.log4j.Logger;

public class EncodingFilter implements Filter {
    Logger log = Logger.getLogger(this.getClass());
    private String encoding = null;
    protected FilterConfig filterConfig = null;

    public void destroy() {
        this.encoding = null;
        this.filterConfig = null;
    }

    // web.xml에서 전달된 encoding 값을 초기화
    public void init(FilterConfig filterConfig) throws ServletException {
        log.debug("0000000000000000");
        this.filterConfig = filterConfig;
        this.encoding = filterConfig.getInitParameter("encoding");
    }

    public FilterConfig getFilterConfig() {
        return filterConfig;
    }

    public void setFilterConfig(FilterConfig cfg) {
        filterConfig = cfg;
    }

    // init 메소드에서 초기화한 encoding 값을 request 객체에 셋팅
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
log.debug("1111111111");
        if (request.getCharacterEncoding() == null) {
            log.debug("22222222222");
            if (encoding != null) {
                log.debug("333333333333");
                request.setCharacterEncoding(encoding);
            }
        }
        log.debug("4444444444");
        chain.doFilter(request, response);
    }
}
