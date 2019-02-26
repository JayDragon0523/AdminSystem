package com.first.smr.Service;

import com.first.smr.DAO.EvaluationDAO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class EvaluationService {
    @Resource
    EvaluationDAO evaluation;
}
