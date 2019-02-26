package com.first.smr.Service;

import com.first.smr.CommonResult;
import com.first.smr.DAO.PlaceDAO;
import com.first.smr.DAO.ScheduleDAO;
import com.first.smr.POJO.Place;
import com.first.smr.POJO.Recommend;
import com.first.smr.POJO.RecommendResult;
import com.first.smr.Util.SMRUtil;
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

    //返回可供预约的会议室
    @Transactional
    public CommonResult getRecommendList(String identity,String starttime, String endtime, int duration, int capacity)//返回会议室推荐列表
    {
        CommonResult result = new CommonResult();
        SMRUtil smrUtil = new SMRUtil();
        try {
            if(identity.equals("staff")) {
                String type = smrUtil.getConferenceType(duration, capacity);//当前会议室类型
                //System.out.println("ＴＹＰＥＯＦＣＯＮＦＥＲＥＮＣＥ:" + type);
                String priority = smrUtil.getPriority(type);//当前检索优先级
                //System.out.println("SEARCHORDER:" + priority);
                SimpleDateFormat formattter1 = new SimpleDateFormat("HH:mm");
                Date start = null;
                Date end = null;
                start = formattter1.parse(starttime);
                end = formattter1.parse(endtime);
                String lastSchedule = smrUtil.getLastSchedule(start, type);
                //System.out.println("LATEST SCHEDULE:" + lastSchedule);
                String startSchedule = smrUtil.getSchedule(start, type);
                //System.out.println("STSRTSCHEDULE:" + startSchedule);
                String endSchedule = smrUtil.getSchedule(end, type);
                //System.out.println("ENDSCHEDULE:" + endSchedule);
                List<Recommend> recommends = new ArrayList<Recommend>();//最佳推荐会议室
                List<Recommend> recommends1 = new ArrayList<Recommend>();//可行会议室
                List<RecommendResult> recommendResults = new ArrayList<RecommendResult>();//推荐结果

                //寻找符合条件的会议室
                for (int i = 0; i < priority.length(); i++) {
                    List<BigInteger> tempPlaceIdList = placeDAO.findIdByType(priority.substring(i, i + 1));//符合该会议类型的场地id
                    List<BigInteger> placeIdList = scheduleDAO.findPlaceIdBetween(startSchedule, endSchedule, tempPlaceIdList);//符合该会议类型和时间段的场地id
                    recommends.addAll(placeDAO.findBestRecommend(placeIdList, priority.substring(i, i + 1), lastSchedule));//最佳推荐
                    recommends1.addAll(placeDAO.findSpareRecommend(placeIdList, priority.substring(i, i + 1), lastSchedule));//可行会议室
                }
                if (recommends.isEmpty() && recommends1.isEmpty()) {
                    result.setMsg("无可用会议室，请更换会议时间");
                    result.setResult("fail");
                } else {
                    for (Recommend r : recommends)
                        System.out.println(r.getName());
                    RecommendResult recommendResult = new RecommendResult();
                    RecommendResult recommendResult1 = new RecommendResult();
                    recommendResult.setMessage("最优推荐");
                    recommendResult.setRecommends(recommends);
                    recommendResults.add(recommendResult);
                    recommendResult1.setMessage("以下会议室在该时间之前存在会议，若会议未按时结束，请点击申请预留，系统将会为你分配预留会议室");
                    recommendResult1.setRecommends(recommends1);
                    recommendResults.add(recommendResult1);
                    result.setMsg("获取会议室信息成功");
                    result.setData(recommendResults);
                }
            }
            else if(identity.equals("visitor"))
            {

            }
        } catch (ParseException e) {
            result.setStatus(500);
            result.setMsg("获取会议室信息失败");
            e.printStackTrace();
            result.setResult("fail");
        }
        return result;
    }

    //获取会议室详情
    public CommonResult getPlaceMess(String identity,BigInteger id) {
        CommonResult result = new CommonResult();
        try {
            if(identity.equals("staff")) {
                result.setMsg("获取会议室信息成功");
                Place place = placeDAO.getOne(id);
                System.out.println("PLACE:" + place.getName());
                result.setData(place);
            }
            else if(identity.equals("visitor"))
            {

            }
        } catch (Exception e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取会议室信息失败");
            result.setResult("fail");
        }
        return result;
    }
}
