package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Table(name = "groupmember")
@Entity
public class GroupMember implements Serializable {
    private static final long serialVersionUID = -8774447827026533887L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    @Column(name = "group_id")
    private String groupId;
    @Column(name = "person_id")
    private BigInteger personId;
    private String identity;
    private String name;

    @ManyToOne(cascade = {CascadeType.MERGE,CascadeType.REFRESH},fetch = FetchType.LAZY,optional = false)
    @JoinColumn(name = "group_id",insertable = false,updatable = false)
    @JsonIgnore
    private Group groupmess;

    public GroupMember(){};

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public BigInteger getPersonId() {
        return personId;
    }

    public void setPersonId(BigInteger personId) {
        this.personId = personId;
    }

    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
    }

    public Group getGroupmess() {
        return groupmess;
    }

    public void setGroupmess(Group groupmess) {
        this.groupmess = groupmess;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
