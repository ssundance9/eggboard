package com.eggtec.eggboard.model;

public class Page {
    private int pageNum = 1;
    
    private int pageSize = 10;
    
    private int listSize = 10;
    
    private int totalCount;

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        if (pageNum == null) {
            this.pageNum = 1;
        } else {
            this.pageNum = pageNum;
        }
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getListSize() {
        return listSize;
    }

    public void setListSize(int listSize) {
        this.listSize = listSize;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }
}
