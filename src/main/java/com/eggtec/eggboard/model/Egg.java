package com.eggtec.eggboard.model;

import java.util.Date;

/**
 * 계란
 */
public class Egg {

    private int workSeq;

    private String serialNo;

    private int farmNo;

    private String grade;
    
    private String weightRange;

    private Double prodRatio;

    private Integer qntty;

    private Integer box;

    private Double totalWeight;

    private Double avrgWeight;

    private Date regDtm;

    private Date modDtm;
    
    private String gradeName;
    
    private int gradeOrder;
    
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

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public Double getProdRatio() {
        return prodRatio;
    }

    public void setProdRatio(Double prodRatio) {
        this.prodRatio = prodRatio;
    }

    public Integer getQntty() {
        return qntty;
    }

    public void setQntty(Integer qntty) {
        this.qntty = qntty;
    }

    public Integer getBox() {
        return box;
    }

    public void setBox(Integer box) {
        this.box = box;
    }

    public Double getTotalWeight() {
        return totalWeight;
    }

    public void setTotalWeight(Double totalWeight) {
        this.totalWeight = totalWeight;
    }

    public Double getAvrgWeight() {
        return avrgWeight;
    }

    public void setAvrgWeight(Double avrgWeight) {
        this.avrgWeight = avrgWeight;
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

    public String getWeightRange() {
        return weightRange;
    }

    public void setWeightRange(String weightRange) {
        this.weightRange = weightRange;
    }

    public String getGradeName() {
        return gradeName;
    }

    public void setGradeName(String gradeName) {
        this.gradeName = gradeName;
    }

    public int getGradeOrder() {
        return gradeOrder;
    }

    public void setGradeOrder(int gradeOrder) {
        this.gradeOrder = gradeOrder;
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
