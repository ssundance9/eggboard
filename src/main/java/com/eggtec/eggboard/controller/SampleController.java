package com.eggtec.eggboard.controller;

import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eggtec.eggboard.model.User;
import com.eggtec.eggboard.util.MailSender;

import freemarker.template.Configuration;
import freemarker.template.Template;

@Controller
public class SampleController {

	/*@RequestMapping("/sample")
	public String sample(HttpServletRequest req) {
	    
	    Configuration cfg = new Configuration(Configuration.VERSION_2_3_23);
	    //cfg.setClassForTemplateLoading(this.getClass(), "/WEB-INF/freemarker/");
	    cfg.setServletContextForTemplateLoading(req.getServletContext(), "/WEB-INF/freemarker/");
	    
	    try {
	    Template tem = cfg.getTemplate("joinMail.ftl");
	    Writer out = new StringWriter();
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("user", new User());
	    
	    tem.process(map, out);
	    String body = out.toString();
	    
	    MailSender.send("joonover2@naver.com", "test", body);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    
	    
	    
		return "sample";
	}*/
	
}
