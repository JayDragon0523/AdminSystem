package com.first.smr.DAO;

import com.first.smr.POJO.ConferenceMess;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.math.BigInteger;
import java.util.List;

public interface ConferenceMessDAO extends JpaRepository<ConferenceMess, BigInteger> {
    //获取会议信息
    @Query("from ConferenceMess where appointmentId in ?1")
    List<ConferenceMess> findByAppointmentIdIn(List<BigInteger> idList);
    @Query("from ConferenceMess where appointmentId=?1")
    ConferenceMess findByAppointmentId(BigInteger id);
}
