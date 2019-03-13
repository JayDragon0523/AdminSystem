package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name="appointment")
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
public class Appointment implements Serializable {
    private static final Long serialVersionUID = 7478189957000817059L;
    public Appointment(){}
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    private BigInteger orderer_id;
    @Column(name="orderer_type",nullable = false)
    private String ordererType;
    @Column(name = "start_time",nullable = false)
    private Timestamp startTime;
    @Column(name = "end_time",nullable = false)
    private Timestamp endTime;
    private BigInteger place_id;
    @ManyToOne(cascade = {CascadeType.MERGE,CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "place_id",insertable=false, updatable=false)
    private Place place;
    private String place_name;
    @Column(name = "company_id")
    private BigInteger companyId;
    @ManyToOne(cascade = {CascadeType.MERGE,CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "company_id",insertable=false, updatable=false)
    private Company company;
    private String introduction;
    private String type;
    private int duration;
    @Transient
    private String stime;
    @Transient
    private String etime;

    @OneToMany(mappedBy = "appointment",cascade={CascadeType.ALL},fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Attendees> attendees;


    @ManyToOne(cascade = {CascadeType.MERGE,CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "orderer_id",insertable=false, updatable=false)
    private Visitor visitor;
    @ManyToOne(cascade = {CascadeType.MERGE,CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "orderer_id",insertable=false, updatable=false)
    private Staff staff;

    public Timestamp getStartTime() {
        return startTime;
    }


    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }
    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }

    public int getDuration() {
        return duration;
    }
    public void setDuration(int duration) {
        this.duration = duration;
    }

    public List<Attendees> getAttendees() {
        return attendees;
    }
    public void setAttendees(List<Attendees> attendees) {
        this.attendees = attendees;
    }

    public BigInteger getId() {
        return id;
    }
    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getOrderer_id() {
        return orderer_id;
    }
    public void setOrderer_id(BigInteger orderer_id) {
        this.orderer_id = orderer_id;
    }

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public BigInteger getPlace_id() {
        return place_id;
    }
    public void setPlace_id(BigInteger place_id) {
        this.place_id = place_id;
    }

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public String getPlace_name() {
        return place_name;
    }
    public void setPlace_name(String place_name) {
        this.place_name = place_name;
    }

    public BigInteger getCompanyId() {
        return companyId;
    }
    public void setCompanyId(BigInteger companyId) {
        this.companyId = companyId;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public String getIntroduction() {
        return introduction;
    }
    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getOrdererType() {
        return ordererType;
    }
    public void setOrdererType(String ordererType) {
        this.ordererType = ordererType;
    }

    public Visitor getVisitor() {
        return visitor;
    }

    public void setVisitor(Visitor visitor) {
        this.visitor = visitor;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public String getStime() {
        return stime;
    }

    public void setStime(String stime) {
        this.stime = stime;
    }

    public String getEtime() {
        return etime;
    }

    public void setEtime(String etime) {
        this.etime = etime;
    }
}
