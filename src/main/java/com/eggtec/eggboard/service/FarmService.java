package com.eggtec.eggboard.service;

import java.util.List;
import java.util.Map;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.ErrorCode;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;

public interface FarmService {

    Map<String, Object> getFarmStatus(Farm param, String userid);

    List<Bin> getBinListByBin(Bin param);

    List<Farm> getWaterListByFarm(Farm param);
    
    String getErrorCode();

    List<Farm> getFarmWorkList(Farm param);

    List<Bin> getBinListByFarm(Farm param);

    List<Fan> getFanListByFarm(Farm param);

    List<Light> getLightListByFarm(Farm param);

    List<Thermometer> getThermoListByFarm(Farm param);

}
