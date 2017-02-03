package com.eggtec.eggboard.dao;

import java.util.List;

import com.eggtec.eggboard.model.Code;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Hen;

public interface EggDao {

    Farm selectFarm(Farm param);

    List<Egg> selectEggListByFarm(Farm farm);

    List<Hen> selectHenListById(String userId);

    List<Code> selectCodeListByCodeGroup(String string);

    List<Egg> selectEggListByEgg(Egg e);

    Farm selectFarmJustNow(Farm param);

}
