package com.first.smr.POJO;

import java.util.List;

public class RecommendResult {
    private String message;
    private List<Recommend> recommends;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<Recommend> getRecommends() {
        return recommends;
    }

    public void setRecommends(List<Recommend> recommends) {
        this.recommends = recommends;
    }
}
