package com.smart.AdminDao;

import com.smart.pojo.Administrator;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

/**
 * @author daye
 * @create ${2018}-${12}-${20}
 */

import org.springframework.stereotype.Repository;

@Repository
    public interface ALoginDao extends CrudRepository<Administrator,String> {
        @Query(value = "from Administrator where account=:ano")
        Administrator findByAccount(@Param("ano") String ano);
    }
