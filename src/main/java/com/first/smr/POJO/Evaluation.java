package com.first.smr.POJO;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;
import java.sql.Timestamp;

@Entity
@Table(name="evaluation")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Evaluation implements Serializable {
    private static final Long serialVersionUID = 7284767790000015169L;
    public  Evaluation(){}

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    //@JsonIgnore
    @Column(name = "place_id",nullable = false)
    private BigInteger placeId;
    private Timestamp time;
    private String content;
    @JsonIgnore
    private BigInteger visitor_id;
    @JsonIgnore
    private BigInteger staff_id;

    @ManyToOne(cascade = {CascadeType.MERGE,CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "visitor_id",insertable=false, updatable=false)
    @NotFound(action= NotFoundAction.IGNORE)
    private Visitor visitor;

    @ManyToOne(cascade = {CascadeType.MERGE,CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "staff_id",insertable=false, updatable=false)
    @NotFound(action=NotFoundAction.IGNORE)

    private Staff staff;

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getPlaceId() {
        return placeId;
    }

    public void setPlaceId(BigInteger placeId) {
        this.placeId = placeId;
    }

    public Visitor getVisitor() {
        return visitor;
    }

    public void setVisitor(Visitor visitor) {
        this.visitor = visitor;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public BigInteger getVisitor_id() {
        return visitor_id;
    }

    public void setVisitor_id(BigInteger visitor_id) {
        this.visitor_id = visitor_id;
    }

    public BigInteger getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(BigInteger staff_id) {
        this.staff_id = staff_id;
    }
}
