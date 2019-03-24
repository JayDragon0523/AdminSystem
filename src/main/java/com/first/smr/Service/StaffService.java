package com.first.smr.Service;

import com.first.smr.CommonResult;
import com.first.smr.DAO.GroupDAO;
import com.first.smr.DAO.GroupMemberDAO;
import com.first.smr.DAO.StaffDAO;
import com.first.smr.POJO.Group;
import com.first.smr.POJO.GroupMember;
import com.first.smr.POJO.RecommendResult;
import com.first.smr.POJO.Staff;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@Service
public class StaffService {
    @Resource
    StaffDAO staffDAO;
    @Resource
    GroupDAO groupDAO;
    @Resource
    GroupMemberDAO groupMemberDAO;
    @Resource
    EntityManager entityManager;
    @Transactional

    //账号登录
    public CommonResult accountLogin(String company,String jobnum,String pswd)
    {
        CommonResult result=new CommonResult();
        try
        {
            Staff temp=null;
            if(staffDAO.existsStaffByCompany(company)) {
                temp = staffDAO.findByJobnumAndCompany(jobnum, company);
                if (temp == null) {
                    result.setMsg("账号不存在或账号错误");
                    result.setResult("fail");
                } else if (!temp.getPswd().equals(pswd)) {
                    result.setMsg("密码错误");
                    result.setResult("fail");
                } else {
                    result.setMsg("登录成功");
                    if(temp.getFace_info()!=null)
                        temp.setIdentified(true);
                    else
                        temp.setIdentified(false);
                    result.setData(temp);
                }
            }
            else
            {
                result.setResult("fail");
                result.setMsg("匹配不到该公司，请确认输入正确");
            }
        }
        catch(Exception e)
        {
            result.setStatus(500);
            result.setMsg("登录失败！");
            result.setResult("fail");
        }
        return result;
    }

    //账号登录
    public Staff login(String company,String jobnum,String pswd)
    {
        Staff temp=null;
        CommonResult result=new CommonResult();
        try
        {
            if(staffDAO.existsStaffByCompany(company)) {
                temp = staffDAO.findByJobnumAndCompany(jobnum, company);
                if (temp == null) {
                    result.setMsg("账号不存在或账号错误");
                    result.setResult("fail");
                } else if (!temp.getPswd().equals(pswd)) {
                    result.setMsg("密码错误");
                    result.setResult("fail");
                    return null;
                } else {
                    result.setMsg("登录成功");
                    if(temp.getFace_info()!=null)
                        temp.setIdentified(true);
                    else
                        temp.setIdentified(false);
                    result.setData(temp);
                }
            }
            else
            {
                result.setResult("fail");
                result.setMsg("匹配不到该公司，请确认输入正确");
                return null;
            }
        }
        catch(Exception e)
        {
            result.setStatus(500);
            result.setMsg("登录失败！");
            result.setResult("fail");
            return null;
        }
        return temp;
    }

    //修改密码
    @Transactional
    public CommonResult alterPass(BigInteger staffId,String oldPass,String newPass)
    {
        CommonResult result=new CommonResult();
        try
        {
            if(newPass==null)
            {
                result.setMsg("密码不能为空");
                result.setResult("fail");
            }
            else {
                Staff staff = staffDAO.getOne(staffId);
                if (staff.getPswd().equals(oldPass)) {
                    staff.setPswd(newPass);
                    result.setMsg("修改密码成功");
                } else {
                    result.setMsg("原密码不正确");
                    result.setResult("fail");
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setMsg("修改密码失败");
            result.setResult("fail");
            result.setStatus(500);
        }
        return  result;
    }

    //注册
    @Transactional
    public CommonResult regist(Staff s)
    {
        CommonResult result=new CommonResult();
        Staff temp=staffDAO.findByJobnumAndCompany(s.getJobnum(),s.getCompany());
        try {
            if(temp==null)
            {
                staffDAO.save(s);
                result.setMsg("注册成功");
                result.setData(s.getId());
            }
            else
            {
                result.setMsg("该账号已注册，请勿重复注册");
                result.setResult("fail");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("注册失败");
            result.setResult("fail");
        }
        return result;
    }

    /*
    获取历史与会人员
    @param id   预约人的唯一标识
     */
    public CommonResult getPersonFromHistory(BigInteger staffId)
    {
        CommonResult result=new CommonResult();

        try {
            List<BigInteger> meeting_id = staffDAO.findMeetingIdByStaff_id(staffId);
            if(meeting_id.size()!=0) {
                List<BigInteger> staff_id = staffDAO.findStaffIdByMeetingId(meeting_id);
                List<Staff> person = staffDAO.getPersonFromHistory(staff_id);
                result.setMsg("获取与会人员成功");
                result.setData(person);
            }else {
                result.setStatus(500);
                result.setMsg("无历史与会人员，请继续点击提交");
                result.setResult("fail");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setStatus(500);
            result.setMsg("获取与会人员失败");
            result.setResult("fail");
        }
        return result;
    }

    //建立群组并将成员加入群组视图
    @Transactional
    public CommonResult createGroup(String groupName,List<GroupMember> groupMemberList)
    {
        CommonResult result=new CommonResult();
        try
        {
            String code=createTableOfGroup(groupName,groupMemberList,"永久");
            result.setMsg("建立群组成功！");
            result.setData(code);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setMsg("添加群组失败");
            result.setResult("fail");
            result.setStatus(500);
        }
        return result;
    }

    //加入群组
    public CommonResult joinGroup(String groupId,List<GroupMember> groupMemberList)
    {
        CommonResult result=new CommonResult();
        try
        {
            System.out.println("INSERT:"+insertIntoGroupTable(groupId,groupMemberList));
            result.setMsg("加入群组成功");
            result.setData(groupId);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setMsg("加入群组失败");
            result.setStatus(500);
            result.setResult("fail");
        }
        return result;
    }

    public String insertIntoGroupTable(String groupId,List<GroupMember> groupMemberList)
    {
        String groupTableName="Group"+groupId;
        String sqlOfJoinGroup="";
        for(GroupMember groupMember:groupMemberList) {
            if (groupMember.getIdentity().equals("staff")) {
                sqlOfJoinGroup = "insert into " + groupTableName + "(person_id,identity,name,protrait,face_info) select id,identity,name,protrait,face_info from staff where  id="+groupMember.getPersonId() ;
            }
            if (groupMember.getIdentity().equals("visitor")) {
                sqlOfJoinGroup = "insert into " + groupTableName + " (person_id,identity,name,protrait,face_info) select id,identity,name,protrait,face_info from visitor where  id="+groupMember.getPersonId() ;
            }
            Query query=entityManager.createNativeQuery(sqlOfJoinGroup);
            query.executeUpdate();
        }
        entityManager.clear();
        return groupId;
    }

    @Transactional
    public String  createTableOfGroup(String groupName, List<GroupMember> groupMemberList, String style)
    {
        if(groupName==null)
            groupName="未命名";
        Group group=new Group();
        group.setGroupLeader(groupMemberList.get(0).getPersonId());
        group.setGroupName(groupName);
        group.setGroupStyle(style);
        group.setGroupMembers(groupMemberList);
        groupDAO.save(group);
        for(GroupMember groupMember:groupMemberList)
            groupMember.setGroupId(group.getId().toString());
        groupMemberDAO.saveAll(groupMemberList);
        String groupId=group.getId().toString();
        String sqlOfCreateGroup="create table Group" +groupId+" (person_id BIGINT NOT NULL,identity VARCHAR(20) NOT NULL,name VARCHAR(45) NOT NULL,protrait VARCHAR(255),face_info BLOB NOT NULL); ";
        Query query=entityManager.createNativeQuery(sqlOfCreateGroup);
        query.executeUpdate();
        entityManager.close();
        insertIntoGroupTable(groupId,groupMemberList);
        return groupId;
    }

    //获取所在群组
    public CommonResult getGroup(BigInteger staffId)
    {
        CommonResult result=new CommonResult();
        try {
            List<RecommendResult> recommendResults = new ArrayList<RecommendResult>();
            RecommendResult recommendResult = new RecommendResult();//创建的群
            RecommendResult recommendResult1 = new RecommendResult();//所在的群
            List<Object> groups = new ArrayList<Object>();
            List<Object> groups1 = new ArrayList<Object>();
            groups.addAll(groupDAO.getGroupsByGroupLeader(staffId));
            recommendResult.setMessage("创建的群");
            recommendResult.setRecommends(groups);
            List<BigInteger> groupIdList1 = groupDAO.getGroupIdCreatedBy(staffId);
            if (groupIdList1.isEmpty())
                result.setMsg("您没有创建群组");
            else {
                List<BigInteger> groupIdList2 = groupMemberDAO.getGroupId(staffId, groupIdList1);
                if (!groupIdList2.isEmpty())
                    groups1.addAll(groupDAO.getGroupsByIdList(groupIdList2));
            }
            recommendResult1.setMessage("所在的群");
            recommendResult1.setRecommends(groups1);
            recommendResults.add(recommendResult);
            recommendResults.add(recommendResult1);
            result.setMsg("获取群组成功");
            result.setData(recommendResults);

        }
        catch (Exception e)
        {
            e.printStackTrace();
            result.setMsg("获取群组失败");
            result.setStatus(500);
            result.setResult("fail");
        }
        return result;
    }
}
