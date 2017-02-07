package com.eggtec.eggboard.service;

import java.util.List;

import com.eggtec.eggboard.model.User;

public interface UserService {

    /**
     * 아이디 중복 체크 - 중복이면 true
     * @param id
     * @return
     */
    boolean getIdForDupl(String id);

    /**
     * 이메일 중복 체크 - 중복이면 true
     * @param email
     * @return
     */
    boolean getEmailForDupl(String email);

    /**
     * 회원 등록
     * @param user
     * @param henCount
     * @param entDt
     * @return
     */
    User createUser(User user, String[] henCount, String[] entDt);

    /**
     * 아이디로 회원조회
     * @param userId
     * @return
     */
    User getUserById(String userId);

    /**
     * 회원 목록
     * @param user
     * @return
     */
    List<User> getMemberList(User user);

    /**
     * 회원 수정
     * @param user
     */
    void modifyUser(User user);

    User modifyUser(User user, String[] henCount, String[] entDt);

    List<User> getUserList(User param);

}
