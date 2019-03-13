package com.first.smr.Service;

import com.first.smr.CommonResult;
import com.first.smr.DAO.EvaluationDAO;
import com.first.smr.POJO.Evaluation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigInteger;

@Service
public class EvaluationService {
    @Resource
    EvaluationDAO evaluationDAO;
    //发表评论
    @Transactional
    public CommonResult evaluate(Evaluation evaluation)
    {
        CommonResult result=new CommonResult();
        try
        {
            evaluationDAO.save(evaluation);
            result.setMsg("发表评论成功");
            result.setData(evaluation.getId());
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setResult("fail");
            result.setStatus(500);
            result.setMsg("发表评论失败");
        }
        return result;
    }

    //删除评论
    @Transactional
    public  CommonResult delete(BigInteger evaluationId)
    {
        CommonResult result=new CommonResult();
        try
        {
            evaluationDAO.deleteEvaluationById(evaluationId);
            result.setMsg("删除评论成功");
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setResult("fail");
            result.setMsg("删除评论失败");
        }
        return result;
    }

    //获取场地相关评论
    public CommonResult getEvaluationAboutPlace(BigInteger placeId,int page,int size)
    {
        CommonResult result=new CommonResult();
        try
        {
            Pageable pageable=new PageRequest(page,size, Sort.Direction.DESC,"time");
            Page evaluationPage=evaluationDAO.getEvaluationByPlaceId(placeId,pageable);
            result.setMsg("获取评论成功");
            System.out.println("SIZE:"+evaluationPage.getTotalElements());
            result.setData(evaluationPage.getContent());
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setMsg("获取评论失败");
            result.setStatus(500);
        }
        return result;
    }
}
