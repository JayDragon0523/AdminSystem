package com.first.smr.Service;

import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.first.smr.CommonResult;
import com.first.smr.DAO.*;
import com.first.smr.POJO.*;
import com.first.smr.Util.SMRUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class PlaceService {
    @Resource
    PlaceDAO placeDAO;
    @Resource
    ScheduleDAO scheduleDAO;
    @Resource
    EvaluationDAO evaluationDAO;
    @Resource
    RecommendDAO recommendDAO;
    @Resource
    VisitorScheduleDAO visitorScheduleDAO;
    @Resource
    SMRUtil smrUtil;
    @Resource
    RedisTemplate redisTemplate;

    //返回可供预约的会议室(职员)
    @Transactional
    public CommonResult getRecommendList(BigInteger companyId,String starttime, String endtime, int duration, int capacity,String longitude,String latitude)//返回会议室推荐列表
    {
        CommonResult result = new CommonResult();
        try {
            ScheduleConfig scheduleConfig=smrUtil.getScheduleConfigFromRedis(companyId);
            String type = smrUtil.getConferenceType(scheduleConfig,duration, capacity);//当前会议室类型
            String priority = smrUtil.getPriority(scheduleConfig,type);//当前检索优先级
            SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat formattter1 = new SimpleDateFormat("HH:mm");
            SimpleDateFormat formattter2 = new SimpleDateFormat("yyyy-MM-dd");
            Date start = null;
            Date end = null;
            String position="POINT("+longitude+" "+latitude+")";
            start = format.parse(starttime);
            end = format.parse(endtime);
            String lastSchedule = smrUtil.getLastSchedule(scheduleConfig,formattter1.parse(formattter1.format(start)), type);
            String startSchedule = smrUtil.getSchedule(scheduleConfig,formattter1.parse(formattter1.format(start)), type);
            String endSchedule = smrUtil.getSchedule(scheduleConfig,formattter1.parse(formattter1.format(end)), type);
            List<Object> recommends = new ArrayList<Object>();//最佳推荐会议室
            List<Object> recommends1 = new ArrayList<Object>();//次优会议室
            List<Object> recommends2=new ArrayList<Object>();//外部推荐场地场地
            List<RecommendResult> recommendResults = new ArrayList<RecommendResult>();//推荐结果
            List<BigInteger> placeIdofCompany=placeDAO.getPlaceIdByCompanyIdForStaff(formattter1.format(start),formattter1.format(end),companyId);
            if(!placeIdofCompany.isEmpty())
                recommends2.addAll(placeDAO.getPlaceBySphereForStaff(position,2000,placeIdofCompany));
            //寻找符合条件的会议室
            start=formattter2.parse(formattter2.format(start));
            for (int i = 0; i < priority.length(); i++) {
                List<BigInteger> tempPlaceIdList = placeDAO.findIdByType(priority.substring(i, i + 1));//符合该会议类型的场地id
                for(BigInteger item:tempPlaceIdList)
                    System.out.println("temp:"+item);
                List<BigInteger> placeIdList = scheduleDAO.findPlaceIdBetween(startSchedule, endSchedule, tempPlaceIdList);//符合该会议类型和时间段的场地id
                for(BigInteger item:placeIdList)
                    System.out.println("placeID:"+item);
                String dayOfWeek=smrUtil.getDayOfWeek(start);
                System.out.println(dayOfWeek);
                recommends.addAll(recommendDAO.findBestRecommend(position,placeIdList, priority.substring(i, i + 1), lastSchedule,dayOfWeek));//最佳推荐
                System.out.println("priority:"+priority.substring(i, i + 1));
                System.out.println("lastSchedule:"+lastSchedule);
                recommends1.addAll(recommendDAO.findSpareRecommend(position,placeIdList, priority.substring(i, i + 1), lastSchedule,dayOfWeek));//可行会议室
            }
            if (recommends.isEmpty() && recommends1.isEmpty()) {
                result.setMsg("无可用会议室，请更换会议时间");
                result.setResult("fail");
            }
            else {
                RecommendResult recommendResult = new RecommendResult();//最优推荐
                RecommendResult recommendResult1 = new RecommendResult();//次优推荐
                RecommendResult recommendResult2=new RecommendResult();//外部场地推荐
                recommendResult.setMessage("最优推荐");
                recommendResult.setRecommends(recommends);
                recommendResults.add(recommendResult);
                recommendResult1.setMessage("以下会议室在该时间之前存在会议，若会议未按时结束，请点击申请预留，系统将会为你分配预留会议室");
                recommendResult1.setRecommends(recommends1);
                recommendResults.add(recommendResult1);
                if(recommends2.isEmpty())
                    recommendResult2.setMessage("暂无外部推荐场地");
                else
                    recommendResult2.setMessage("外部推荐场地");
                recommendResult2.setRecommends(recommends2);
                recommendResults.add(recommendResult2);
                result.setMsg("获取会议室信息成功");
                result.setData(recommendResults);

            }
        }
        catch (ParseException e) {
            result.setStatus(500);
            result.setMsg("获取会议室信息失败");
            e.printStackTrace();
            result.setResult("fail");
        }
        return result;
    }

    //获取会议室详情(职员）
    @JsonView(Place.StaffView.class)
    public Place getPlaceMessFromStaff(BigInteger id) {
        //先从缓存中查找看是否存在相关信息
        String key="Place:"+id.toString();
        ObjectMapper objectMapper=new ObjectMapper();
        Place place;
        place=objectMapper.convertValue(redisTemplate.opsForValue().get(key),Place.class);
        if(place==null)
            placeDAO.getOne(id);
        return place;
    }

    //获取会议室详情（游客）
    @JsonView(Place.VisitorView.class)
    public Place getPlaceMessFromVisitor(BigInteger placeId)
    {
        String key="Place:"+placeId.toString();
        ObjectMapper objectMapper=new ObjectMapper();
        Place place;
        place=objectMapper.convertValue(redisTemplate.opsForValue().get(key),Place.class);
        if(place==null)
            place=placeDAO.getOne(placeId);
        Pageable pageable=new PageRequest(0,4, Sort.Direction.DESC,"time");
        Page evaluationPage=evaluationDAO.getEvaluationByPlaceId(placeId,pageable);
        place.setEvaluations(evaluationPage.getContent());
        return place;
    }

    //根据当前位置查找一定范围内的会议室
    public CommonResult getPlaceBySphere(String longitude,String latitude,int radius)
    {
        CommonResult result=new CommonResult();
        try{
            String currentPosition="POINT("+longitude +" "+latitude+")";
            List<Place> placeList=placeDAO.getPlaceBySphere(currentPosition,radius);
            if(placeList.size()==0)
            {
                result.setMsg("该范围内不存在符合条件的会议室");
                result.setResult("fail");
            }
            else
            {
                result.setMsg("成功获取信息");
                result.setData(placeList);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取该范围内场地数据失败");
            result.setResult("fail");
        }
        return result;
    }

    //根据当前位置和会议室类型查找范围内符合条件的会议室
    public CommonResult getPlaceBySphereAndTag(String longitude,String latitude,int radius,String tag)
    {
        CommonResult result=new CommonResult();
        try
        {
            String currentPosition="POINT("+longitude +" "+latitude+")";
            List<Place> placeList=placeDAO.getPlaceBySphereAndTag(currentPosition,radius,tag);
            if(placeList.size()==0)
            {
                result.setMsg("该范围内不存在符合条件的会议室");
                result.setResult("fail");
            }
            else
            {
                result.setMsg("成功获取信息");
                result.setData(placeList);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取该范围内场地数据失败");
        }
        return result;
    }

    //获取外部场地的时间段和使用状况
    public CommonResult getScheduleOfOutsidePlace(BigInteger placeId)
    {
        CommonResult result=new CommonResult();
        try
        {
            List<VisitorSchedule> visitorScheduleList=visitorScheduleDAO.findAllByPlaceId(placeId);
            result.setMsg("获取场地时间安排成功");
            result.setData(visitorScheduleList);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取时间段失败");
            result.setResult("fail");
        }
        return result;
    }

}
