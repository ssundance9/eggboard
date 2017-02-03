package com.eggtec.eggboard.model;

import java.util.Date;

public class Hen {
    private String userId;
    
    private int farmNo;
    
    private int henCount;
    
    private String entDt;
    
    private Date regDtm;

    private Date modDtm;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getFarmNo() {
        return farmNo;
    }

    public void setFarmNo(int farmNo) {
        this.farmNo = farmNo;
    }

    public int getHenCount() {
        return henCount;
    }

    public void setHenCount(int henCount) {
        this.henCount = henCount;
    }

    public String getEntDt() {
        return entDt;
    }

    public void setEntDt(String entDt) {
        this.entDt = entDt;
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
}
