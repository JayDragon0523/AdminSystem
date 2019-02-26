package com.first.smr.Service;

import com.arcsoft.face.FaceFeature;
import com.arcsoft.face.FaceInfo;
import com.arcsoft.face.FaceSimilar;
import com.arcsoft.face.enums.ImageFormat;
import com.first.smr.CommonResult;
import com.first.smr.DAO.StaffDAO;
import com.first.smr.DAO.VisitorDAO;
import com.first.smr.FaceEngineConfig;
import com.first.smr.ImageInfo;
import com.first.smr.Util.ImageUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@Service
public class FaceService {
    @Resource
    private StaffDAO staffDAO;
    @Resource
    private VisitorDAO visitorDAO;
    private int plusHundred(Float value) {
        BigDecimal target = new BigDecimal(value);
        BigDecimal hundred = new BigDecimal(100f);
        return target.multiply(hundred).intValue();

    }

    //人脸登录
    public CommonResult faceLogin(MultipartFile faceInfo, BigInteger id, String from)
    {
        CommonResult result=new CommonResult();
        if(faceInfo==null)
        {
            result.setMsg("bad image");
            result.setResult("fail");
        }
        else
        {
            try {
                FaceFeature targetFaceFeature = getFaceFeature(faceInfo);
                FaceFeature sourceFaceFeature = new FaceFeature();
                byte[] faceFeature=null;
                if(from.equals("staff"))
                    faceFeature= staffDAO.getOne(id).getFace_info();
                else if(from.equals("visitor"))
                    faceFeature=visitorDAO.getOne(id).getFace_info();
                if(faceFeature==null) {
                    result.setMsg("请先完成人脸认证");
                    result.setResult("fail");
                }
                else {
                    sourceFaceFeature.setFeatureData(faceFeature);
                    FaceSimilar similar = new FaceSimilar();
                    FaceEngineConfig.faceEngine.compareFaceFeature(sourceFaceFeature, targetFaceFeature, similar);
                    if(plusHundred(similar.getScore())>FaceEngineConfig.passRate)
                        result.setMsg("人脸验证通过");
                    else
                    {
                        result.setMsg("无法识别人脸信息，请重试");
                        result.setResult("fail");
                    }
                }
            }
            catch (Exception e)
            {
                e.printStackTrace();
                result.setStatus(500);
                result.setMsg("人脸登录失败");
            }
        }
        return result;
    }

    //获取人脸特征
    private FaceFeature getFaceFeature(MultipartFile faceInfo)
    {
        InputStream inputStream = null;
        try {
            inputStream = faceInfo.getInputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        ImageInfo imageInfo= ImageUtil.getRGBData(inputStream);
        //人脸检测
        List<FaceInfo> faceInfoList = new ArrayList<FaceInfo>();
        FaceEngineConfig.faceEngine.detectFaces(imageInfo.getRgbData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList);
        //提取人脸特征
        FaceFeature faceFeature = new FaceFeature();
        FaceEngineConfig.faceEngine.extractFaceFeature(imageInfo.getRgbData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList.get(0), faceFeature);
        return faceFeature;
    }

    //人脸认证
    @Transactional
    public CommonResult addFaceInfo(MultipartFile faceInfo, BigInteger id, String from)
    {
        CommonResult result=new CommonResult();
        if(faceInfo==null) {
            result.setMsg("bad image,please try again");
        }
        else {
            FaceFeature faceFeature = getFaceFeature(faceInfo);
            try {
                if(from.equals("staff"))
                     staffDAO.addFaceInfo(faceFeature.getFeatureData(), id);
                else if(from.equals("visitor"))
                    visitorDAO.addFaceInfo(faceFeature.getFeatureData(),id);
                result.setMsg("人脸认证成功");
            } catch (Exception e) {
                e.printStackTrace();
                result.setStatus(500);
                result.setMsg("人脸认证失败，请重试");
                result.setResult("fail");
            }
        }
        return result;
    }
}
