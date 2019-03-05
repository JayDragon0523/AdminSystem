package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonInclude;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
@Table(name="visitor")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Visitor implements Serializable {

    private static final Long serialVersionUID = 2073182677862878262L;

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

    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPswd() {
        return pswd;
    }
    public void setPswd(String pswd) {
        this.pswd = pswd;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCredit_card() {
        return credit_card;
    }
    public void setCredit_card(String credit_card) {
        this.credit_card = credit_card;
    }

    public String getId_num() {
        return id_num;
    }
    public void setId_num(String id_num) {
        this.id_num = id_num;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    private String name;
    private String sex;
    private String account;
    private String pswd;
    private String phone;
    private String id_num;
    private String credit_card;
    private byte[] face_info;
    public byte[] getFace_info() {
        return face_info;
    }
    public void setFace_info(byte[] face_info) {
        this.face_info = face_info;
    }


    public Visitor(){}
    public Visitor(BigInteger id,String name)
    {
        this.id=id;
        this.name=name;
    }


}
