package com.first.smr.DAO;

import com.first.smr.POJO.Evaluation;
import com.first.smr.POJO.Place;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface EvaluationDAO extends JpaRepository<Evaluation, BigInteger> {
    @Query(value="from Evaluation  where place_id in (:places)")
    List<Evaluation> findByCompanyId(List<BigInteger> places);
    @Query(value="from Evaluation  where id=:id")
    Evaluation findOne(BigInteger id);
}
