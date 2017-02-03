package com.eggtec.eggboard.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Hen;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;
import com.eggtec.eggboard.model.User;
import com.eggtec.eggboard.service.FrontService;
import com.eggtec.eggboard.util.Constants;

@Controller
public class FrontController extends BaseController {
    Logger log = Logger.getLogger(this.getClass());
    
    @Inject
    FrontService frontService;
    
    /*@RequestMapping("/main")
    public String main() {
        return "redirect:/loginView.do";
    }*/
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/frt/eggStatus.do")
    public String eggStatus(Model model, Integer farmNo) {
        model.addAttribute("uri", super.getRequest().getRequestURI());
        
        User user = super.getUser();
        
        if (farmNo == null) {
            farmNo = 1;
        }
        
        Farm param = new Farm();
        param.setSerialNo(user.getSerialNo());
        param.setFarmNo(farmNo);
        param.setType(Constants.DataTypeEgg);
        
        Map<String, Object> resultMap = frontService.getEggStatus(param, user.getUserId());
        
        Farm farm = (Farm) resultMap.get("farmInfo");
        List<Egg> eggList = (List<Egg>) resultMap.get("eggInfo");
        List<Hen> henList = (List<Hen>) resultMap.get("henInfo");
        
        model.addAttribute("farm", farm);
        model.addAttribute("eggList", eggList);
        model.addAttribute("henList", henList);
        model.addAttribute("today", new Date());
        
        return getViewPrepix() + "/frt/eggStatus";
        
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/frt/eggStatistics.do")
    public String eggStatistics(Model model, Integer farmNo, String fromDate, String toDate) {
        model.addAttribute("uri", super.getRequest().getRequestURI());
        User user = super.getUser();
        Farm farm = null;
        List<Hen> henList = null;
        
        if (farmNo == null) {
            farmNo = 1;
        }
        
        Farm param = new Farm();
        param.setSerialNo(user.getSerialNo());
        param.setFarmNo(farmNo);
        param.setType(Constants.DataTypeEgg);
        
        // 날짜없으면 데이터 조회X.... 귀찮아서 노출만 안함
        if (StringUtils.isEmpty(fromDate) || StringUtils.isEmpty(toDate)) {
            //fromDate = this.getFromDate(-2);
            fromDate = this.getToDate();
            toDate = this.getToDate();
            
            Map<String, Object> resultMap = frontService.eggStatistics(param, user.getUserId(), fromDate, toDate);
            farm = (Farm) resultMap.get("farmInfo");
            henList = (List<Hen>) resultMap.get("henInfo");
            
        } else {
            fromDate = StringUtils.remove(fromDate, Constants.dateSeparator);
            toDate = StringUtils.remove(toDate, Constants.dateSeparator);
            
            Map<String, Object> resultMap = frontService.eggStatistics(param, user.getUserId(), fromDate, toDate);
            
            farm = (Farm) resultMap.get("farmInfo");
            henList = (List<Hen>) resultMap.get("henInfo");
            List<List<Egg>> list = (List<List<Egg>>) resultMap.get("statisticsInfo");
            Double maxVal = (Double) resultMap.get("maxVal");
            
            
            model.addAttribute("list", list);
            model.addAttribute("maxVal", maxVal);
        }
        
        model.addAttribute("farm", farm);
        model.addAttribute("henList", henList);
        model.addAttribute("today", new Date());
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        
        return getViewPrepix() + "/frt/eggStatus";
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/frt/farmStatus.do")
    public String farmStatus(Model model) {
        model.addAttribute("uri", super.getRequest().getRequestURI());
        User user = super.getUser();
        
        Farm param = new Farm();
        param.setSerialNo(user.getSerialNo());
        param.setFarmNo(1); // 고정번호
        param.setType(Constants.DataTypeFarm);
        
        Map<String, Object> resultMap = frontService.getFarmStatus(param, user.getUserId());
        Farm farm = (Farm) resultMap.get("farmInfo");
        List<Hen> henList = (List<Hen>) resultMap.get("henInfo");
        List<Bin> binList = (List<Bin>) resultMap.get("binInfo");
        List<Fan> fanList = (List<Fan>) resultMap.get("fanInfo");
        List<Light> lightList = (List<Light>) resultMap.get("lightInfo");
        List<Thermometer> thermoList = (List<Thermometer>) resultMap.get("thermoInfo");
        List<Farm> waterList = (List<Farm>) resultMap.get("waterInfo");
        
        String fromDateFarm = this.getFromDate(-2);
        String toDateFarm = this.getToDate();
        
        model.addAttribute("farm", farm);
        model.addAttribute("henList", henList);
        model.addAttribute("binList", binList);
        model.addAttribute("fanList", fanList);
        model.addAttribute("lightList", lightList);
        model.addAttribute("thermoList", thermoList);
        model.addAttribute("waterList", waterList);
        model.addAttribute("today", new Date());
        model.addAttribute("fromDateFarm", fromDateFarm);
        model.addAttribute("toDateFarm", toDateFarm);
        
        return getViewPrepix() + "/frt/eggStatus";
    }
    
    private String getFromDate(int add) {
        Calendar before3days = Calendar.getInstance();
        before3days.setTime(new Date());
        before3days.add(Calendar.DATE, add);
        
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
        return sf.format(before3days.getTime());
    }
    
    private String getToDate() {
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
        return sf.format(new Date());
    }
    
    @RequestMapping("/frt/searchBin.do")
    public String searhBin(Model model, String fromDateFarm, String toDateFarm) {
        User user = super.getUser();
        
        if (StringUtils.isEmpty(fromDateFarm) || StringUtils.isEmpty(toDateFarm)) {
            fromDateFarm = this.getFromDate(-2);
            toDateFarm = this.getToDate();
        } else {
            fromDateFarm = StringUtils.remove(fromDateFarm, Constants.dateSeparator);
            toDateFarm = StringUtils.remove(toDateFarm, Constants.dateSeparator);                
        }
        
        Bin param = new Bin();
        param.setSerialNo(user.getSerialNo());
        param.setFromDate(fromDateFarm);
        param.setToDate(toDateFarm);
        
        List<Bin> binList = frontService.getBinListByBin(param);
        model.addAttribute("binList", binList);
        
        return "/frt/resultBin";
    }
    
    @RequestMapping("/frt/searchWater.do")
    public String searhWater(Model model, String fromDateFarm, String toDateFarm) {
        User user = super.getUser();
        
        if (StringUtils.isEmpty(fromDateFarm) || StringUtils.isEmpty(toDateFarm)) {
            fromDateFarm = this.getFromDate(-2);
            toDateFarm = this.getToDate();
        } else {
            fromDateFarm = StringUtils.remove(fromDateFarm, Constants.dateSeparator);
            toDateFarm = StringUtils.remove(toDateFarm, Constants.dateSeparator);                
        }
        
        Farm param = new Farm();
        param.setSerialNo(user.getSerialNo());
        param.setFromDate(fromDateFarm);
        param.setToDate(toDateFarm);
        
        List<Farm> waterList = frontService.getWaterListByFarm(param);
        model.addAttribute("waterList", waterList);
        
        return "/frt/resultWater";
    }
    
    @RequestMapping("/frt/mypageView.do")
    public String mypageView(Model model) {
        User user = super.getUser();
        
        User member = frontService.getUserById(user.getUserId());
        
        model.addAttribute("member", member);
        model.addAttribute("today", new Date());
        
        return "/frt/mypageView";
    }
    
    @RequestMapping("/frt/modifyUser.do") 
    public String modifyUser(Model model, User user, String[] henCount, String[] entDt
            , HttpServletRequest request, RedirectAttributes rAttributes) {
        
        MultipartFile uploadfile = user.getUploadFile();
        if (uploadfile != null && !uploadfile.isEmpty()) {
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
        } // if

        
        
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
        
        
        User member = frontService.modifyUser(user, henCount, entDt);
        super.getSession().setAttribute("user", member);
        
        return "redirect:/frt/mypageView.do";
    }

}
