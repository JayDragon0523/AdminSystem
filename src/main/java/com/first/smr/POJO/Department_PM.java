package com.first.smr.POJO;

import javax.persistence.Column;
import java.io.Serializable;

public class Department_PM implements Serializable {
    @Column(name="Company_id")
    private String company_id;
    @Column(name="Department_name")
    private String department_name;

    public String getCompanyId() {
        return company_id;
    }

    public void setCompanyId(String company_id) {
        this.company_id = company_id;
    }

    public String getDepartment_name() {
        return department_name;
    }

    public void setDepartment_name(String department_name) {
        this.department_name = department_name;
    }
}
