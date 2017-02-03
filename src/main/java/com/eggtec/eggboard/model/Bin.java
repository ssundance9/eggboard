package com.eggtec.eggboard.model;

import java.util.Date;

/**
 * 급이시설
 */
public class Bin {
    private int workSeq;

    private String serialNo;

    private int farmNo;

    private int binNo;

    private Double currentWeight;
    
    private Double usedWeight;
    
    private Double addWeight;

    private Date regDtm;

    private Date modDtm;
    
    private String fromDate;
    
    private String toDate;
    
    private String workDate;

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

    public int getBinNo() {
        return binNo;
    }

    public void setBinNo(int binNo) {
        this.binNo = binNo;
    }

    public Double getCurrentWeight() {
        return currentWeight;
    }

    public void setCurrentWeight(Double currentWeight) {
        this.currentWeight = currentWeight;
    }

    public Double getUsedWeight() {
        return usedWeight;
    }

    public void setUsedWeight(Double usedWeight) {
        this.usedWeight = usedWeight;
    }

    public Double getAddWeight() {
        return addWeight;
    }

    public void setAddWeight(Double addWeight) {
        this.addWeight = addWeight;
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

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    public String getWorkDate() {
        return workDate;
    }

    public void setWorkDate(String workDate) {
        this.workDate = workDate;
    }
    
    
}
