package com.eggtec.eggboard.dao.impl;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.eggtec.eggboard.dao.EggDao;
import com.eggtec.eggboard.model.Code;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Hen;

@Service
public class EggDaoImpl implements EggDao {
    
    @Inject
    private SqlSession sqlSession;

    @Override
    public Farm selectFarm(Farm param) {
        return sqlSession.selectOne("EggDao.selectFarm", param);
    }

    @Override
    public List<Egg> selectEggListByFarm(Farm farm) {
        return sqlSession.selectList("EggDao.selectEggListByFarm", farm);
    }

    @Override
    public List<Hen> selectHenListById(String userId) {
        return sqlSession.selectList("EggDao.selectHenListById", userId);
    }

    @Override
    public List<Code> selectCodeListByCodeGroup(String group) {
        return sqlSession.selectList("EggDao.selectCodeListByCodeGroup", group);
    }

    @Override
    public List<Egg> selectEggListByEgg(Egg egg) {
        return sqlSession.selectList("EggDao.selectEggListByEgg", egg);
    }

    @Override
    public Farm selectFarmJustNow(Farm param) {
        return sqlSession.selectOne("EggDao.selectFarmJustNow", param);
    }

    @Override
    public List<Farm> selectEggWorkList(Farm param) {
        return sqlSession.selectList("EggDao.selectEggWorkList", param);
    }

}
