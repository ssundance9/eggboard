package com.eggtec.eggboard.dao.impl;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.eggtec.eggboard.dao.AdminDao;
import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;

@Repository
public class AdminDaoImpl implements AdminDao {
    
    
    /*@Inject
    private SqlSession sqlSession;

    @Override
    public Farm selectFarm(Farm param) {
        return sqlSession.selectOne("AdminDao.selectFarm", param);
    }

    @Override
    public List<Egg> selectEggListByFarm(Farm farm) {
        return sqlSession.selectList("AdminDao.selectEggListByFarm", farm);
    }

    @Override
    public List<Bin> selectBinListByFarm(Farm farm) {
        return sqlSession.selectList("AdminDao.selectBinListByFarm", farm);
    }

    @Override
    public List<Fan> selectFanListByFarm(Farm farm) {
        return sqlSession.selectList("AdminDao.selectFanListByFarm", farm);
    }

    @Override
    public List<Light> selectLightListByFarm(Farm farm) {
        return sqlSession.selectList("AdminDao.selectLightListByFarm", farm);
    }

    @Override
    public List<Thermometer> selectThermoListByFarm(Farm farm) {
        return sqlSession.selectList("AdminDao.selectThermoListByFarm", farm);
    }*/

}
