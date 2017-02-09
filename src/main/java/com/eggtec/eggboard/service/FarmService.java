package com.eggtec.eggboard.service;

import java.util.List;
import java.util.Map;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.ErrorCode;
import com.eggtec.eggboard.model.Farm;

public interface FarmService {

    Map<String, Object> getFarmStatus(Farm param, String userid);

    List<Bin> getBinListByBin(Bin param);

    List<Farm> getWaterListByFarm(Farm param);
    
    String getErrorCode();

}
