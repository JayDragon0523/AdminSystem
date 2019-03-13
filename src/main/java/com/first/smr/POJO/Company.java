package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;
import java.sql.Time;

@Entity
@Table(name="company")
//@JsonInclude(JsonInclude.Include.NON_NULL)
public class Company implements Serializable {
    private static final Long serialVersionUID = -1650062842275377348L;
    public interface SimpleView{};
    public interface DetailView extends SimpleView{}
    public Company(){}
    public Company(BigInteger id, String name)
    {
        this.id=id;
        this.name=name;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    private String name;
    private String address;
    private String register_num;
    private String introduction;
    private String head_name;
    private String head_phone;
    @JsonIgnore
    private String state;

    private Time open_time;
    private Time close_time;
    public BigInteger getId() {
        return id;
    }
    public void setId(BigInteger id) {
        this.id = id;
    }

    @JsonView(SimpleView.class)
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    @JsonView(DetailView.class)
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    @JsonView(DetailView.class)
    public String getRegister_num() {
        return register_num;
    }
    public void setRegister_num(String register_num) {
        this.register_num = register_num;
    }

    @JsonView(DetailView.class)
    public String getIntroduction() {
        return introduction;
    }
    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getHead_name() {
        return head_name;
    }
    public void setHead_name(String head_name) {
        this.head_name = head_name;
    }

    public String getHead_phone() {
        return head_phone;
    }
    public void setHead_phone(String head_phone) {
        this.head_phone = head_phone;
    }

    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }

    @JsonView(SimpleView.class)
    public Time getOpen_time() {
        return open_time;
    }

    public void setOpen_time(Time open_time) {
        this.open_time = open_time;
    }

    public Time getClose_time() {
        return close_time;
    }

    public void setClose_time(Time close_time) {
        this.close_time = close_time;
    }
}
