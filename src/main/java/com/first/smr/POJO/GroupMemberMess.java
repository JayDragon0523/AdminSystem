package com.first.smr.POJO;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
public class GroupMemberMess implements Serializable {
    private static final long serialVersionUID = 289783330299383374L;
    @Id
    private BigInteger person_id;
    private String identity;
    private String name;
    private String protrait;
    private byte[] face_info;

    public GroupMemberMess(){};

    public GroupMemberMess(BigInteger person_id, String identity, String name, String protrait, byte[] face_info) {
        this.person_id = person_id;
        this.identity = identity;
        this.name = name;
        this.protrait = protrait;
        this.face_info = face_info;
    }

    public BigInteger getPerson_id() {
        return person_id;
    }

    public void setPerson_id(BigInteger person_id) {
        this.person_id = person_id;
    }

    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProtrait() {
        return protrait;
    }

    public void setProtrait(String protrait) {
        this.protrait = protrait;
    }

    public byte[] getFace_info() {
        return face_info;
    }

    public void setFace_info(byte[] face_info) {
        this.face_info = face_info;
    }

}
