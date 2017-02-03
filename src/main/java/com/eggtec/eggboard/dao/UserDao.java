package com.eggtec.eggboard.dao;

import java.util.List;

import com.eggtec.eggboard.model.Hen;
import com.eggtec.eggboard.model.User;

public interface UserDao {

    /**
     * 아이디로 회원 조회
     * @param id
     * @return
     */
    User selectUserById(String id);

    
    /**
     * 이메일로 회원 조회
     * @param email
     * @return
     */
    User selectUserByEmail(String email);

    /**
     * 회원 저장
     * @param user
     */
    void insertUser(User user);

    /**
     * 계사정보 저장
     * @param hen
     */
    void insertHen(Hen hen);


    /**
     * 회원목록
     * @param user
     * @return
     */
    List<User> selectUserList(User user);


    /**
     * 회원수정
     * @param user
     */
    void updateUser(User user);


    void deleteHenById(String userId);


    void updateUserSerialNo(User user);

}
