package com.smart.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="staff")
public class Staff {
    @Id
    private String id;
    @Column(name="company_id")
    private String company_id;
    @Column(name="job_num")
    private String job_num;
    @Column(name="name")
    private String name;
    @Column(name="department_name")
    private String department_name;
    @Column(name="pswd")
    private String pswd;
    @Column(name="id_num")
    private String id_num;
    @Column(name="phone")
    private String phone;
    @Column(name="face_info")
    private String face_info;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCompany_id() {
        return company_id;
    }

    public void setCompany_id(String company_id) {
        this.company_id = company_id;
    }

    public String getJob_num() {
        return job_num;
    }

    public void setJob_num(String job_num) {
        this.job_num = job_num;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartment_name() {
        return department_name;
    }

    public void setDepartment_name(String department_name) {
        this.department_name = department_name;
    }

    public String getPswd() {
        return pswd;
    }

    public void setPswd(String pswd) {
        this.pswd = pswd;
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

    public String getFace_info() {
        return face_info;
    }

    public void setFace_info(String face_info) {
        this.face_info = face_info;
    }
}
