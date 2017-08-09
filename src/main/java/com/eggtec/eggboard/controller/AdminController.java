package com.eggtec.eggboard.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;
import com.eggtec.eggboard.model.User;
import com.eggtec.eggboard.service.AdminService;
import com.eggtec.eggboard.service.FrontService;
import com.eggtec.eggboard.service.UserService;
import com.eggtec.eggboard.util.Constants;

@Controller
public class AdminController {
    Logger log = Logger.getLogger(this.getClass());
    
    @Inject
    AdminService adminService;
    
    @Inject
    UserService userService;
    
    @Inject
    FrontService frontService;
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/adm/eggStatus")
    public String eggStatus(Model model, String serialNo) {
        User uparam = new User();
        //uparam.setPageNum(pageNum);
        uparam.setUserType("M");
        List<User> userList = userService.getMemberList(uparam);
        model.addAttribute("userList", userList);
        
        
        if (StringUtils.isNotEmpty(serialNo)) {
            Farm param = new Farm();
            param.setSerialNo(serialNo);
            //param.setFarmNo(farmNo);
            param.setType("E");
            
            Map<String, Object> resultMap = adminService.getEggData(param);
            
            List<Farm> eggWorkList = (List<Farm>) resultMap.get("eggWorkList");
            
            model.addAttribute("eggWorkList", eggWorkList);
        }
        
        model.addAttribute("today", new Date());
        
        return "/adm/eggStatus";
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/adm/eggDetail")
    public String eggDetail(Model model, String serialNo, Integer farmNo, Integer workSeq) {
        User uparam = new User();
        //uparam.setPageNum(pageNum);
        uparam.setUserType("M");
        List<User> userList = userService.getMemberList(uparam);
        model.addAttribute("userList", userList);
        
        
        if (StringUtils.isNotEmpty(serialNo)) {
            Farm param = new Farm();
            param.setWorkSeq(workSeq);
            param.setSerialNo(serialNo);
            param.setFarmNo(farmNo);
            param.setType("E");
            
            Map<String, Object> resultMap = adminService.getEggDetail(param);
            
            List<Egg> eggList = (List<Egg>) resultMap.get("eggList");
            
            model.addAttribute("eggList", eggList);
        }
        
        
        model.addAttribute("today", new Date());
        
        return "/adm/eggDetail";
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/adm/farmStatus")
    public String farmStatus(Model model, String serialNo) {
        User uparam = new User();
        //uparam.setPageNum(pageNum);
        uparam.setUserType("M");
        List<User> userList = userService.getMemberList(uparam);
        model.addAttribute("userList", userList);
        
        if (StringUtils.isNotEmpty(serialNo)) {
            Farm param = new Farm();
            //param.setWorkSeq(workSeq);
            param.setSerialNo(serialNo);
            //param.setFarmNo(farmNo);
            param.setType("F");
            
            Map<String, Object> resultMap = adminService.getFarmData(param);
            
            List<Farm> farmWorkList = (List<Farm>) resultMap.get("farmWorkList");
            
            model.addAttribute("farmWorkList", farmWorkList);
        }
        
        return "/adm/farmStatus";
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/adm/farmDetail")
    public String farmDetail(Model model, String serialNo, Integer workSeq) {
        User uparam = new User();
        //uparam.setPageNum(pageNum);
        uparam.setUserType("M");
        List<User> userList = userService.getMemberList(uparam);
        model.addAttribute("userList", userList);
        
        
        if (StringUtils.isNotEmpty(serialNo)) {
            Farm param = new Farm();
            param.setWorkSeq(workSeq);
            param.setSerialNo(serialNo);
            param.setFarmNo(1);
            param.setType("E");
            
            Map<String, Object> resultMap = adminService.getFarmDetail(param);
            //Farm farm = (Farm) resultMap.get("farmInfo");
            List<Bin> binList = (List<Bin>) resultMap.get("binList");
            List<Fan> fanList = (List<Fan>) resultMap.get("fanList");
            List<Light> lightList = (List<Light>) resultMap.get("lightList");
            List<Thermometer> thermoList = (List<Thermometer>) resultMap.get("thermoList");
            
            //model.addAttribute("farm", farm);
            model.addAttribute("binList", binList);
            model.addAttribute("fanList", fanList);
            model.addAttribute("lightList", lightList);
            model.addAttribute("thermoList", thermoList);
        }
        
        model.addAttribute("today", new Date());
        
        return "/adm/farmDetail";
    }
    
    @RequestMapping("/adm/userStatus")
    public String userStatus(Model model, Integer pageNum) {
        User param = new User();
        param.setPageNum(pageNum);
        param.setUserType("M");
        List<User> userList = userService.getMemberList(param);
        
        model.addAttribute("userList", userList);
        model.addAttribute("today", new Date());
        
        return "/adm/userStatus";
    }
    
    @RequestMapping("/adm/confirmSerialNo")
    public View confirmSerialNo(Model model, String userId, String serialNo) {
        adminService.confirmSerialNo(userId, serialNo);
        
        return new MappingJackson2JsonView();
    }
    
    @RequestMapping("/adm/userDetail")
    public String userDetail(Model model, String userId) {
        User param = new User();
        param.setUserId(userId);
        param.setUserType("M");
        User user = userService.getUserById(userId);
        
        model.addAttribute("member", user);
        model.addAttribute("today", new Date());
        
        return "/adm/userDetail";
    }
    
    @RequestMapping("/adm/modifyUser.do") 
    public String modifyUser(Model model, User user, HttpServletRequest request, RedirectAttributes rAttributes) {
        user.setUserType(Constants.UserTypeMember);
        
        frontService.modifyUser(user, null, null);
        
        return "redirect:/adm/userStatus.do";
    }
}
