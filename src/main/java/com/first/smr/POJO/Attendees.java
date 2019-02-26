package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
@Table(name="attendees")
public class Attendees implements Serializable {
    private static final Long serialVersionUID = 1439669154171535080L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    @Column(name="appointment_id")
    private BigInteger appointmentId;
    @Column(name = "person_id")
    private BigInteger personId;
    private String name;
    private String identity;
    private String state;

    @ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH},fetch = FetchType.LAZY,optional = false)
    @JoinColumn(name = "appointment_id",insertable = false,updatable = false,referencedColumnName = "id")
    @JsonIgnore
    private Appointment appointment;

    @ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH},fetch = FetchType.LAZY,optional = false)
    @JoinColumn(name = "appointment_id",insertable = false,updatable = false)
    @JsonIgnore
    private ConferenceMess conferenceMess;

    public Attendees(BigInteger personId, String name) {
        this.personId = personId;
        this.name = name;
        this.state="未出席";
    }

    public BigInteger getId() {
        return id;
    }
    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getPersonId() {
        return personId;
    }
    public void setPersonId(BigInteger personId) {
        this.personId = personId;
    }

    public Appointment getAppointment() {
        return appointment;
    }
    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public ConferenceMess getConferenceMess() {
        return conferenceMess;
    }
    public void setConferenceMess(ConferenceMess conferenceMess) {
        this.conferenceMess = conferenceMess;
    }

    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getIdentity() {
        return identity;
    }
    public void setIdentity(String identity) {
        this.identity = identity;
    }

    public void setAppointmentId(BigInteger appointmentId) {
        this.appointmentId = appointmentId;
    }
    public BigInteger getAppointmentId() {
        return appointmentId;
    }


    public Attendees(){}
}
