package com.first.smr.Controller;

import com.first.smr.Service.EvaluationService;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class EvaluationController {
    @Resource
    EvaluationService evaluation;
}
