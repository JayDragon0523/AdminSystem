package com.first.smr.DAO;

import com.first.smr.POJO.Admin;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;

@Repository
public interface AdminDAO extends JpaRepository<Admin, BigInteger> {
    /*
    * 通过管理员的账号密码身份来找到该对象
    * @param account: 管理员的账号
    * @param pswd:    管理员的密码
    * @param identity 管理员的身份标识，enum("系统管理员","组织管理员")
    * @return: 如果账号密码身份正确匹配，那么返回该对象
    *                                    否则返回null
     */
    Admin findByAccountAndPswdAndIdentity(String account, String pswd, String identity);

    /*
    * 通过管理员的账号、密码、身份、所属公司来找到该对象
    * @param account:  管理员的账号
    * @param pswd:     管理员的密码
    * @param identity  管理员的身份标识，enum("系统管理员","组织管理员")
    * @param companyId 所属公司的id
    * @return 如果正确匹配，那么返回该对象
    *                       否则返回null
    * */
    Admin findByAccountAndPswdAndIdentityAndCompanyId(String account, String pswd, String identity, BigInteger companyId);

    /*
    * 通过管理员的账号身份来找到该对象
    * @param account:  管理员的账号
    * @param identity: 管理员的身份标识，enum("系统管理员","组织管理员")
    * @return: 如果账号存在，那么返回该对象
    *                        否则返回null
    * */
    Admin findByAccountAndIdentity(String account, String identity);

    /*
    * 通过管理员的账号、身份、所属公司来找到该对象
    * @param account:  管理员的账号
    * @param identity: 管理员的身份标识，enum("系统管理员","组织管理员")
    * @param companyId 所属公司的id
    * @return 如果正确匹配，那么返回该对象
    *                       否则返回null
    * */
    Admin findByAccountAndIdentityAndCompanyId(String account, String identity, BigInteger companyId);

    /*
    * 通过管理员的id来找到该对象
    * @param id: 管理员的id
    * @return: 如果id存在，那么返回该对象
    *                      否则返回null
    * */
    Admin findAdminById(BigInteger id);

    /*
     * 根据组织管理员账号分页查询组织管理员数据
     * @param account:  组织管理员账号
     * @param pageable: 分页信息
     * @return
     * */
    Page<Admin> findByAccountContainingAndIdentity(String account, String identity, Pageable pageable);

    /*
     * 分页查询组织管理员数据
     * @param pageable: 分页信息
     * @return
     * */
    Page<Admin> findAllByIdentity(String identity, Pageable pageable);


}
