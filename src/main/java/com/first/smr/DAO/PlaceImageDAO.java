package com.first.smr.DAO;

import com.first.smr.POJO.PlaceImage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.math.BigInteger;

public interface PlaceImageDAO extends JpaRepository<PlaceImage, BigInteger> {
}
