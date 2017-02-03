package com.eggtec.eggboard.service;

import java.util.List;
import java.util.Map;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.User;

public interface FrontService {

    Map<String, Object> getEggStatus(Farm param, String userId);

    Map<String, Object> eggStatistics(Farm param, String userId, String fromDate, String toDate);

    Map<String, Object> getFarmStatus(Farm param, String userId);

    List<Bin> getBinListByBin(Bin param);

    List<Farm> getWaterListByFarm(Farm param);

    User getUserById(String userId);

    User modifyUser(User user, String[] henCount, String[] entDt);

}
