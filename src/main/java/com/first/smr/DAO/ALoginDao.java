package com.first.smr.DAO;

import com.first.smr.POJO.Admin;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 * @author daye
 * @create ${2018}-${12}-${20}
 */

@Repository
    public interface ALoginDao extends CrudRepository<Admin,String> {
        @Query(value = "from Admin where account=:ano")
        Admin findByAccount(@Param("ano") String ano);
    }
