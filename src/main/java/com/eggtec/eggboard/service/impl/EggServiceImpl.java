package com.eggtec.eggboard.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.eggtec.eggboard.dao.EggDao;
import com.eggtec.eggboard.model.Code;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Hen;
import com.eggtec.eggboard.service.EggService;

@Service
public class EggServiceImpl implements EggService {
    
    @Inject
    EggDao eggDao;
    
    @Override
    public Map<String, Object> getEggStatus(Farm param, String userId) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        
        Farm farm = eggDao.selectFarmJustNow(param);
        List<Egg> eggList = eggDao.selectEggListByFarm(farm);
        List<Hen> henList = eggDao.selectHenListById(userId);
        
        resultMap.put("farmInfo", farm);
        resultMap.put("eggInfo", eggList);
        resultMap.put("henInfo", henList);
        
        return resultMap;
    }

    @Override
    public Farm getFarm(Farm param) {
        return eggDao.selectFarm(param);
    }

    @Override
    public List<Egg> getEggListByFarm(Farm farm) {
        return eggDao.selectEggListByFarm(farm);
    }
    
    @Override
    public List<Hen> getHenListById(String userId) {
        return eggDao.selectHenListById(userId);
    }

    @Override
    public Map<String, Object> eggStatistics(Farm param, String userId, String fromDate, String toDate) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        
        Farm farm = eggDao.selectFarm(param);
        List<Hen> henList = eggDao.selectHenListById(userId);
        
        List<List<Egg>> list = new ArrayList<List<Egg>>();
        List<Code> codeList = eggDao.selectCodeListByCodeGroup("grade");
        List<Double> maxValList = new ArrayList<Double>();
        
        
        
        for (int i = 0; i < codeList.size(); i++) {
            Code c = codeList.get(i);
            Egg e = new Egg();
            e.setSerialNo(param.getSerialNo());
            e.setFarmNo(param.getFarmNo());
            e.setGrade(c.getCodeValue());
            e.setFromDate(fromDate);
            e.setToDate(toDate);
            e.setDateList(this.getDateList(fromDate, toDate));
            
            
            List<Egg> eggList = eggDao.selectEggListByEgg(e);
            if (!eggList.isEmpty()) {
                maxValList.add(this.getMaxValue(eggList));
                list.add(eggList);
            }
        }
        
        resultMap.put("farmInfo", farm);
        resultMap.put("henInfo", henList);
        resultMap.put("statisticsInfo", list);
        if (!maxValList.isEmpty()) {
            resultMap.put("maxVal", Collections.max(maxValList)); // 그래프 Y축 최대값
        }
        
        return resultMap;
    }
    
    private List<String> getDateList(String fromDate, String toDate) {
        try {
            List<String> dateList = new ArrayList<String>();
            SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
        
            Date fromD = sf.parse(fromDate);
            Date toD = sf.parse(toDate);
            
            Calendar from = Calendar.getInstance(); 
            from.setTime(fromD);
            Calendar to = Calendar.getInstance(); 
            to.setTime(toD);
            
            dateList.add(fromDate);
            
            //while (from.compareTo(to) == 0) {
            for (int i = 0; i < 7; i++) {
                from.add(Calendar.DATE, 1);
                dateList.add(sf.format(from.getTime()));
            }
            
            return dateList;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    private double getMaxValue(List<Egg> list) {
        List<Double> l = new ArrayList<Double>();
        
        for (Egg e : list) {
            l.add(e.getProdRatio());
        }
        
        return Collections.max(l);
    }

    @Override
    public Farm getFarmJustNow(Farm param) {
        return eggDao.selectFarmJustNow(param);
    }

    

}
