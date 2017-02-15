package com.eggtec.eggboard.model;

import java.util.Date;

/**
 * 계사
 */
public class Farm {

    private int workSeq;

    private String serialNo;

    private int farmNo;
    
    private String connectionStatus;

    private String status;

    private Integer inputCount;

    private Integer henCount;

    private String entDt;

    private Double waterQntty;

    private String errorCode;

    private String type;

    private Date regDtm;

    private Date modDtm;
    
    private String today;
    
    private String fromDate;
    
    private String toDate;
    
    private String workDate;
    
    private Integer farmCount;

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

    public String getConnectionStatus() {
        return connectionStatus;
    }

    public void setConnectionStatus(String connectionStatus) {
        this.connectionStatus = connectionStatus;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getInputCount() {
        return inputCount;
    }

    public void setInputCount(Integer inputCount) {
        this.inputCount = inputCount;
    }

    public Integer getHenCount() {
        return henCount;
    }

    public void setHenCount(Integer henCount) {
        this.henCount = henCount;
    }

    public String getEntDt() {
        return entDt;
    }

    public void setEntDt(String entDt) {
        this.entDt = entDt;
    }
    public Double getWaterQntty() {
        return waterQntty;
    }

    public void setWaterQntty(Double waterQntty) {
        this.waterQntty = waterQntty;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getToday() {
        return today;
    }

    public void setToday(String today) {
        this.today = today;
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

    public Integer getFarmCount() {
        return farmCount;
    }

    public void setFarmCount(Integer farmCount) {
        this.farmCount = farmCount;
    }
    
    
}
