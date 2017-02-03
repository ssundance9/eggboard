package com.eggtec.eggboard.model;

import java.util.Date;

/**
 * 환풍기
 */
public class Fan {

    private int workSeq;

    private String serialNo;

    private int farmNo;

    private int fanNo;

    private String status;

    private Date regDtm;

    private Date modDtm;

    public int getWorkSeq() {
        return workSeq;
    }

    public void setWorkSeq(int workSeq) {
        this.workSeq = workSeq;
    }

    public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }

    public int getFarmNo() {
        return farmNo;
    }

    public void setFarmNo(int farmNo) {
        this.farmNo = farmNo;
    }

    public int getFanNo() {
        return fanNo;
    }

    public void setFanNo(int fanNo) {
        this.fanNo = fanNo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
