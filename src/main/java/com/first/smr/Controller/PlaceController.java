package com.first.smr.Controller;

import com.first.smr.CommonResult;
import com.first.smr.Service.PlaceService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.math.BigInteger;

@RestController
@RequestMapping("/place")
public class PlaceController {
    @Resource
    PlaceService placeService;
    //获取可供预约的会议室列表
    @RequestMapping(value="/{identity}/getRecomandList",method = RequestMethod.POST)
    public CommonResult getRecommendList(@PathVariable("identity")String identity, @RequestParam String starttime, @RequestParam String endtime, @RequestParam int duration, @RequestParam int capacity)//返回推荐会议室
    {
        return placeService.getRecommendList(identity,starttime,endtime,duration,capacity);
    }

    //获取会议室详情
    @RequestMapping(value="/{identity}/getPlaceMess",method = RequestMethod.GET)
    public CommonResult getPlaceMess(@PathVariable("identity")String identity, BigInteger id)
    {
        return placeService.getPlaceMess(identity,id);
    }

}
