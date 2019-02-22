package com.smart.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="manager")
public class Administrator {
    @Id
    private String id;
    @Column(name="identity")
    private String identity;
    @Column(name="id_num")
    private String id_num;
    @Column(name="account")
    private String account;
    @Column(name="pswd")
    private String pswd;
    @Column(name="face_info")
    private String face_info;
    @Column(name="phone")
    private String phone;
    @Column(name="company_id")
    private String company_id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
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

    public String getPswd() {
        return pswd;
    }

    public void setPswd(String pswd) {
        this.pswd = pswd;
    }

    public String getFace_info() {
        return face_info;
    }

    public void setFace_info(String face_info) {
        this.face_info = face_info;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCompany_id() {
        return company_id;
    }

    public void setCompany_id(String company_id) {
        this.company_id = company_id;
    }
}
