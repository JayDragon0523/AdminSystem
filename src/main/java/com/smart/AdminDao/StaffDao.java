package com.smart.AdminDao;

import com.smart.pojo.Staff;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface StaffDao extends CrudRepository<Staff,String> {
    @Query("select sl from Staff sl where sl.department_name=:dname   ")
    List<Staff> find(@Param("dname") String dname);
}
