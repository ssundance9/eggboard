package com.eggtec.eggboard.dao;

import java.util.List;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;

public interface FarmDao {

    List<Egg> selectEggListByFarm(Farm farm);

    List<Bin> selectBinListByFarm(Farm farm);

    List<Fan> selectFanListByFarm(Farm farm);

    List<Light> selectLightListByFarm(Farm farm);

    List<Thermometer> selectThermoListByFarm(Farm farm);

    List<Farm> selectTodayWaterListByFarm(Farm farm);

    List<Bin> selectBinListByBin(Bin param);

    List<Farm> selectWaterListByFarm(Farm param);
}
