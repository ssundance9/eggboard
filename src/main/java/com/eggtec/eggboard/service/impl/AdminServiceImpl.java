package com.eggtec.eggboard.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.eggtec.eggboard.dao.AdminDao;
import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;
import com.eggtec.eggboard.model.User;
import com.eggtec.eggboard.service.AdminService;
import com.eggtec.eggboard.service.EggService;
import com.eggtec.eggboard.service.FarmService;
import com.eggtec.eggboard.service.UserService;

@Service
public class AdminServiceImpl implements AdminService {
    @Inject
    UserService userService;
    
    @Inject
    EggService eggService;
    
    @Inject
    FarmService farmService;

    @Inject
    AdminDao adminDao;
    
    @Override
    public Map<String, Object> getEggStatus(Farm param, String userId) {
        return eggService.getEggStatus(param, userId);
    }

    @Override
    public Map<String, Object> getFarmStatus(Farm param, String userId) {
        return farmService.getFarmStatus(param, userId);
        
        /*Map<String, Object> resultMap = new HashMap<String, Object>();
        
        Farm farm = adminDao.selectFarm(param);
        List<Bin> binList = adminDao.selectBinListByFarm(farm);
        List<Fan> fanList = adminDao.selectFanListByFarm(farm);
        List<Light> lightList = adminDao.selectLightListByFarm(farm);
        List<Thermometer> thermoList = adminDao.selectThermoListByFarm(farm);
        
        resultMap.put("farmInfo", farm);
        resultMap.put("binInfo", binList);
        resultMap.put("fanInfo", fanList);
        resultMap.put("lightInfo", lightList);
        resultMap.put("thermoInfo", thermoList);
        
        return resultMap;*/
    }

    @Override
    public void confirmSerialNo(String userId, String serialNo) {
        User user = userService.getUserById(userId);
        user.setSerialNo(serialNo);
        user.setConfirmDtm(new Date());
        
        userService.modifyUser(user);
        
    }

    @Override
    public Map<String, Object> getEggData(Farm param) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        
        List<Farm> eggWorkList = eggService.getEggWorkList(param);
        resultMap.put("eggWorkList", eggWorkList);
        
        return resultMap;
    }

    @Override
    public Map<String, Object> getEggDetail(Farm param) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        
        List<Egg> eggList = eggService.getEggListByFarm(param);
        resultMap.put("eggList", eggList);
        
        return resultMap;
    }

    @Override
    public Map<String, Object> getFarmData(Farm param) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        
        List<Farm> farmWorkList = farmService.getFarmWorkList(param);
        resultMap.put("farmWorkList", farmWorkList);
        
        return resultMap;
    }

    @Override
    public Map<String, Object> getFarmDetail(Farm param) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        
        List<Bin> binList = farmService.getBinListByFarm(param);
        List<Fan> fanList = farmService.getFanListByFarm(param);
        List<Light> lightList = farmService.getLightListByFarm(param);
        List<Thermometer> thermoList = farmService.getThermoListByFarm(param);
        
        resultMap.put("binList", binList);
        resultMap.put("fanList", fanList);
        resultMap.put("lightList", lightList);
        resultMap.put("thermoList", thermoList);
        
        return resultMap;
    }

}
