package com.first.smr.DAO;

import com.first.smr.POJO.Company;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public interface CompanyDAO extends JpaRepository<Company, BigInteger> {
    /*
     * 根据公司名分页查询公司数据
     * @param name:     公司名
     * @param pageable: 分页信息
     * @return
     * */
    List<Company> findByNameContaining(String name);

    @Query(value="from Company c where c.name=?1 and c.state='申请中'")
    List<Company> findByNameContaining2(String name);

    /*
     * 分页查询公司数据
     * @param pageable: 分页信息
     * @return
     * */
    Page<Company> findAll(Pageable pageable);

    /*
    * 根据公司名来查找公司对象
    * @param name: 公司名
    * @return  如果公司名存在，那么返回该公司对象
    *                          否则返回null
    * */
    Company findByName(String name);

    /*
    * 根据公司id来查找公司对象
    * @return  如果公司存在，那么返回该公司对象
    *                        否则返回null
    * */
    Company findCompanyById(BigInteger id);

    @Query(value="from Company c where c.state='申请中'")
    List<Company> findApplyAll();
}
