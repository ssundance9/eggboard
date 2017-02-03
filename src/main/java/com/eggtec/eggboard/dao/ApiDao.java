package com.eggtec.eggboard.dao;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.ErrorCode;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;

public interface ApiDao {
	
	void insertFarm(Farm farm);
	
	void insertEgg(Egg egg);

    void insertBin(Bin b);

    void insertThermo(Thermometer t);

    void insertLight(Light l);

    void insertFan(Fan f);

    void selectFarm();

    int selectWorkSeq();

    void insertErrorCode(ErrorCode e);
}
