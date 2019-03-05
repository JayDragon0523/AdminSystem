package com.first.smr.DAO;

import com.first.smr.POJO.Staff;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface StaffDAO extends JpaRepository<Staff,BigInteger> {

    //查询是否已注册
    Staff findByJobnum(String jobnum);

    //账号登录验证
    Staff findByJobnumAndPswd(String jobnum, String pswd);

    //添加人脸特征信息
    @Modifying
    @Query(value = "update Staff set face_info=?1 where id=?2")
    void addFaceInfo(byte[] face_info, BigInteger id);

    //查询职员参加的历史会议id
    @Query(value = "select appointment_id from attendees where person_id=?1 and state='已出席' and identity='staff' group by id" ,nativeQuery = true)
    List<BigInteger> findMeetingIdByStaff_id(BigInteger staff_id);

    //查询某一会议的所有参会人员id
    @Query(value="select person_id from attendees where appointment_id in ?1 group by person_id",nativeQuery = true)
    List<BigInteger> findStaffIdByMeetingId(List<BigInteger> meeting_id);

    //查询某一职员的历史与会人员
    @Query(value=" select new Staff(s.id,s.name) from Staff s where s.id in (:staffids)")
    List<Staff> getPersonFromHistory(List<BigInteger> staffids);

    /*
     * 根据职工名公司id分页查询职员数据
     * @param name:       职工名
     * @param companyId:  公司id
     * @param pageable:   分页信息
     * @return
     * */
    Page<Staff> findByNameContainingAndCompanyId(String name, BigInteger companyId, Pageable pageable);

    /*
     * 根据公司id分页查询公司数据
     * @param companyId:  公司id
     * @param pageable:   分页信息
     * @return
     * */
    Page<Staff> findByCompanyId(BigInteger companyId, Pageable pageable);

    //根据公司部门查找职员
    @Query("from Staff sl where sl.department=:dname and sl.companyId=:cpid")
    List<Staff> find(@Param("dname") String dname,@Param("cpid") BigInteger cpid);
    //根据职工号查找职员
    @Query("from Staff sl where sl.id=:id")
    Staff findByStaffId(@Param("id") BigInteger id);
}
