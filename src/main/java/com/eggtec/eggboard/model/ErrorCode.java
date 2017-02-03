package com.eggtec.eggboard.model;

import java.util.Date;

public class ErrorCode {
    private int workSeq;
    private String serialNo;
    private String type;
    private int errorNo;
    private String errorCode;
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
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public int getErrorNo() {
        return errorNo;
    }
    public void setErrorNo(int errorNo) {
        this.errorNo = errorNo;
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
    public String getErrorCode() {
        return errorCode;
    }
    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }
}
