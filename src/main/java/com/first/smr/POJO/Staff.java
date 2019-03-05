package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
@Table(name="staff")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Staff implements Serializable {

    private static final Long serialVersionUID = -1436245267859675224L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    private String name;
    public Staff(BigInteger id,String name)
    {
        this.id=id;
        this.name=name;
    }
    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public BigInteger getCompanyId() {
        return companyId;
    }

    public void setCompanyId(BigInteger companyId) {
        this.companyId = companyId;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getId_num() {
        return id_num;
    }

    public void setId_num(String id_num) {
        this.id_num = id_num;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
    @Column(name="pswd",nullable = false)
    private String pswd;
    private String sex;

    private String company;
    @Column(name="company_id")
    private BigInteger companyId;

    public String getJobnum() {
        return jobnum;
    }

    public void setJobnum(String jobnum) {
        this.jobnum = jobnum;
    }

    @Column(name="job_num",nullable =false)
    private String jobnum;
    private String department;
    private String id_num;
    private String phone;

    public void setFace_info(byte[] face_info) {
        this.face_info = face_info;
    }

    public byte[] getFace_info() {
        return face_info;
    }

    private byte[] face_info;
    public Staff(){}


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

    public String getPswd() {
        return pswd;
    }

    public void setPswd(String pswd) {
        this.pswd = pswd;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }


}
