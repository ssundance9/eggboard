package com.eggtec.eggboard.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.eggtec.eggboard.dao.FarmDao;
import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.ErrorCode;
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
        
        Farm farm = eggService.getFarmJustNow(param);
        List<Hen> henList = eggService.getHenListById(userId);
        List<Bin> binList = farmDao.selectBinListByFarm(farm);
        List<Fan> fanList = farmDao.selectFanListByFarm(farm);
        List<Light> lightList = farmDao.selectLightListByFarm(farm);
        List<Thermometer> thermoList = farmDao.selectThermoListByFarm(farm);
        
        //if (farm != null) {
            SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
            param.setToday(sf.format(new Date()) + "000000");
            param.setType(Constants.DataTypeWater);
            List<Farm> waterList = farmDao.selectTodayWaterListByFarm(param);
            resultMap.put("waterInfo", waterList);
        //}
        
        // 시설현황에서는 상태값을 안줘서 선별현황쪽 데이터로 대신 >> 주는 것으로 바뀜
        //param.setType(Constants.DataTypeEgg);
        //farm = eggService.getFarmJustNow(param);
        String errorCode = this.getErrorCode();
        
        resultMap.put("farmInfo", farm);
        resultMap.put("henInfo", henList);
        resultMap.put("binInfo", binList);
        resultMap.put("fanInfo", fanList);
        resultMap.put("lightInfo", lightList);
        resultMap.put("thermoInfo", thermoList);
        resultMap.put("errorInfo", errorCode);
        
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

    @Override
    public String getErrorCode() {
        List<ErrorCode> errorList = farmDao.selectErrorList();
        String[] codeArr = new String[errorList.size()];
        
        for (int i = 0; i < errorList.size(); i++) {
            codeArr[i] = errorList.get(i).getErrorCode();
        }
        
        if (codeArr.length > 0) {
            return StringUtils.join(codeArr, ",");
        }
        
        return null;
    }

    @Override
    public List<Farm> getFarmWorkList(Farm param) {
        return farmDao.selectFarmWorkList(param);
    }

    @Override
    public List<Bin> getBinListByFarm(Farm param) {
        return farmDao.selectBinListByFarm(param);
    }

    @Override
    public List<Fan> getFanListByFarm(Farm param) {
        return farmDao.selectFanListByFarm(param);
    }

    @Override
    public List<Light> getLightListByFarm(Farm param) {
        return farmDao.selectLightListByFarm(param);
    }

    @Override
    public List<Thermometer> getThermoListByFarm(Farm param) {
        return farmDao.selectThermoListByFarm(param);
    }
}
