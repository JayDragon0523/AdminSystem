package com.first.smr.POJO;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;
import java.sql.Timestamp;

@Entity
@Table(name="evaluation")
public class Evaluation implements Serializable {
    private static final Long serialVersionUID = 7284767790000015169L;
    Evaluation(){}
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    private BigInteger place_id;
    private BigInteger evaluator_id;
    @ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "place_id",insertable=false, updatable=false)
    private Company place;
    private String evaluator_type;
    @ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "evaluator_id",insertable=false, updatable=false)
    private Visitor visitor;
    @ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH},optional = false)
    @JoinColumn(name = "evaluator_id",insertable=false, updatable=false)
    private Staff staff;
    private Timestamp time;
    private String content;


    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getPlace_id() {
        return place_id;
    }

    public void setPlace_id(BigInteger place_id) {
        this.place_id = place_id;
    }

    public BigInteger getEvaluator_id() {
        return evaluator_id;
    }

    public void setEvaluator_id(BigInteger evaluator_id) {
        this.evaluator_id = evaluator_id;
    }

    public Company getPlace() {
        return place;
    }

    public void setPlace(Company place) {
        this.place = place;
    }

    public String getEvaluator_type() {
        return evaluator_type;
    }

    public void setEvaluator_type(String evaluator_type) {
        this.evaluator_type = evaluator_type;
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
}
