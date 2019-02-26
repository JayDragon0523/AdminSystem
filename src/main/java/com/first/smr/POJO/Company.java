package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonInclude;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
@Table(name="company")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Company implements Serializable {
    private static final Long serialVersionUID = -1650062842275377348L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    private String name;
    private String address;
    private String register_num;
    private String introduction;
    private String head_name;
    private String head_phone;
    private String state;

    Company(){}

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
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

    public String getRegister_num() {
        return register_num;
    }

    public void setRegister_num(String register_num) {
        this.register_num = register_num;
    }

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
}
