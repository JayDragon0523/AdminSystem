package com.first.smr.DAO;

import com.first.smr.POJO.Visitor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface VisitorDAO extends JpaRepository<Visitor,BigInteger> {

    Visitor findByPhone(String phone);

    Visitor findByPhoneAndPswd(String phone, String pswd);

    //查询游客参加的历史会议id
    @Query(value = "select appointment_id from attendees where person_id=?1 and state='已出席' and identity='visitor' group by id" ,nativeQuery = true)
    List<BigInteger> findMeetingIdByStaff_id(BigInteger staff_id);

    //查询某一会议的所有参会人员id
    @Query(value="select person_id from attendees where appointment_id in ?1 group by person_id",nativeQuery = true)
    List<BigInteger> findStaffIdByMeetingId(List<BigInteger> meeting_id);

    //查询某一游客的历史与会人员
    @Query(value=" select new Visitor(v.id,v.name) from Visitor v where v.id in ?1")
    List<Visitor> getPersonFromHistory(List<BigInteger> visitorids);

    //添加人脸特征信息
    @Modifying
    @Query(value = "update Staff set face_info=?1 where id=?2")
    void addFaceInfo(byte[] face_info, BigInteger id);

    /*
    * 根据游客名分页查询游客数据
    * @param name:     游客名
    * @param pageable: 分页信息
    * @return
    * */
    Page<Visitor> findByNameContaining(String name, Pageable pageable);

    /*
    * 分页查询游客数据
    * @param pageable: 分页信息
    * @return
    * */
    Page<Visitor> findAll(Pageable pageable);

}
