package com.first.smr.DAO;

import com.first.smr.POJO.Attendees;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface AttendeesDAO extends JpaRepository<Attendees, BigInteger> {
    Attendees findByPersonId(BigInteger id);
    List<Attendees> findByAppointmentId(BigInteger id);
}
