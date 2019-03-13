package com.first.smr.DAO;


import com.first.smr.POJO.Place;
import com.first.smr.POJO.Recommend;
import com.first.smr.POJO.Schedule;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface PlaceDAO extends JpaRepository<Place, BigInteger> {

    /*返回 上一时段没有预约的可用会议室信息（最佳推荐）
     *@param type: 会议类型
     * @param lastSchedule: 当前会议的上一时间段
     */
    @Query(value="select new Recommend(p.id,p.name,p.address,p.introduction,p.device,p.instruction,p.capacity,p.type) from Place p,Schedule s where s.placeId in ?1 and p.type=?2 and p.id=s.placeId and s.state='空闲'  and s.schedule=?3 and s.dayOfWeek=?4")
    List<Recommend> findBestRecommend(List<BigInteger> idList,String type, String lastSchedule,String dayOfWeek);

    //返回上一时段有预约的可用会议室
    @Query(value = "select new Recommend(p.id,p.name,p.address,p.introduction,p.device,p.instruction,p.capacity,p.type) from Place p,Schedule s where s.placeId in ?1 and p.type=?2 and p.id=s.placeId and s.state='使用' and s.schedule=?3 and s.dayOfWeek=?4")
    List<Recommend> findSpareRecommend(List<BigInteger> idList,String type,String lastSchedule,String dayOfWeek);

    //获取当前位置一定范围内的会议室
    @Query(value ="SELECT id,type,name,address,introduction,device,instruction,cost,company_id,capacity,company_name,tag from place where ST_Distance_Sphere(location,ST_GeomFromText(?))<?; ",nativeQuery = true)
    List<Place> getPlaceBySphere(String position,int radius);

    //根据当前位置和标签获取一定范围内的会议室
    @Query(value ="SELECT id,type,name,address,introduction,device,instruction,cost,company_id,capacity,company_name,tag from place where ST_Distance_Sphere(location,ST_GeomFromText(?))<? and LOCATE(?, tag)>0 ",nativeQuery = true)
    List<Place> getPlaceBySphereAndTag(String position,int radius,String tag);

    //根据会议室类型获取会议室Id
    @Query(value = "select id from Place where type=?1")
    List<BigInteger> findIdByType(String type);

    //获取每种类型会议室的数目
    int countPlaceByType(String type);


    //获取场地id
    @Query(value = "select id from Place where type in ?1 and companyId=?2")
    List<BigInteger> getPlaceIdByTypeAndCompanyId(List<String> typeList,BigInteger companyId);

    /*
     * 根据场地名分页查询场地数据
     * @param name:     场地名
     * @param pageable: 分页信息
     * @return
     * */
    List<Place> findByNameContaining(String name);

    /*
     * 分页查询公司数据
     * @param pageable: 分页信息
     * @return
     * */
    List<Place> findAll();

    /*
     * 根据场地名公司id分页查询场地数据
     * @param name:       场地名
     * @param companyId: 公司id
     * @param pageable:   分页信息
     * @return
     * */
    List<Place> findByNameContainingAndCompanyId(String name, BigInteger companyId);

    /*
     * 根据公司id分页查询公司数据
     * @param companyId: 公司id
     * @param pageable:   分页信息
     * @return
     * */
    List<Place> findByCompanyId(BigInteger companyId);

    @Query(value="from Place where id=?1")
    Place findOne(BigInteger id);
}
