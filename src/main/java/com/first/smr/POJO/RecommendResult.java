package com.first.smr.POJO;

import java.util.List;

public class RecommendResult {
    private String message;
    private int count;
    private List<Object> recommends;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<Object> getRecommends() {
        return recommends;
    }

    public void setRecommends(List<Object> recommends) {
        this.recommends = recommends;
    }

    public int getCount() {
        return count;
    }
    public void setCount(int count) {
        this.count = count;
    }
}
