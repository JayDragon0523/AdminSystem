package com.first.smr.DAO;

import com.first.smr.POJO.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface ScheduleDAO extends JpaRepository<Schedule,BigInteger> {


    //预约会议后修改会议室时间片状态
    @Modifying
    @Query("update Schedule set state='已预约' where placeId =?1 and schedule between ?2 and ?3")
    void updateStateForAppointmentById(BigInteger placeId, String start, String end);

    //获取空闲会议室的时间段id
    @Query(value = "select id from Schedule where state='空闲' and placeId in ?1 group by id")
    List<BigInteger> findSparePlaceId(List<BigInteger> placeIdList);

    //获取会议区间的会议室id
    @Query("select placeId from Schedule where schedule between ?1 and ?2 and state='空闲' and placeId in ?3 group by placeId" )
    List<BigInteger> findPlaceIdBetween(String start, String end, List<BigInteger> placeIdList);

}
