package com.eggtec.eggboard.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
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
import org.springframework.web.multipart.MultipartFile;
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
        
        
        /*Map<String, Object> resultMap = adminService.getEggStatus(param, userId);
        Farm farm = (Farm) resultMap.get("farmInfo");
        List<Egg> eggList = (List<Egg>) resultMap.get("eggInfo");
        
        model.addAttribute("farm", farm);
        model.addAttribute("eggList", eggList);*/
        
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
        
        
        /*Map<String, Object> resultMap = adminService.getEggStatus(param, userId);
        Farm farm = (Farm) resultMap.get("farmInfo");
        List<Egg> eggList = (List<Egg>) resultMap.get("eggInfo");
        
        model.addAttribute("farm", farm);
        model.addAttribute("eggList", eggList);*/
        
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
        
        
        /*Farm param = new Farm();
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
        model.addAttribute("thermoList", thermoList);*/
        
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
        
        
        /*Map<String, Object> resultMap = adminService.getEggStatus(param, userId);
        Farm farm = (Farm) resultMap.get("farmInfo");
        List<Egg> eggList = (List<Egg>) resultMap.get("eggInfo");
        
        model.addAttribute("farm", farm);
        model.addAttribute("eggList", eggList);*/
        
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
        
        //MultipartFile uploadfile = user.getUploadFile();
        /*if (uploadfile != null && !uploadfile.isEmpty()) {
            String fileName = uploadfile.getOriginalFilename();
            
            user.setPhotoInfo(fileName);
            try {
                // 1. FileOutputStream 사용
                // byte[] fileData = file.getBytes();
                // FileOutputStream output = new FileOutputStream("C:/images/" + fileName);
                // output.write(fileData);
                 
                // 2. File 사용
                String uploadPath = request.getServletContext().getRealPath("/upload");
                String today = new SimpleDateFormat("/yyyyMMdd/").format(new Date());
                uploadPath = uploadPath + today + user.getUserId() + "/";
                File file = new File(uploadPath + fileName);
                if(!file.exists()) {
                    file.mkdirs();
                }
                uploadfile.transferTo(file);
                
                user.setPhotoInfo("/upload" + today + user.getUserId()  + "/" + fileName);
            } catch (IOException e) {
                e.printStackTrace();
            } // try - catch
        }*/ // if

        
        
        // 필터가 동작을 안함... 이유를 모르겠음 TODO
        try {
            user.setUserName(new String(user.getUserName().getBytes("iso-8859-1"), "utf-8"));
            user.setFarmName(new String(user.getFarmName().getBytes("iso-8859-1"), "utf-8"));
            user.setUserAddress1(new String(user.getUserAddress1().getBytes("iso-8859-1"), "utf-8"));
            user.setUserAddress2(new String(user.getUserAddress2().getBytes("iso-8859-1"), "utf-8"));
            
            user.setUserType("M");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        
        User member = frontService.modifyUser(user, null, null);
        
        return "redirect:/adm/userStatus.do";
    }
}
