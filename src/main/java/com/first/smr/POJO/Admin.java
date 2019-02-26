package com.first.smr.POJO;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
@Table(name="admin")
public class Admin implements Serializable {
    private static final Long serialVersionUID = -5423992703724217123L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    @Column(name = "company_id")
    private BigInteger companyId;
    private String identity;
    private String id_num;
    private String account;
    private String pswd;
    private String phone;
    private String face_info;
    private String state;
    @ManyToOne(cascade = {CascadeType.MERGE,CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "company_id", insertable=false, updatable=false)
    private Company company;

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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFace_info() {
        return face_info;
    }

    public void setFace_info(String face_info) {
        this.face_info = face_info;
    }

    public String getState(){ return state; }

    public void setState(String state){ this.state=state; }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

}
