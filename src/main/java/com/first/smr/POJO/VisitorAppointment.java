package com.first.smr.POJO;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
@Table(name="appointstate")
public class VisitorAppointment implements Serializable {

    private static final Long serialVersionUID = 3528416594162821824L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;

    private BigInteger appointment_id;

    @OneToOne(cascade = {CascadeType.MERGE,CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "appointment_id",insertable=false, updatable=false)
    private Appointment appointment;

    private String state;

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getAppointment_id() {
        return appointment_id;
    }

    public void setAppointment_id(BigInteger appointment_id) {
        this.appointment_id = appointment_id;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
