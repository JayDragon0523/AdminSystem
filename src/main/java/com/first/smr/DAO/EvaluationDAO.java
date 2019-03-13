package com.first.smr.DAO;

import com.first.smr.POJO.Evaluation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface EvaluationDAO extends JpaRepository<Evaluation, BigInteger> {

    //分页获取评论
    Page<Evaluation> getEvaluationByPlaceId(BigInteger placeId, Pageable pageable);

    //删除评论
    @Query(value = "delete from evaluation where id=?1",nativeQuery = true)
    @Modifying
    void deleteEvaluationById(BigInteger evaluationId);

    @Query(value="from Evaluation e where e.placeId in (:placeId)")
    List<Evaluation> findByCompanyId(List<BigInteger> placeId);
}
