package com.first.smr.POJO;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;

@Entity
@Table(name = "placeimage")
public class PlaceImage implements Serializable {

    private static final long serialVersionUID = 5729367129896291411L;

    public PlaceImage() {
    }
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    @Column(name="place_id")
    private BigInteger placeId;
    private String portrait;

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

    public String getPortrait() {
        return portrait;
    }

    public void setPortrait(String portrait) {
        this.portrait = portrait;
    }
}
