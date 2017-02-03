package com.eggtec.eggboard.service;

import java.util.Map;

import com.eggtec.eggboard.model.Farm;

public interface AdminService {

    Map<String, Object> getEggStatus(Farm param, String userId);

    Map<String, Object> getFarmStatus(Farm param, String userId);

    void confirmSerialNo(String userId, String serialNo);

}
