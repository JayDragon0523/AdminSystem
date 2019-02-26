package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonInclude;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
@Table(name="schedule")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Schedule implements Serializable {
    private static final Long serialVersionUID = -4481114461775537048L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    @Column(name="place_id",nullable = false)
    private BigInteger placeId;
    private String schedule;
    private String state;
    @Column(name="is_reserve",nullable = false)
    private boolean isReserve;

    public Schedule(){}
    public Schedule(BigInteger placeId, String schedule, String state, boolean isReserve) {
        this.placeId = placeId;
        this.schedule = schedule;
        this.state = state;
        this.isReserve = isReserve;
    }

    public BigInteger getPlaceId() {
        return placeId;
    }
    public void setPlaceId(BigInteger placeId) {
        this.placeId = placeId;
    }

    public BigInteger getId() {
        return id;
    }
    public void setId(BigInteger id) {
        this.id = id;
    }

    public String getSchedule() {
        return schedule;
    }
    public void setSchedule(String schedule) {
        this.schedule = schedule;
    }

    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }

    public boolean isReserve() {
        return isReserve;
    }
    public void setReserve(boolean reserve) {
        isReserve = reserve;
    }
}
