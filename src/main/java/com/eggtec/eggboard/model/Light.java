package com.eggtec.eggboard.model;

import java.util.Date;

/**
 * 조명
 */
public class Light {

    private int workSeq;

    private String serialNo;

    private int farmNo;

    private int lightNo;

    private Integer lux;

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

    public int getLightNo() {
        return lightNo;
    }

    public void setLightNo(int lightNo) {
        this.lightNo = lightNo;
    }

    public Integer getLux() {
        return lux;
    }

    public void setLux(Integer lux) {
        this.lux = lux;
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
