package com.eggtec.eggboard.service;

import java.util.List;
import java.util.Map;

import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Hen;

public interface EggService {
    
    Map<String, Object> getEggStatus(Farm param, String userId);

    Farm getFarm(Farm param);

    List<Egg> getEggListByFarm(Farm farm);
    
    List<Hen> getHenListById(String userId);

    Map<String, Object> eggStatistics(Farm param, String userId, String fromDate, String toDate);

    Farm getFarmJustNow(Farm param);

    

}
