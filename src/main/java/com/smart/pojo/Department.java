package com.smart.pojo;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="department")
public class Department {
    @EmbeddedId
    private Department_PM pm;

    public Department_PM getPm() {
        return pm;
    }

    public void setPm(Department_PM pm) {
        this.pm = pm;
    }
}
