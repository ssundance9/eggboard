package com.eggtec.eggboard.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

/**
 * 회원
 */
public class User extends Page implements Serializable {

    private static final long serialVersionUID = 1L;

    private String userId;

    private String userPw;

    private String userName;

    private String userMphone1;

    private String userMphone2;

    private String userMphone3;
    
    private String userEmail;
    
    private String userAddress1;
    
    private String userAddress2;
    
    private String farmName;
    
    private String photoInfo;
    
    private String userType;

    private String serialNo;
    
    private Date confirmDtm;

    private Date regDtm;

    private Date modDtm;
    
    private MultipartFile uploadFile;
    
    private String userMphone;
    
    private List<Hen> henList;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getRegDtm() {
        return regDtm;
    }

    public void setRegDtm(Date regDtm) {
        this.regDtm = regDtm;
    }

    public Date getModDtm() {
        return modDtm;
    }

    public void setModDtm(Date modDtm) {
        this.modDtm = modDtm;
    }

    public String getUserPw() {
        return userPw;
    }

    public void setUserPw(String userPw) {
        this.userPw = userPw;
    }

    public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }

    public String getUserMphone1() {
        return userMphone1;
    }

    public void setUserMphone1(String userMphone1) {
        this.userMphone1 = userMphone1;
    }

    public String getUserMphone2() {
        return userMphone2;
    }

    public void setUserMphone2(String userMphone2) {
        this.userMphone2 = userMphone2;
    }

    public String getUserMphone3() {
        return userMphone3;
    }

    public void setUserMphone3(String userMphone3) {
        this.userMphone3 = userMphone3;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserAddress1() {
        return userAddress1;
    }

    public void setUserAddress1(String userAddress1) {
        this.userAddress1 = userAddress1;
    }

    public String getUserAddress2() {
        return userAddress2;
    }

    public void setUserAddress2(String userAddress2) {
        this.userAddress2 = userAddress2;
    }

    public String getFarmName() {
        return farmName;
    }

    public void setFarmName(String farmName) {
        this.farmName = farmName;
    }

    public String getPhotoInfo() {
        return photoInfo;
    }

    public void setPhotoInfo(String photoInfo) {
        this.photoInfo = photoInfo;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public Date getConfirmDtm() {
        return confirmDtm;
    }

    public void setConfirmDtm(Date confirmDtm) {
        this.confirmDtm = confirmDtm;
    }

    public MultipartFile getUploadFile() {
        return uploadFile;
    }

    public void setUploadFile(MultipartFile uploadFile) {
        this.uploadFile = uploadFile;
    }

    public String getUserMphone() {
        return userMphone;
    }

    public void setUserMphone(String userMphone) {
        this.userMphone = userMphone;
    }

    public List<Hen> getHenList() {
        return henList;
    }

    public void setHenList(List<Hen> henList) {
        this.henList = henList;
    }
    
    
}
