package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;
import java.util.List;

@Entity
@Table(name="groupmess")
public class Group implements Serializable {

    private static final long serialVersionUID = -2110365371827802279L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    @Column(name = "group_leader")
    private BigInteger groupLeader;
    @Column(name = "appointment_id")
    @JsonIgnore
    private BigInteger appointmentId;
    @Column(name = "style")
    private String groupStyle;
    @Column(name="name")
    private String groupName;

    @OneToMany(mappedBy = "groupmess",cascade={CascadeType.ALL},fetch = FetchType.LAZY)
    private List<GroupMember> groupMembers;

    public Group(){}

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getGroupLeader() {
        return groupLeader;
    }

    public void setGroupLeader(BigInteger groupLeader) {
        this.groupLeader = groupLeader;
    }

    public BigInteger getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(BigInteger appointmentId) {
        this.appointmentId = appointmentId;
    }

    public String getGroupStyle() {
        return groupStyle;
    }

    public void setGroupStyle(String groupStyle) {
        this.groupStyle = groupStyle;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public List<GroupMember> getGroupMembers() {
        return groupMembers;
    }
    public void setGroupMembers(List<GroupMember> groupMembers) {
        this.groupMembers = groupMembers;
    }
}
