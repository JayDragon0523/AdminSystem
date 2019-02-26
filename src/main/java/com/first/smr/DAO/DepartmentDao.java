package com.first.smr.DAO;

import com.first.smr.POJO.Department;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface DepartmentDao extends CrudRepository<Department,BigInteger> {
    @Query("select dl from Department dl where dl.pm.company_id=:id")
    List<Department> find(@Param("id") BigInteger id);
}
