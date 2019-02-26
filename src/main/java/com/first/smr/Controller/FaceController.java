package com.first.smr.Controller;

import com.first.smr.CommonResult;
import com.first.smr.Service.FaceService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.math.BigInteger;

@RestController
@RequestMapping("/face")
public class FaceController {
    @Resource
    private FaceService faceService;

    //人脸登录
    @RequestMapping(value="/login",method= RequestMethod.POST)
    public CommonResult faceLogin(@RequestParam("faceInfo") MultipartFile faceInfo, @RequestParam("personId") BigInteger personId, @RequestParam("from")String from)
    {
        return faceService.faceLogin(faceInfo,personId,from);
    }

    //人脸认证
    @RequestMapping(value="/addFaceInfo",method = RequestMethod.POST)
    public  CommonResult addFaceInfo(@RequestParam("faceInfo") MultipartFile faceInfo, @RequestParam("personId") BigInteger personId, @RequestParam("from")String from)
    {
        return faceService.addFaceInfo(faceInfo,personId,from);
    }

}
