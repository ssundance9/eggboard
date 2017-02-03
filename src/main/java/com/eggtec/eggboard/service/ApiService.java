package com.eggtec.eggboard.service;

import java.util.List;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.ErrorCode;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;

public interface ApiService {
    void createEggInfo(List<Farm> farmList, List<Egg> eggList);

    void createFarmInfo(List<Farm> farmList, List<Bin> binList, List<Thermometer> thermoList, List<Light> lightList,
            List<Fan> fanList);

    void createErrorInfo(List<ErrorCode> errorList);

}
