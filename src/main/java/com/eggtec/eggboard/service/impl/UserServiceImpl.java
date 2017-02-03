package com.eggtec.eggboard.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.eggtec.eggboard.dao.UserDao;
import com.eggtec.eggboard.model.Hen;
import com.eggtec.eggboard.model.User;
import com.eggtec.eggboard.service.UserService;
import com.eggtec.eggboard.util.Constants;

@Service
public class UserServiceImpl implements UserService {
    @Inject
    UserDao userDao;

    @Override
    public boolean getIdForDupl(String id) {
        User user = userDao.selectUserById(id);
        
        if (user == null) {
            return false;
        }
        
        return true;
    }

    @Override
    public boolean getEmailForDupl(String email) {
        User user = userDao.selectUserByEmail(email);
        
        if (user == null) {
            return false;
        }
        
        return true;
    }

    @Override
    public User createUser(User user, String[] henCountArray, String[] entDtArray) {
        userDao.insertUser(user);
        
        for (int i = 0; i < henCountArray.length; i++) {
            Hen hen = new Hen();
            hen.setUserId(user.getUserId());
            hen.setFarmNo(i + 1);
            hen.setHenCount(Integer.parseInt(henCountArray[i]));
            hen.setEntDt(StringUtils.remove(entDtArray[i], Constants.dateSeparator));
            
            userDao.insertHen(hen);
        }
        
        return userDao.selectUserById(user.getUserId());
    }

    @Override
    public User getUserById(String userId) {
        return userDao.selectUserById(userId);
    }

    @Override
    public List<User> getMemberList(User user) {
        return userDao.selectUserList(user);
    }

    @Override
    public void modifyUser(User user) {
        userDao.updateUserSerialNo(user);
    }

    @Override
    public User modifyUser(User user, String[] henCountArray, String[] entDtArray) {
        userDao.updateUser(user);
        
        userDao.deleteHenById(user.getUserId());
        for (int i = 0; i < henCountArray.length; i++) {
            Hen hen = new Hen();
            hen.setUserId(user.getUserId());
            hen.setFarmNo(i + 1);
            hen.setHenCount(Integer.parseInt(henCountArray[i]));
            hen.setEntDt(StringUtils.remove(entDtArray[i], Constants.dateSeparator));
            
            userDao.insertHen(hen);
        }
        
        return userDao.selectUserById(user.getUserId());
    }

}
