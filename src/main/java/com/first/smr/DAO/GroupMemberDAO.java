package com.first.smr.DAO;

import com.first.smr.POJO.GroupMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface GroupMemberDAO extends JpaRepository<GroupMember, BigInteger> {

    @Query(value = "select group_id from groupmember where person_id=?1 and group_id not in ?2 and identity='staff'",nativeQuery = true)
    List<BigInteger> getGroupId(BigInteger personId, List<BigInteger> groupIdList);

}
