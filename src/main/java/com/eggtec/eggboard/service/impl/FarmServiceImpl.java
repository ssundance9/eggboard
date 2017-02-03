package com.eggtec.eggboard.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.eggtec.eggboard.dao.FarmDao;
import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Hen;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;
import com.eggtec.eggboard.service.EggService;
import com.eggtec.eggboard.service.FarmService;
import com.eggtec.eggboard.util.Constants;

@Service
public class FarmServiceImpl implements FarmService {
    
    @Inject
    FarmDao farmDao;
    
    @Inject
    EggService eggService;

    @Override
    public Map<String, Object> getFarmStatus(Farm param, String userId) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        
        Farm farm = eggService.getFarm(param);
        List<Hen> henList = eggService.getHenListById(userId);
        List<Bin> binList = farmDao.selectBinListByFarm(farm);
        List<Fan> fanList = farmDao.selectFanListByFarm(farm);
        List<Light> lightList = farmDao.selectLightListByFarm(farm);
        List<Thermometer> thermoList = farmDao.selectThermoListByFarm(farm);
        
        if (farm != null) {
            SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
            farm.setToday(sf.format(new Date()) + "000000");
            List<Farm> waterList = farmDao.selectTodayWaterListByFarm(farm);
            resultMap.put("waterInfo", waterList);
        }
        
        // 시설현황에서는 상태값을 안줘서 선별현황쪽 데이터로 대신
        param.setType(Constants.DataTypeEgg);
        farm = eggService.getFarmJustNow(param);
        
        resultMap.put("farmInfo", farm);
        resultMap.put("henInfo", henList);
        resultMap.put("binInfo", binList);
        resultMap.put("fanInfo", fanList);
        resultMap.put("lightInfo", lightList);
        resultMap.put("thermoInfo", thermoList);
        
        return resultMap;
    }

    @Override
    public List<Bin> getBinListByBin(Bin param) {
        return farmDao.selectBinListByBin(param);
    }

    @Override
    public List<Farm> getWaterListByFarm(Farm param) {
        return farmDao.selectWaterListByFarm(param);
    }
}
