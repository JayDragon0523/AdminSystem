package com.first.smr.Controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.first.smr.CommonResult;
import com.first.smr.POJO.Attendees;
import com.first.smr.POJO.Place;
import com.first.smr.Service.PlaceService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/place")
public class PlaceController {
    @Resource
    PlaceService placeService;
    //获取可供预约的会议室列表(职员）
    @RequestMapping(value="/staff/getRecommendList",method = {RequestMethod.POST,RequestMethod.GET})
    public CommonResult getRecommendList(@RequestParam BigInteger companyId, @RequestParam String starttime, @RequestParam String endtime, @RequestParam int duration, @RequestParam int capacity
    ,@RequestParam(required = false) String longitude,@RequestParam(required = false) String latitude)//返回推荐会议室
    {
        return placeService.getRecommendList(companyId,starttime,endtime,duration,capacity,longitude,latitude);
    }

    //获取会议室详情(职员）
    @RequestMapping(value="/staff/getPlaceMess",method =RequestMethod.GET)
    public CommonResult getPlaceMessFromStaff( BigInteger id)
    {
        CommonResult result = new CommonResult();
        try {
            result.setMsg("获取会议室信息成功");
            Place place = placeService.getPlaceMessFromStaff(id);
            System.out.println("PLACE:" + place.getName());
            result.setData(place);
        } catch (Exception e) {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取会议室信息失败");
            result.setResult("fail");
        }
        return result;
    }

    //获取场地信息（游客）
    @RequestMapping(value = "/visitor/getPlaceMess",method = RequestMethod.GET)
    public CommonResult getPlaceMessFromVisitor(BigInteger id)
    {
        CommonResult result=new CommonResult();
        try{
            result.setData(placeService.getPlaceMessFromVisitor(id));
            result.setMsg("获取场地信息成功");
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取场地信息失败");
            result.setResult("fail");
        }
        return result;
    }

    //获取范围内符合条件的会议室信息
    @RequestMapping(value = "/visitor/getPlaceBySphere",method = RequestMethod.POST)
    public  CommonResult getPlaceBySphere(String longitude,String latitude,@RequestParam(defaultValue = "1000") int radius)
    {
        return placeService.getPlaceBySphere(longitude,latitude,radius);
    }

    //根据当前位置和会议室类型查找范围内符合条件的会议室
    @RequestMapping(value = "/visitor/getPlaceBySphereAndTag",method =RequestMethod.POST )
    public CommonResult getPlaceBySphereAndTag(String longitude,String latitude,@RequestParam(defaultValue = "1000")int radius,String tag)
    {
        return placeService.getPlaceBySphereAndTag(longitude,latitude,radius,tag);
    }

    @RequestMapping(value="/{identity}/showBestRecommand")
    @ResponseBody
    public String showBestRecommand(HttpServletResponse response,@PathVariable("identity")String identity, @RequestBody JSONObject datalist, HttpServletRequest request) throws IOException, ServletException {
        JSONArray jsonArray = datalist.getJSONArray("data");
        JSONObject jsonOb = jsonArray.getJSONObject(0);
        JSONArray placelist = jsonOb.getJSONArray("recommends");
        List<Place> places = new ArrayList<>();
        JSONObject jsonOb2 = jsonArray.getJSONObject(1);
        JSONArray placelist2 = jsonOb2.getJSONArray("recommends");
        List<Place> places2 = new ArrayList<>();
        for(int i = 0; i < placelist .size(); i++) {
            JSONObject jsonObc= placelist.getJSONObject(i);
            Place p = new Place();
            String id = jsonObc.get("id").toString();
            String name = jsonObc.get("name").toString();
            String address = jsonObc.get("address").toString();
            String introduction = jsonObc.get("introduction").toString();
            String instruction = jsonObc.get("instruction").toString();
            String type = jsonObc.get("type").toString();
            String capacity = jsonObc.get("capacity").toString();
            String device = jsonObc.get("device").toString();
            p.setId(new BigInteger(id));p.setName(name);p.setAddress(address);p.setInstruction(instruction);
            p.setIntroduction(introduction);p.setType(type);p.setCapacity(Integer.parseInt(capacity));p.setDevice(device);
            places.add(p);
        }
        for(int i = 0; i < placelist2 .size(); i++) {
            JSONObject jsonObc= placelist.getJSONObject(i);
            Place p = new Place();
            String id = jsonObc.get("id").toString();
            String name = jsonObc.get("name").toString();
            String address = jsonObc.get("address").toString();
            String introduction = jsonObc.get("introduction").toString();
            String instruction = jsonObc.get("instruction").toString();
            String type = jsonObc.get("type").toString();
            String capacity = jsonObc.get("capacity").toString();
            String device = jsonObc.get("device").toString();
            p.setId(new BigInteger(id));p.setName(name);p.setAddress(address);p.setInstruction(instruction);
            p.setIntroduction(introduction);p.setType(type);p.setCapacity(Integer.parseInt(capacity));p.setDevice(device);
            places2.add(p);
        }
        request.getSession().setAttribute("bestPlace",places);
        request.getSession().setAttribute("nextPlace",places2);
        return "success";
    }

    @RequestMapping(value="/{identity}/showBestRecommand2")
    public void showBestRecommand2(HttpServletResponse response,@PathVariable("identity")String identity,HttpServletRequest request) throws IOException, ServletException {
        List<Place> places = (List<Place>) request.getSession().getAttribute("bestPlace");
        int count = places.size();
        places= Page.Page(places,request.getParameter("page"),request.getParameter("limit"));
        String ret = JSON.toJSONString(places);
        //System.out.println(ret);
        ret="{\"code\":0,\"msg\":\"\",\"count\": "+count+",\"data\":"+ret+"}";
        sendResponse(response,ret);
    }


    @RequestMapping(value="/{identity}/showNextRecommand")
    public void showNextRecommand(HttpServletResponse response,@PathVariable("identity")String identity,HttpServletRequest request) throws IOException, ServletException {
        List<Place> places = (List<Place>) request.getSession().getAttribute("nextPlace");
        int count = places.size();
        places= Page.Page(places,request.getParameter("page"),request.getParameter("limit"));
        String ret = JSON.toJSONString(places);
        //System.out.println(ret);
        ret="{\"code\":0,\"msg\":\"\",\"count\": "+count+",\"data\":"+ret+"}";
        sendResponse(response,ret);
    }

    private void sendResponse(HttpServletResponse response, String responseText)
            throws ServletException, IOException {
        response.setContentType("text/xml");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(responseText);
    }

}
