package com.first.smr.DAO;


import com.first.smr.POJO.ScheduleConfig;
import org.springframework.data.jpa.repository.JpaRepository;

import java.math.BigInteger;

public interface ScheduleConfigDAO extends JpaRepository<ScheduleConfig, BigInteger> {
    ScheduleConfig findScheduleConfigByCompanyId(BigInteger companyId);
}
