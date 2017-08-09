package com.eggtec.eggboard.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.eggtec.eggboard.dao.ApiDao;
import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.ErrorCode;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;
import com.eggtec.eggboard.service.ApiService;
import com.eggtec.eggboard.service.FarmService;

@Service
public class ApiServiceImpl implements ApiService {
    @Inject
    FarmService farmService;
    
    @Inject
    ApiDao apiDao;

    @Override
    public void createEggInfo(List<Farm> farmList, List<Egg> eggList) {
        int workSeq = apiDao.selectWorkSeq();
        
        for (Farm f : farmList) {
            f.setWorkSeq(workSeq);
            apiDao.insertFarm(f);
        }
        
        for (Egg e : eggList) {
            e.setWorkSeq(workSeq);
            apiDao.insertEgg(e);
        }
    }

    @Override
    public void createFarmInfo(List<Farm> farmList, List<Bin> binList, List<Thermometer> thermoList,
            List<Light> lightList, List<Fan> fanList) {
        int workSeq = apiDao.selectWorkSeq();
        String serialNo = "";
        
        for (Farm f : farmList) {
            f.setWorkSeq(workSeq);
            serialNo = f.getSerialNo();
            apiDao.insertFarm(f);
        }
        
        // 6개가 아니면 6개로 맞춰줌 -1 세팅
        for (int i = 1; i < 7; i++) {
            Bin bin = this.getBin(i, binList);
            if (bin == null) {
                bin = new Bin();
                bin.setWorkSeq(workSeq);
                bin.setSerialNo(serialNo);
                bin.setBinNo(i);
                bin.setCurrentWeight(-1D);
                apiDao.insertBin(bin);
            } else {
                bin.setWorkSeq(workSeq);
                apiDao.insertBin(bin);
            }
        }
        
        for (Thermometer t : thermoList) {
            t.setWorkSeq(workSeq);
            apiDao.insertThermo(t);
        }
        
        for (Light l : lightList) {
            l.setWorkSeq(workSeq);
            apiDao.insertLight(l);
        }
        
        for (Fan f : fanList) {
            f.setWorkSeq(workSeq);
            apiDao.insertFan(f);
        }
    }
    
    private Bin getBin(int i, List<Bin> binList) {
        Bin r = null;
        for (Bin b : binList) {
            if (b.getBinNo() == i) {
                r = b;
                break;
            }
        }
        
        return r;
    }

    @Override
    public void createErrorInfo(List<ErrorCode> errorList) {
        int workSeq = apiDao.selectWorkSeq();
        
        for (ErrorCode e : errorList) {
            e.setWorkSeq(workSeq);
            apiDao.insertErrorCode(e);
        }
    }

    @Override
    public void createWaterInfo(Farm farmObj) {
        int workSeq = apiDao.selectWorkSeq();
        farmObj.setWorkSeq(workSeq);
        
        apiDao.insertFarm(farmObj);
    }
	
}
