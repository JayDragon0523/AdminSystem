package com.first.smr.POJO;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
@Table(name = "visitorschedule")
public class VisitorSchedule implements Serializable {
    private static final long serialVersionUID = -4215005554885766281L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    @Column(name = "place_id")
    private BigInteger placeId;
    private String start;
    private String end;
    private String state;
    @Column(name = "day_of_week")
    private String dayOfWeek;
    public VisitorSchedule(){}
    public VisitorSchedule(BigInteger placeId, String start, String end, String state, String dayOfWeek) {
        this.placeId = placeId;
        this.start = start;
        this.end = end;
        this.state = state;
        this.dayOfWeek = dayOfWeek;
    }

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getPlaceId() {
        return placeId;
    }

    public void setPlaceId(BigInteger placeId) {
        this.placeId = placeId;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(String dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }
}
