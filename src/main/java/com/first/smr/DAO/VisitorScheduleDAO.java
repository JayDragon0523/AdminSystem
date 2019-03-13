package com.first.smr.DAO;

import com.first.smr.POJO.VisitorSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface VisitorScheduleDAO extends JpaRepository<VisitorSchedule, BigInteger> {
    //查找场地时间段
    List<VisitorSchedule> findAllByPlaceId(BigInteger placeId);

}
