package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
@Table(name="place")
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(value={"hibernateLazyInitializer", "handler" ,"companyId","type","cost"})
public class Place implements Serializable {
    private static final Long serialVersionUID = 4033298062475577637L;
    public Place(){}
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    @Column(name = "company_id")
    private BigInteger companyId;
    private String company_name;
    private String type;
    private String name;
    private String address;
    private String introduction;
    private String device;
    private String instruction;
    private String cost;
    @ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "company_id",insertable=false, updatable=false)
    private Company company;

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    private int capacity;

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getCompanyId() {
        return companyId;
    }

    public void setCompanyId(BigInteger companyId) {
        this.companyId = companyId;
    }

    public String getCompany_name(){ return company_name;}

    public void setCompany_name(String company_name){ this.company_name=company_name; }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getDevice() {
        return device;
    }

    public void setDevice(String device) {
        this.device = device;
    }

    public String getInstruction() {
        return instruction;
    }

    public void setInstruction(String instruction) {
        this.instruction = instruction;
    }

    public String getCost() {
        return cost;
    }

    public void setCost(String cost) {
        this.cost = cost;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }
}
