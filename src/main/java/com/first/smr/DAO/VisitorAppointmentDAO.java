package com.first.smr.DAO;

import com.first.smr.POJO.VisitorAppointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.List;

@Repository
public interface VisitorAppointmentDAO extends JpaRepository<VisitorAppointment, BigInteger> {

    /*
    * 根据游客预约id 查找游客预约对象
    * */
    VisitorAppointment findVisitorAppointmentById(BigInteger id);

    /*
    * 根据公司id 查找游客预约对象
    * */
    List<VisitorAppointment> findByAppointment_CompanyId(BigInteger companyId);

    /*
    * 根据审核状态和公司id 查找游客预约对象
    * */
    List<VisitorAppointment> findByStateAndAppointment_CompanyId(String state, BigInteger companyId);

    /*
    * 根据场地id 和公司id 查找游客预约对象
    * */
    List<VisitorAppointment> findByAppointment_Place_idAndAppointment_CompanyId(BigInteger place_id, BigInteger companyId);

    /*
    * 根据时间和公司id 查找游客预约对象
    * */
    List<VisitorAppointment> findByAppointment_StartTimeAfterAndAppointment_StartTimeBeforeAndAppointment_CompanyId(Timestamp before_time, Timestamp after_time, BigInteger companyId);

    /*
    * 根据审核状态、场地id 和公司id 查找游客预约对象
    * */
    List<VisitorAppointment> findByStateAndAppointment_Place_idAndAppointment_CompanyId(String state, BigInteger place_id, BigInteger companyId);

    /*
    * 根据审核状态、时间和公司id 查找游客预约对象
    * */
    List<VisitorAppointment> findByStateAndAppointment_StartTimeAfterAndAppointment_StartTimeBeforeAndAppointment_CompanyId(String state, Timestamp before_time, Timestamp after_time, BigInteger companyId);

    /*
    * 根据时间、场地id 和公司id 查找游客预约对象
    * */
    List<VisitorAppointment> findByAppointment_Place_idAndAppointment_StartTimeAfterAndAppointment_StartTimeBeforeAndAppointment_CompanyId(BigInteger place_id, Timestamp before_time, Timestamp after_time, BigInteger companyId);

    /*
    * 根据审核状态、场地id 、时间和公司id 查找游客预约对象
    * */
    List<VisitorAppointment> findByStateAndAppointment_Place_idAndAppointment_StartTimeAfterAndAppointment_StartTimeBeforeAndAppointment_CompanyId(String state, BigInteger place_id, Timestamp before_time, Timestamp after_time, BigInteger companyId);

    /*
    * 分页查询所有游客预约对象
    * */
    @Override
    List<VisitorAppointment> findAll();
}
