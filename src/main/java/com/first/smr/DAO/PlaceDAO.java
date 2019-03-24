package com.first.smr.DAO;


import com.first.smr.POJO.Place;
import com.first.smr.POJO.Recommend;
import com.first.smr.POJO.Schedule;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
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
//@Query(value="select new Recommend(p.id,p.name,p.address,p.introduction,p.device,p.instruction,p.capacity,p.type) from Place p,Schedule s where s.placeId in ?1 and p.type=?2 and p.id=s.placeId and s.state='空闲'  and s.schedule=?3 and s.dayOfWeek=?4")

//  List<Recommend> findBestRecommend(List<BigInteger> idList,String type, String lastSchedule,String dayOfWeek);

    //存入经纬度
    @Modifying
    @Query(value="update place set location=ST_GeomFromText(?) where id=? ",nativeQuery = true)
    void setLocationForPlace(String location,BigInteger placeId);

    //获取当前位置一定范围内的会议室
    @Query(value ="SELECT id,type,name,address,introduction,device,instruction,cost,company_id,capacity,company_name,tag,ST_Distance_Sphere(location,ST_GeomFromText(?)) as distance from place where distance<? order by distance asc; ",nativeQuery = true)
    List<Place> getPlaceBySphere(String position,int radius);

    //根据职员位置获取外部会议室
    @Query(value ="SELECT id,type,name,address,introduction,device,instruction,cost,company_id,capacity,company_name,tag,ST_Distance_Sphere(location,ST_GeomFromText(?)) as distance from place where distance<? and id not in ? order by distance asc; ",nativeQuery = true)
    List<Place> getPlaceBySphereForStaff(String position,int radius,List<BigInteger> placeIdList);


    //根据当前位置和标签获取一定范围内的会议室
    @Query(value ="SELECT id,type,name,address,introduction,device,instruction,cost,company_id,capacity,company_name,tag,ST_Distance_Sphere(location,ST_GeomFromText(?)) as distance from place where distance<? and LOCATE(?, tag)>0 order by distance asc ",nativeQuery = true)
    List<Place> getPlaceBySphereAndTag(String position,int radius,String tag);

    //根据会议室类型获取会议室Id
    @Query(value = "select id from Place where type=?1")
    List<BigInteger> findIdByType(String type);

    //获取每种类型会议室的数目
    int countPlaceByType(String type);

    //根据公司和场地类型获取对应场地id
    @Query(value = "select id from Place where type in ?1 and companyId=?2")
    List<BigInteger> getPlaceIdByTypeAndCompanyId(List<String> typeList,BigInteger companyId);

    //根据获取公司的场地id
    @Query(value ="SELECT place_id FROM visitorschedule where start<?1 and end>?2 and state='空闲' and place_id not in (select id from place where company_id =?3)",nativeQuery = true)
    List<BigInteger> getPlaceIdByCompanyIdForStaff(String start,String end,BigInteger companyId);

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
