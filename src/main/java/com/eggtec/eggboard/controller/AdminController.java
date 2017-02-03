package com.eggtec.eggboard.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;
import com.eggtec.eggboard.model.User;
import com.eggtec.eggboard.service.AdminService;
import com.eggtec.eggboard.service.UserService;

@Controller
public class AdminController {
    Logger log = Logger.getLogger(this.getClass());
    
    @Inject
    AdminService adminService;
    
    @Inject
    UserService userService;
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/eggStatus")
    public String eggStatus(Model model, String serialNo, Integer farmNo, String userId) {
        Farm param = new Farm();
        param.setSerialNo(serialNo);
        param.setFarmNo(farmNo);
        param.setType("E");
        
        Map<String, Object> resultMap = adminService.getEggStatus(param, userId);
        Farm farm = (Farm) resultMap.get("farmInfo");
        List<Egg> eggList = (List<Egg>) resultMap.get("eggInfo");
        
        model.addAttribute("farm", farm);
        model.addAttribute("eggList", eggList);
        
        return "/adm/eggStatus";
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/farmStatus")
    public String farmStatus(Model model, String serialNo, Integer farmNo) {
        Farm param = new Farm();
        param.setSerialNo(serialNo);
        param.setFarmNo(1); // 임시번호
        param.setType("F");
        
        Map<String, Object> resultMap = adminService.getFarmStatus(param, null);
        Farm farm = (Farm) resultMap.get("farmInfo");
        List<Bin> binList = (List<Bin>) resultMap.get("binInfo");
        List<Fan> fanList = (List<Fan>) resultMap.get("fanInfo");
        List<Light> lightList = (List<Light>) resultMap.get("lightInfo");
        List<Thermometer> thermoList = (List<Thermometer>) resultMap.get("thermoInfo");
        
        model.addAttribute("farm", farm);
        model.addAttribute("binList", binList);
        model.addAttribute("fanList", fanList);
        model.addAttribute("lightList", lightList);
        model.addAttribute("thermoList", thermoList);
        
        return "/adm/farmStatus";
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
}
