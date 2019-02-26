package com.first.smr.DAO;

import com.first.smr.POJO.Appointment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Repository
public interface AppointmentDAO extends JpaRepository<Appointment,BigInteger> {
    /*
     * 根据时间公司id分页查询场地数据
     * @param before_time:   前一天的最后一秒 e.g. 2018-12-21 23:59:59
     * @param after_time:    后一天的第一秒   e.g. 2018-12-23 00:00:00
     * @param companyId:     公司id
     * @param pageable:      分页信息
     * @return
     * */
    Page<Appointment> findByStartTimeAfterAndStartTimeBeforeAndCompanyId(Timestamp before_time, Timestamp after_time, BigInteger companyId, Pageable pageable);

    /*
     * 根据公司id分页查询公司数据
     * @param companyId:  公司id
     * @param pageable:   分页信息
     * @return
     * */
    Page<Appointment> findByCompanyId(BigInteger companyId, Pageable pageable);

    //获取最短会议时长
    @Query(value = "select ((UNIX_TIMESTAMP(end_time)-UNIX_TIMESTAMP(start_time))/60)duration from appointment where type =?1 or ?2 order by duration asc limit 1",nativeQuery = true)
    int getMinDuration(String type1, String type2);

    //添加与会人员
    @Query(value = "insert into attendees(appointment_id,person_id,state) values(?1,?2,'未出席')",nativeQuery = true)
    void addAttendPerson(BigInteger meeting_id, BigInteger person_id);

    //根据人员编号和会议状态获取会议编号
    @Query(value = "select appointment_id from attendees where person_id=?1 and state=?2 and identity=?3 group by appointment_id",nativeQuery = true)
    List<BigInteger> getAppointmentId(BigInteger personId, String state, String identity);

    //根据预约人编号获取会议
    @Query(value = "from Appointment where orderer_id=?1 and ordererType=?2")
    List<Appointment> getAppointmentByOrderer_id(BigInteger orderer_id, String orderType);

    //获取某一类型会议的各类型会议室使用频率顺序
    @Query(value="select place_type from meetingType  where appointment_type=?1 order by frequency desc; ",nativeQuery = true)
    List<Character> getAppointmentOrderByType(String type);

    //获取所有预约会议
    List<Appointment> findByStartTimeAfter(Date now);







}
