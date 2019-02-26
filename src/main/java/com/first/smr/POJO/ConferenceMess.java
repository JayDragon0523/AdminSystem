package com.first.smr.POJO;



import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name = "meetingdetail")
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
public class ConferenceMess implements Serializable {

   private static final long serialVersionUID = 6618375426278322704L;
   public ConferenceMess(){}
    @Id
    @Column(name = "appointment_id")
    private BigInteger appointmentId;
    private String place;
    private String address;
    private Timestamp start_time;
    private Timestamp end_time;
    private String introduction;
    private String organizer;
    private String phone;

    @OneToMany(mappedBy = "appointment",cascade={CascadeType.ALL},fetch = FetchType.LAZY)
    private List<Attendees> attendees;


    public List<Attendees> getAttendees() {
        return attendees;
    }

    public void setAttendees(List<Attendees> attendees) {
        this.attendees = attendees;
    }

    public BigInteger getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(BigInteger appointmentId) {
        this.appointmentId = appointmentId;
    }


    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Timestamp getStart_time() {
        return start_time;
    }

    public void setStart_time(Timestamp start_time) {
        this.start_time = start_time;
    }

    public Timestamp getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Timestamp end_time) {
        this.end_time = end_time;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getOrganizer() {
        return organizer;
    }

    public void setOrganizer(String organizer) {
        this.organizer = organizer;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
