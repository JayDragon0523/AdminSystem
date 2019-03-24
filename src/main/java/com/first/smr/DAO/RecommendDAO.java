package com.first.smr.DAO;

import com.first.smr.POJO.Recommend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.math.BigInteger;
import java.util.List;

public interface RecommendDAO extends JpaRepository<Recommend, BigInteger> {
    @Query(value = "select place.id,place.name,place.address,place.introduction,place.device,place.instruction,place.capacity,place.type,place.cost,ST_Distance_Sphere(place.location,ST_GeomFromText(?1)) as distance from place,schedule where schedule.place_id in ?2 and place.type=?3 and place.id=schedule.place_id and schedule.state='空闲'  and schedule.schedule=?4 and schedule.day_of_week=?5 order by distance asc ",nativeQuery = true)
    List<Recommend> findBestRecommend(String position, List<BigInteger> idList, String type, String lastSchedule, String dayOfWeek);

    //返回上一时段有预约的可用会议室
    @Query(value = "select place.id,place.name,place.address,place.introduction,place.device,place.instruction,place.capacity,place.type,place.cost,ST_Distance_Sphere(place.location,ST_GeomFromText(?1)) as distance from place,schedule where schedule.place_id in ?2 and place.type=?3 and place.id=schedule.place_id and schedule.state='使用'  and schedule.schedule=?4 and schedule.day_of_week=?5 order by distance asc ",nativeQuery = true)
    List<Recommend> findSpareRecommend(String position, List<BigInteger> idList, String type, String lastSchedule, String dayOfWeek);


    @Query(value = "select ST_Distance_Sphere(place.location,ST_GeomFromText(?1)) as distance from place,schedule where schedule.place_id in ?2 and place.type=?3 and place.id=schedule.place_id and schedule.state='空闲'  and schedule.schedule=?4 and schedule.day_of_week=?5 order by distance asc ",nativeQuery = true)
    List<Integer> findDistance(String position, List<BigInteger> idList, String type, String lastSchedule, String dayOfWeek);
}
