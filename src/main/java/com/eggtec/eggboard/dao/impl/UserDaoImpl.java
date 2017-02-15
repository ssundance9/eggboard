package com.eggtec.eggboard.dao.impl;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.eggtec.eggboard.dao.UserDao;
import com.eggtec.eggboard.model.Hen;
import com.eggtec.eggboard.model.User;

@Repository
public class UserDaoImpl implements UserDao {
    @Inject
    private SqlSession sqlSession;

    @Override
    public User selectUserById(String id) {
        return sqlSession.selectOne("UserDao.selectUserById", id);
    }

    @Override
    public User selectUserByEmail(String email) {
        return sqlSession.selectOne("UserDao.selectUserByEmail", email);
    }

    @Override
    public void insertUser(User user) {
        sqlSession.insert("UserDao.insertUser", user);
    }

    @Override
    public void insertHen(Hen hen) {
        sqlSession.insert("UserDao.insertHen", hen);
    }

    @Override
    public List<User> selectUserList(User user) {
        //int offset = this.pageSize * this.pageNumber;
        //int limit  = this.pageSize;
        //RowBounds rb = new RowBounds(offset, limit);
        
        //return sqlSession.selectList("UserDao.selectUserList", user, new RowBounds(user.getListSize() * (user.getPageNum() - 1), user.getListSize()));
        return sqlSession.selectList("UserDao.selectUserList", user);
    }

    @Override
    public void updateUser(User user) {
        sqlSession.update("UserDao.updateUser", user);
    }

    @Override
    public void deleteHenById(String userId) {
        sqlSession.delete("UserDao.deleteHenById", userId);
    }

    @Override
    public void updateUserSerialNo(User user) {
        sqlSession.update("UserDao.updateUserSerialNo", user);
    }

}
