package com.first.smr.POJO;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;
import java.util.List;

@Entity
@Table(name="place")
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(value={"hibernateLazyInitializer", "handler" ,})
public class Place implements Serializable {
    private static final Long serialVersionUID = 4033298062475577637L;
    public Place(){}
    public interface StaffView{};
    public interface VisitorView extends StaffView{};

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
    private int capacity;
    private String tag;


    @ManyToOne(cascade = {CascadeType.MERGE,CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "company_id",insertable=false, updatable=false)
    private Company company;

    @Transient
    private List<Evaluation> evaluations;

    @OneToMany(cascade={CascadeType.ALL},fetch = FetchType.LAZY)
    @JoinColumn(name = "place_id",insertable=false, updatable=false)
    private List<PlaceImage> portraits;

    @JsonView(StaffView.class)
    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    @JsonView(StaffView.class)
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

    @JsonView(StaffView.class)
    public String getCompany_name(){ return company_name;}
    public void setCompany_name(String company_name){ this.company_name=company_name; }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    @JsonView(StaffView.class)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @JsonView(StaffView.class)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @JsonView(StaffView.class)
    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    @JsonView(StaffView.class)
    public String getDevice() {
        return device;
    }

    public void setDevice(String device) {
        this.device = device;
    }

    @JsonView(StaffView.class)
    public String getInstruction() {
        return instruction;
    }
    public void setInstruction(String instruction) {
        this.instruction = instruction;
    }

    @JsonView(VisitorView.class)
    public String getCost() {
        return cost;
    }
    public void setCost(String cost) {
        this.cost = cost;
    }

    @JsonView(VisitorView.class)
    public Company getCompany() {
        return company;
    }
    public void setCompany(Company company) {
        this.company = company;
    }

    @JsonView(StaffView.class)
    public List<PlaceImage> getPortraits() {
        return portraits;
    }
    public void setPortraits(List<PlaceImage> portraits) {
        this.portraits = portraits;
    }

    @JsonView(VisitorView.class)
    public List<Evaluation> getEvaluations() {
        return evaluations;
    }
    public void setEvaluations(List<Evaluation> evaluations) {
        this.evaluations = evaluations;
    }

    @JsonView(VisitorView.class)
    public String getTag() {
        return tag;
    }
    public void setTag(String tag) {
        this.tag = tag;
    }
}
