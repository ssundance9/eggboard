package com.eggtec.eggboard.dao.impl;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.eggtec.eggboard.dao.FarmDao;
import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;

@Repository
public class FarmDaoImpl implements FarmDao {
    
    @Inject
    private SqlSession sqlSession;
    
    @Override
    public List<Egg> selectEggListByFarm(Farm farm) {
        return sqlSession.selectList("FarmDao.selectEggListByFarm", farm);
    }

    @Override
    public List<Bin> selectBinListByFarm(Farm farm) {
        return sqlSession.selectList("FarmDao.selectBinListByFarm", farm);
    }

    @Override
    public List<Fan> selectFanListByFarm(Farm farm) {
        return sqlSession.selectList("FarmDao.selectFanListByFarm", farm);
    }

    @Override
    public List<Light> selectLightListByFarm(Farm farm) {
        return sqlSession.selectList("FarmDao.selectLightListByFarm", farm);
    }

    @Override
    public List<Thermometer> selectThermoListByFarm(Farm farm) {
        return sqlSession.selectList("FarmDao.selectThermoListByFarm", farm);
    }

    @Override
    public List<Farm> selectTodayWaterListByFarm(Farm farm) {
        return sqlSession.selectList("FarmDao.selectTodayWaterListByFarm", farm);
    }

    @Override
    public List<Bin> selectBinListByBin(Bin param) {
        return sqlSession.selectList("FarmDao.selectBinListByBin", param);
    }

    @Override
    public List<Farm> selectWaterListByFarm(Farm param) {
        return sqlSession.selectList("FarmDao.selectWaterListByFarm", param);
    }
}
