package com.smart.AdminDao;

import com.smart.pojo.Administrator;
import com.smart.pojo.Department;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DepartmentDao extends CrudRepository<Department,String> {
    @Query("select dl from Department dl where dl.pm.company_id=:id")
    List<Department> find(@Param("id") String id);
}
