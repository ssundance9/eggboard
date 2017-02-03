package com.eggtec.eggboard.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.User;
import com.eggtec.eggboard.service.EggService;
import com.eggtec.eggboard.service.FarmService;
import com.eggtec.eggboard.service.FrontService;
import com.eggtec.eggboard.service.UserService;
import com.eggtec.eggboard.util.Constants;

@Service
public class FrontServiceImpl implements FrontService {
    
    @Inject
    EggService eggService;
    
    @Inject
    FarmService farmService;
    
    @Inject
    UserService userService;

    @Override
    public Map<String, Object> getEggStatus(Farm param, String userId) {
        return eggService.getEggStatus(param, userId);
    }

    @Override
    public Map<String, Object> eggStatistics(Farm param, String userId, String fromDate, String toDate) {
        return eggService.eggStatistics(param, userId, fromDate, toDate);
    }

    @Override
    public Map<String, Object> getFarmStatus(Farm param, String userId) {
        return farmService.getFarmStatus(param, userId);
    }

    @Override
    public List<Bin> getBinListByBin(Bin param) {
        return farmService.getBinListByBin(param);
    }

    @Override
    public List<Farm> getWaterListByFarm(Farm param) {
        return farmService.getWaterListByFarm(param);
    }

    @Override
    public User getUserById(String userId) {
        User user = userService.getUserById(userId);
        user.setHenList(eggService.getHenListById(userId));
        
        return user;
    }

    @Override
    public User modifyUser(User user, String[] henCount, String[] entDt) {
        return userService.modifyUser(user, henCount, entDt);
    }
}
