package com.eggtec.eggboard.dao.impl;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.eggtec.eggboard.dao.ApiDao;
import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.ErrorCode;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;

@Repository
public class ApiDaoImpl implements ApiDao {
    @Inject
    private SqlSession sqlSession;
    
    @Override
    public void selectFarm() {
        sqlSession.selectOne("ApiDao.selectFarm");
    }
    
	@Override
	public void insertFarm(Farm farm) {
	    sqlSession.insert("ApiDao.insertFarm", farm);
	}

	@Override
	public void insertEgg(Egg egg) {
	    sqlSession.insert("ApiDao.insertEgg", egg);
	}

    @Override
    public void insertBin(Bin bin) {
        sqlSession.insert("ApiDao.insertBin", bin);
    }

    @Override
    public void insertThermo(Thermometer thermo) {
        sqlSession.insert("ApiDao.insertThermo", thermo);
    }

    @Override
    public void insertLight(Light light) {
        sqlSession.insert("ApiDao.insertLight", light);
    }

    @Override
    public void insertFan(Fan fan) {
        sqlSession.insert("ApiDao.insertFan", fan);
    }

    @Override
    public int selectWorkSeq() {
        return sqlSession.selectOne("ApiDao.selectWorkSeq");
    }

    @Override
    public void insertErrorCode(ErrorCode error) {
        sqlSession.insert("ApiDao.insertErrorCode", error);
    }
}
