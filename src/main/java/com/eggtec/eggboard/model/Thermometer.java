package com.eggtec.eggboard.model;

import java.util.Date;

/**
 * 온도계
 */
public class Thermometer {

    private int workSeq;

    private String serialNo;

    private int farmNo;

    private int thermometerNo;

    private Double degree;

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

    public int getThermometerNo() {
        return thermometerNo;
    }

    public void setThermometerNo(int thermometerNo) {
        this.thermometerNo = thermometerNo;
    }

    public Double getDegree() {
        return degree;
    }

    public void setDegree(Double degree) {
        this.degree = degree;
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
