package com.first.smr.DAO;

import com.first.smr.POJO.Group;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface GroupDAO extends JpaRepository<Group, BigInteger> {

    @Query(value = "update groupmess set appointment_id=?1 where group_id=?2",nativeQuery = true)
    @Modifying
    void setAppointmentIdInGroup(BigInteger appointmentId, BigInteger group_id);

    //获取临时群编号
    @Query(value = "select id from Group where appointmentId=?1 and style='临时'")
    BigInteger getTempGroupId(BigInteger appointmentId);

    //获取创建的群
    List<Group> getGroupsByGroupLeader(BigInteger groupLeaderId);

    //获取创建的群号
  @Query(value = "select id from Group where groupLeader=?1")
    List<BigInteger> getGroupIdCreatedBy(BigInteger groupLeaderId);

  @Query(value = "from Group where id in ?1")
  List<Group> getGroupsByIdList(List<BigInteger> groupId);

  //获取会议对应的群组
    @Query(value = "select id from Group where appointmentId=?1")
    BigInteger findGroupIdByAppointmentId(BigInteger appointmentId);

    Group findGroupByAppointmentId(BigInteger appointmentId);
}
