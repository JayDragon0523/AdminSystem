
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>智能会议管理系统</title>
    <link rel="stylesheet" href="/layui/css/layui.css">
    <link rel="stylesheet" href="/layui/css/site.css">
    <script src="/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <%--查询经纬度--%>
    <style type="text/css">
        #mapContainer{
            position: absolute;
            top:0;
            left: 0;
            right:0;
            bottom:0;
        }

        #tip{
            background-color:#fff;
            border:1px solid #ccc;
            padding-left:10px;
            padding-right:2px;
            position:absolute;
            min-height:65px;
            top:10px;
            font-size:12px;
            right:10px;
            border-radius:3px;
            overflow:hidden;
            line-height:20px;
            min-width:30%;
        }
        #tip input[type="button"]{
            background-color: #0D9BF2;
            height:25px;
            text-align:center;
            line-height:25px;
            color:#fff;
            font-size:12px;
            border-radius:3px;
            outline: none;
            border:0;
            cursor:pointer;
        }

        #tip input[type="text"]{
            height:25px;
            border:1px solid #ccc;
            padding-left:5px;
            border-radius:3px;
            outline:none;
        }
        #pos{
            height: 110px;
            background-color: #fff;
            padding-left: 10px;
            padding-right: 10px;
            position:absolute;
            font-size: 12px;
            right: 10px;
            bottom: 30px;
            border-radius: 3px;
            line-height: 30px;
            border:1px solid #ccc;
        }
        #pos input{
            border:1px solid #ddd;
            height:23px;
            border-radius:3px;
            outline:none;
            width: 100px;
        }

        #result1{
            max-height:300px;
        }
        b{
            display: block;margin: 5px 0;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">组织管理员端</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    ${sessionScope.OAdmin.getId_num()}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" onclick="myInfoPage();">个人资料</a></dd>
                    <dd><a href="javascript:;" onclick="mySafePage();">安全设置</a></dd>
                    <dd><a href="javascript:;" onclick="myCompanyPage();">公司信息</a></dd>
                    <dd><a href="javascript:;" onclick="myMeetingPage();">会议信息</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="http://localhost:8080">注销</a></li>
        </ul>
    </div>
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="some">

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">信息管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="myInfoPage();">个人资料</a></dd>
                        <dd><a href="javascript:;" onclick="mySafePage();">安全设置</a></dd>
                        <dd><a href="javascript:;" onclick="myCompanyPage();">公司信息</a></dd>
                        <dd><a href="javascript:;" onclick="myMeetingPage();">会议信息</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="queryDepartmentList();myEmployInfoPage();">职员管理</a>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;">场地管理</a>
                    <dl class="layui-nav-child" id="meetingroomList">
                        <dd><a href="javascript:;" onclick="meet1();myMeetingroomPage();queryAppointmentList();" id="meetingroomOrderListSp">场地预约情况</a></dd>
                        <dd><a href="javascript:;" onclick="meet2();myMeetingroomPage();queryPlaceInfo();" id="meetingroomDetailListSp">场地具体信息</a></dd>
                        <dd><a href="javascript:;" onclick="meet3();myMeetingroomPage();" id="addMeetingroomListSp">添加场地</a></dd>
                        <dd><a href="javascript:;" onclick="meet4();myMeetingroomPage();remarkStaff();" id="seeStaffRemarkListSp">查看职员评价</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;">出租管理</a>
                    <dl class="layui-nav-child" id="rentoutList">
                        <dd><a href="javascript:;" onclick="myRentPage();rent1();auditingAppointment();" id="reviewOrderListSp">审核游客预约申请</a></dd>
                        <%--<dd><a href="javascript:;" onclick="myRentPage();rent2();" id="askForPayListSp">申请索赔</a></dd>--%>
                        <dd><a href="javascript:;" onclick="myRentPage();rent3();remarkVisitor();" id="remarkListSp">查看游客评价</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <div id="infoPage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">基本资料</legend>
        </fieldset>
        <form class="layui-form" action="/admin/updateAdmin" method="post" target="teacherInfoFrame">
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">姓名</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.OAdmin.getId_num()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">公司</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.OAdmin.getCompany().getName()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">联系方式</label>
                    <input type="tel" style="width: 500px" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getPhone()}">
                </div>
            </div>
            <input type="hidden" name="password" value="${sessionScope.OAdmin.getPswd()}"/>
            <div class="layui-form-item" align="center">
                <div class="layui-inline">
                    <button class="layui-btn" type="submit" lay-submit="" lay-filter="demo1" onclick="setTimeout(upMessage3,'1000');">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <div id="safePage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">安全设置</legend>
        </fieldset>
        <form class="layui-form" action="/admin/OAdminSafe" method="post">
            <div class="layui-form-item" align="center">
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">新密码</label>
                    <input type="password"  id="newPassword" style="width: 400px"  name="pswd" lay-verify="password" placeholder="请输入新密码" autocomplete="off" class="layui-input">

                    <label class="layui-form-label" align="left">请确认</label>
                    <input type="password" style="width: 400px"  name="repassword" lay-verify="repassword" placeholder="请确认新密码" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-word-aux">请填写6到12位新密码</div>
            </div>
            <div class="layui-form-item" align="center">
                <div class="layui-inline">
                    <button class="layui-btn"  type="submit" lay-submit="" lay-filter="demo1" onclick="setTimeout(upMessage3,'1000');">立即提交</button>
                    <button type="reset"  class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <div id="companyPage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">公司信息</legend>
        </fieldset>
        <form class="layui-form" action="/admin/updateCompanyInfo" method="post" target="teacherInfoFrame">
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">公司名称</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.OAdmin.getCompany().getName()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">公司地址</label>
                    <input type="text" style="width: 500px" name="address" lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getCompany().getAddress()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">注册号</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.OAdmin.getCompany().getRegister_num()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">代表人姓名</label>
                    <input type="text" style="width: 500px"  name="head_name" lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getCompany().getHead_name()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">联系方式</label>
                    <input type="tel" style="width: 500px" name="head_phone" lay-verify="required|phone" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getCompany().getHead_phone()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">开始时间</label>
                    <input type="tel" style="width: 500px" name="open_time" lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getCompany().getOpen_time()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">结束时间</label>
                    <input type="tel" style="width: 500px" name="close_time" lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getCompany().getClose_time()}">
                </div>
            </div>
            <div class="layui-form-item" align="center">
                <div class="layui-inline">
                    <button class="layui-btn" type="submit" lay-submit="" lay-filter="demo1">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <div id="meetingPage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">会议信息</legend>
        </fieldset>
        <form class="layui-form" action="/admin/setScheduleConfig" id="meetingsetting" method="post" target="teacherInfoFrame">
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">公司id</label>
                    <input type="text" style="width: 500px"  lay-verify="required" name="companyId" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getCompany().getId()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">短时会议时长</label>
                    <input type="text" style="width: 500px" name="sduration" lay-verify="required|number" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getScheduleConfig().getSduration()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">中时会议时长</label>
                    <input type="text" style="width: 500px" name="mduration" lay-verify="required|number" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getScheduleConfig().getMduration()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">短时会议时间片</label>
                    <input type="text" style="width: 500px"  name="sSchedule" lay-verify="required|number" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getScheduleConfig().getsSchedule()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">中时会议时间片</label>
                    <input type="tel" style="width: 500px" name="mSchedule" lay-verify="required|number" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getScheduleConfig().getmSchedule()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">长时会议时间片</label>
                    <input type="tel" style="width: 500px" name="lSchedule" lay-verify="required|number" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getScheduleConfig().getlSchedule()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">容量标准</label>
                    <input type="tel" style="width: 500px" name="capacity" lay-verify="required|number" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getScheduleConfig().getCapacity()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">开放时间</label>
                    <input type="tel" style="width: 500px" name="start" lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getScheduleConfig().getStart()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">关闭时间</label>
                    <input type="tel" style="width: 500px" name="end" lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.OAdmin.getScheduleConfig().getEnd()}">
                </div>
            </div>
            <div class="layui-form-item" align="center">
                <div class="layui-inline">
                    <button class="layui-btn" type="button" lay-submit="" lay-filter="demo1" onclick="upMessage1()">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <div id="employeeInfoPage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <!-- 所有部门 -->
        <div style="display:block;" id="departmentListSpan">
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>所有部门信息</legend>
            </fieldset>
            <div class="layui-row layui-col-space155" style="background-color: rgb(242,242,242);" id="departmentList">
                <div id="seeDepartment"></div>
            </div>
        </div>
        <div style="display:none;" id="employeeInformationListSpan">
            <fieldset id="employeeManage"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>职员管理</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li>职员信息</li>
                    <li>添加职员</li>
                    <li>查找职员</li>
                    <li id="updateStaff" style="display:none;">职员信息修改</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--职员信息--%>
                    <div class="layui-tab-item"><table class="layui-hide" id="test" lay-filter="test"></table></div>
                    <%--添加职员--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm" action="/admin/OAddOrUpdateStaff"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">职员工号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="jobnum" required  lay-verify="required" placeholder="请输入职员工号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">职员姓名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" required  lay-verify="required" placeholder="请输入职员姓名" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">性别</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="sex" value="男" title="男" checked>
                                    <input type="radio" name="sex" value="女" title="女">
                                </div>
                            </div>
                            <%--获取部门下拉列表--%>
                            <script>
                                $(document).ready(function () {
                                    var url="/admin/getDepartmentOptions";
                                    $.ajax({
                                        type:"get",
                                        url:url,//访问后台去数据库查询select的选项
                                        success:function(userList){
                                            var data = userList.data;
                                            var form = layui.form;
                                            console.log(data);
                                            var unitObj=document.getElementById("mySelect");
                                            if(userList!=null){ //后台传回来的select选项
                                                for(var i=0;i<data.length;i++){
                                                    //遍历后台传回的结果，一项项往select中添加option
                                                    unitObj.options.add(new Option(data[i].pm.department_name,data[i].pm.department_name));
                                                    //alert(data[i].pm.department_name);
                                                }
                                            }
                                            form.render();
                                        },
                                        error:function(){
                                            alert('Error');
                                        }
                                    })
                                })
                            </script>
                            <div class="layui-form-item">
                                <label class="layui-form-label">部门</label>
                                <div class="layui-input-block">
                                    <select name="department" id="mySelect" lay-filter="department">
                                        <option value="请选择"></option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">身份证号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="id_num" required  lay-verify="required" placeholder="请输入身份证号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">联系方式</label>
                                <div class="layui-input-block">
                                    <input type="text" name="phone" required  lay-verify="required" placeholder="请输入联系方式" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">登陆密码</label>
                                <div class="layui-input-block">
                                    <input type="password" name="pswd" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <input type="hidden" id="isIdentified" name="isIdentified" value="false">
                            <div class="layui-form-item">
                                <button type="button" id="messageFormSubmit" class="layui-btn" onclick="setTimeout(upMessage,'1000');">确认添加</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset">重置</button>
                            </div>
                        </form>
                        <script type="text/html" id="barOP">
                            <a class="layui-btn layui-btn-xs" lay-event="change" id="changeButton">修改</a>
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
                        </script>
                    </div>
                    <%--查找职员--%>
                    <div class="layui-tab-item">
                        <div class="layui-form-item">
                            <label class="layui-form-label">输入工号:</label>
                            <div class="layui-input-block">
                                <input type="text" name="jobnum" id="jobnum" autocomplete="off" placeholder="请输入职员工号" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button  class="layui-btn" lay-submit lay-filter="formDemo10" onclick="findTheEmployee();">立即查询</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                            </div>
                        </div>

                        <table id="one" lay-filter="one"></table>
                    </div>
                    <%--职员信息修改表单--%>
                    <div class="layui-tab-item" id="updateStaffItem">
                        <form class="layui-form layui-form-pane" id="messageForm3" action="/admin/OAddOrUpdateStaff"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">职员工号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="jobnum" id="jobnumChange" required  lay-verify="required"  autocomplete="off" class="layui-input" >
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">职员姓名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" id="name" required  lay-verify="required" autocomplete="off" class="layui-input" >
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">职员性别</label>
                                <div class="layui-input-block">
                                    <input type="text" name="sex" id="sex" required  lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">公司ID</label>
                                <div class="layui-input-block">
                                    <input type="text" name="companyId" id="companyId" lay-verify="required" placeholder="请输入公司ID" autocomplete="off" class="layui-input" >
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">部门</label>
                                <div class="layui-input-block">
                                    <select name="department" id="department" lay-filter="aihao">
                                    </select>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">身份证号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="id_num" id="id_num" lay-verify="required" placeholder="请输入身份证号" autocomplete="off" class="layui-input" >
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">联系方式</label>
                                <div class="layui-input-block">
                                    <input type="text" name="phone" id="phone"  lay-verify="required" placeholder="请输入联系方式" autocomplete="off" class="layui-input" >
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">登陆密码</label>
                                <div class="layui-input-block">
                                    <input type="password" name="pswd" id="pswd" lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input" >
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="button" id="messageFormSubmit3" class="layui-btn" onclick="setTimeout(upMessage2,'1000');">确认修改</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageForm3Reset">重置</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" id="currentdname" name=""/>
    </div>
    <div id="meetingroomInfoPage" class="layui-body" style="background-color: rgb(242,242,242);display:block;">
        <!--场地预约情况-->
        <div style="display:none;" id="meetingroomOrderListSpan">
            <fieldset id="meetingroomOrderDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>场地预约详情</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="staffDetailAppointment">职员预约详情</li>
                    <li id="visitorDetailAppointment">游客预约详情</li>
                    <li id="changeAppointment">调度页面</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--职员预约详情--%>
                    <div class="layui-tab-item">
                        <div class="layui-form">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">选择日期</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" id="test1" placeholder="yyyy-MM-dd"/>
                                    </div>
                                    <button class="layui-btn" type="submit" lay-submit="" lay-filter="demo1" onclick="queryApplyPlaceStaff();">立即查询</button>
                                </div>
                            </div>
                            <table class="layui-hide" id="staffAppointment" lay-filter="staffAppointment"></table>
                            <script type="text/html" id="appointmentOP">
                                <a class="layui-btn layui-btn-xs" lay-event="change">调度</a>
                                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
                            </script>
                        </div>
                    </div>
                    <%--游客预约详情--%>
                    <div class="layui-tab-item">
                        <div class="layui-form">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">选择日期</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" id="test2" placeholder="yyyy-MM-dd">
                                    </div>
                                    <button class="layui-btn" type="submit" lay-submit="" lay-filter="demo1" onclick="queryApplyPlaceVisitor();">立即查询</button>
                                </div>
                            </div>
                            <table class="layui-hide" id="visitorAppointment" lay-filter="visitorAppointment"></table>
                        </div>
                    </div>
                    <%--手动调度页面--%>
                    <div class="layui-tab-item" id="changePlaceItem">
                        <fieldset id="changePlaceSpan" class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                            <legend id="target"></legend>
                        </fieldset>
                        <div class="layui-tab layui-tab-card" style="height:100% ">
                            <ul class="layui-tab-title">
                                <li id="bestPlace">最佳推荐场地</li>
                                <li id="canUsePlace">可用场地</li>
                            </ul>
                            <div class="layui-tab-content" style="height: 100px;">
                                <div class="layui-tab-item"><table class="layui-hide" id="changePlace" lay-filter="changePlace"></table></div>
                                <div class="layui-tab-item"><table class="layui-hide" id="usefulPlace" lay-filter="usefulPlace"></table></div>
                            </div>
                        </div>
                        <div class="layui-form">
                            <script type="text/html" id="selectOP">
                                <a class="layui-btn layui-btn-xs" lay-event="yes">选择</a>
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--场地具体信息-->
        <div style="display:none;" id="meetingroomDetailListSpan">
            <fieldset id="meetingroomDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>场地详情</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="detailPlace">所有场地信息</li>
                    <li id="updatePlace" style="display:none;">场地信息修改</li>
                    <li id="appointmentPlace">场地安排信息</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--场地详情--%>
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="place" lay-filter="place"></table>
                        <script type="text/html" id="placeOP">
                            <a class="layui-btn layui-btn-xs" lay-event="change">修改</a>
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
                            <a class="layui-btn layui-btn-xs" lay-event="seeOrder">查看场地安排</a>
                        </script>
                    </div>
                    <%--场地信息修改表单--%>
                    <div class="layui-tab-item" id="updateAppointmentItem">
                        <form class="layui-form layui-form-pane" id="messageForm5" action="/admin/OUpdatePlace"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">id</label>
                                <div class="layui-input-block">
                                    <input type="text" name="id" id="placeID" required  lay-verify="required"  autocomplete="off" class="layui-input" value="${sessionScope.place.getId()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地类型</label>
                                <div class="layui-input-block">
                                    <select name="type" id="place_type" lay-filter="aihao">
                                        <option value="A">A</option>
                                        <option value="B">B</option>
                                        <option value="C">C</option>
                                        <option value="D">D</option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地名称</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" id="placeName" required  lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.place.getName()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地地址</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" id="placeAddress" name="address" value="${sessionScope.place.getAddress()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地容量</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" id="capacity" name="capacity" value="${sessionScope.place.getCapacity()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地简介</label>
                                <div class="layui-input-block">
                                    <input type="text" name="introduction" id="introduction" required  lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.place.getIntroduction()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地设备</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" id="device" name="device" value="${sessionScope.place.getDevice()}"/>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">使用须知</label>
                                <div class="layui-input-block">
                                    <input type="text" name="instruction" id="instruction" required lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.place.getInstruction()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">使用费用</label>
                                <div class="layui-input-block">
                                    <input type="text" name="cost" id="placeCost" required lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.place.getCost()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit5" class="layui-btn" onclick="setTimeout(upMessage3,'1000');">确认修改</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset5">重置</button>
                            </div>
                        </form>
                    </div>
                    <%--场地安排信息--%>
                    <div class="layui-tab-item">
                            <label>选择日期(此日期后一周安排)</label>
                            <div class="layui-input-inline">
                                <input type="text" class="layui-input" id="planstart" placeholder="yyyy-MM-dd"/>
                            </div>
                            <button class="layui-btn" type="submit" lay-submit="" lay-filter="demo1" onclick="queryAppointPlan();">立即查询</button>
                            <table class="layui-hide" id="appointlist" lay-filter="appointlist"></table>
                    </div>
                </div>
                </div>
            </div>
        <!--添加场地-->
        <div style="display:none;" id="addMeetingroomListSpan">
            <fieldset id="addMeetingroom"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>添加场地</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="addmeet">请输入场地信息</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm2" action="/admin/imagesUpload"  method="POST"  target="messageFrame" enctype="multipart/form-data">
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地名称</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" required  lay-verify="required" placeholder="请输入场地名称" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地类型</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="type" value="A" title="A(短时，场地大)" checked>
                                    <input type="radio" name="type" value="B" title="B(短时，场地小)">
                                    <input type="radio" name="type" value="C" title="C(中时，场地大)">
                                    <input type="radio" name="type" value="D" title="D(中时，场地小)">
                                    <input type="radio" name="type" value="E" title="E(长时，场地大)">
                                    <input type="radio" name="type" value="F" title="F(长时，场地小)">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">地址</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" id="address" name="address" placeholder="请输入场地地址" autocomplete="off"/>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">介绍</label>
                                <div class="layui-input-block">
                                    <input type="text" name="introduction"  lay-verify="required" placeholder="请输入场地介绍" autocomplete="off" class="layui-input">
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label">设备信息</label>
                                <div class="layui-input-block">
                                    <input type="text" name="device" lay-verify="required" placeholder="请输入场地内设备信息" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">使用须知</label>
                                <div class="layui-input-block">
                                    <input type="text" name="instruction" lay-verify="required" placeholder="请输入使用须知" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">场地容量</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="capacity" lay-verify="required|number" placeholder="请输入场地容量" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">费用</label>
                                    <div class="layui-input-block">
                                        <input type="text" class="layui-input" id="cost" name="cost" placeholder="请输入场地使用费用" autocomplete="off"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">所属组织</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="companyId"  lay-verify="required|number" placeholder="请输入所属组织ID"  class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地经纬度</label>
                                <div class="layui-input-block">
                                    <input type="text" name="location" id="location"  lay-verify="required" placeholder="请在下方地图用鼠标点击以选择场地经纬度" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地图片</label>
                                <div class="layui-input-block">
                                    <button type="button" class="layui-btn layui-btn-normal" id="placeImage">选择文件</button>
                                    <button type="button" class="layui-btn" id="uploadButton" onclick="upload2();">开始上传</button>
                                    <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset2">重置</button><br>
                                    <iframe name="frame1" frameborder="0" height="40"></iframe>
                                </div>
                            </div>
                            <fieldset id="locationFieldset" class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                                <legend>选择场地经纬度</legend>
                            </fieldset>
                            <%--查询经纬度--%>
                            <div style="width: 1500px;height: 800px;position: relative;">
                                <div id="mapContainer"></div>
                                <div id="tip">
                                    <b>请输入关键字：</b>
                                    <input type="text" id="keyword" name="keyword" value="" onkeydown='keydown(event)' style="width: 95%;"/>
                                    <div id="result1" name="result1"></div>
                                </div>
                                <div id="pos">
                                    <b>鼠标左键在地图上单击获取坐标</b>
                                    <div>X：<input type="text" id="lngX" name="lngX" value=""/> Y：<input type="text" id="latY" name="latY" value=""/></div>
                                    <div>城市：<input type="text" id="city" name="city" value=""/></div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--职员评价-->
        <div style="display:none;" id="staffRemarkListSpan">
            <fieldset id="staffRemarkDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>职员评价</legend>
            </fieldset>
            <table class="layui-hide" id="staffRemark" lay-filter="staffRemark"></table>
        </div>
    </div>
    <div id="rentInfoPage" class="layui-body" style="background-color: rgb(242,242,242);display:block;">
        <!--审核游客预约申请-->
        <div style="display:none;" id="guestOrderListSpan">
            <fieldset id="guestOrderDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>审核预约申请</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="appointmentContent">审核预约</li>
                    <li id="remarkContent" style="display:none;" >查看评价</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <div class="layui-tab-item">
                        <div class="layui-form">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">选择日期</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" id="judgeTime" placeholder="yyyy-MM-dd">
                                    </div>
                                    <button class="layui-btn" type="submit" lay-submit="" lay-filter="demo1" onclick="queryApply();">立即查询</button>
                                </div>
                            </div>
                            <table class="layui-hide" id="appoint1" lay-filter="appoint1"></table>
                        </div>
                        <script type="text/html" id="judgeOP">
                            <a class="layui-btn layui-btn-xs" lay-event="agree" id="agreeButton">同意</a>
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="disagree" id="disagreeButton">拒绝</a>
                            <a class="layui-btn layui-btn-xs" lay-event="seeRemark" id="remarkButton">查看申请人评价</a>
                        </script>
                    </div>
                    <div class="layui-tab-item"><table class="layui-hide" id="appoint2" lay-filter="appoint2"></table></div>
                </div>
            </div>
        </div>
        <!--申请索赔-->
        <div style="display:none;" id="askForPayListSpan">
            <fieldset id="askForPayDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>申请索赔</legend>
            </fieldset>
        </div>
        <!--游客评价-->
        <div style="display:none;" id="guestRemarkListSpan">
            <fieldset id="guestRemarkDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>游客评价</legend>
            </fieldset>
            <script type="text/html" id="deleteOP">
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
            </script>
            <table class="layui-hide" id="visitorRemark" lay-filter="visitorRemark"></table>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © 管理员端
    </div>
</div>
<script src="/layui/layui.js"></script>

<%--获取经纬度--%>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=463db0cfba6596aade3e648d087ece4d"></script>
<script type="text/javascript">
    var windowsArr = [];
    var marker = [];
    var mapObj = new AMap.Map("mapContainer", {
        resizeEnable: true,
        view: new AMap.View2D({
            resizeEnable: true
            ,zoom:13//地图显示的缩放级别
            ,center: [120.182634, 30.241419]//中心点
        }),
        keyboardEnable:false
    });
    var clickEventListener=AMap.event.addListener(mapObj,'click',function(e){
        console.log(e);
        document.getElementById("lngX").value=e.lnglat.getLng();
        document.getElementById("latY").value=e.lnglat.getLat();
        document.getElementById("location").value=e.lnglat.getLng()+','+e.lnglat.getLat();
        AMap.service('AMap.Geocoder',function(){//回调函数
            //实例化Geocoder
            geocoder = new AMap.Geocoder({
                city: "杭州市"//城市，默认：“全国”
            });
            var lnglatXY=[e.lnglat.getLng(), e.lnglat.getLat()];//地图上所标点的坐标
            geocoder.getAddress(lnglatXY, function(status, result) {
                if (status === 'complete' && result.info === 'OK') {
                    //获得了有效的地址信息:
                    //即，result.regeocode.formattedAddress
                    //console.log(result);
                    var city = result.regeocode.addressComponent.city;
                }else{
                    var city = '获取失败';
                    //获取地址失败
                }
                document.getElementById("city").value=city;
                console.log(city);
            });
        })


    });

    document.getElementById("keyword").onkeyup = keydown;
    //输入提示
    function autoSearch() {
        var keywords = document.getElementById("keyword").value;
        var auto;
        //加载输入提示插件
        AMap.service(["AMap.Autocomplete"], function() {
            var autoOptions = {
                city: "杭州市" //城市，默认全国
            };
            auto = new AMap.Autocomplete(autoOptions);
            //查询成功时返回查询结果
            if ( keywords.length > 0) {
                auto.search(keywords, function(status, result){

                    autocomplete_CallBack(result);
                });
            }
            else {
                document.getElementById("result1").style.display = "none";
            }
        });
    }

    //输出输入提示结果的回调函数
    function autocomplete_CallBack(data) {
        var resultStr = "";
        var tipArr = data.tips;
        if (tipArr&&tipArr.length>0) {
            for (var i = 0; i < tipArr.length; i++) {
                resultStr += "<div id='divid" + (i + 1) + "' onmouseover='openMarkerTipById(" + (i + 1)
                    + ",this)' onclick='selectResult(" + i + ")' onmouseout='onmouseout_MarkerStyle(" + (i + 1)
                    + ",this)' style=\"font-size: 13px;cursor:pointer;padding:5px 5px 5px 5px;\"" + "data=" + tipArr[i].adcode + ">" + tipArr[i].name + "<span style='color:#C1C1C1;'>"+ tipArr[i].district + "</span></div>";
            }
        }
        else  {
            resultStr = " π__π 亲,人家找不到结果!<br />要不试试：<br />1.请确保所有字词拼写正确<br />2.尝试不同的关键字<br />3.尝试更宽泛的关键字";
        }
        document.getElementById("result1").curSelect = -1;
        document.getElementById("result1").tipArr = tipArr;
        document.getElementById("result1").innerHTML = resultStr;
        document.getElementById("result1").style.display = "block";
    }

    //输入提示框鼠标滑过时的样式
    function openMarkerTipById(pointid, thiss) {  //根据id打开搜索结果点tip
        thiss.style.background = '#CAE1FF';
    }

    //输入提示框鼠标移出时的样式
    function onmouseout_MarkerStyle(pointid, thiss) {  //鼠标移开后点样式恢复
        thiss.style.background = "";
    }

    //从输入提示框中选择关键字并查询
    function selectResult(index) {

        if(index<0){
            return;
        }
        if (navigator.userAgent.indexOf("MSIE") > 0) {
            document.getElementById("keyword").onpropertychange = null;
            document.getElementById("keyword").onfocus = focus_callback;
        }
        //截取输入提示的关键字部分
        var text = document.getElementById("divid" + (index + 1)).innerHTML.replace(/<[^>].*?>.*<\/[^>].*?>/g,"");
        var cityCode = document.getElementById("divid" + (index + 1)).getAttribute('data');
        document.getElementById("keyword").value = text;
        document.getElementById("result1").style.display = "none";
        //根据选择的输入提示关键字查询
        mapObj.plugin(["AMap.PlaceSearch"], function() {
            var msearch = new AMap.PlaceSearch();  //构造地点查询类
            AMap.event.addListener(msearch, "complete", placeSearch_CallBack); //查询成功时的回调函数
            msearch.setCity(cityCode);
            //console.log(cityCode);
            msearch.search(text);  //关键字查询查询
        });
    }

    //定位选择输入提示关键字
    function focus_callback() {
        if (navigator.userAgent.indexOf("MSIE") > 0) {
            document.getElementById("keyword").onpropertychange = autoSearch;
        }
    }

    //输出关键字查询结果的回调函数
    function placeSearch_CallBack(data) {
        //清空地图上的InfoWindow和Marker
        windowsArr = [];
        marker     = [];
        mapObj.clearMap();
        var resultStr1 = "";
        var poiArr = data.poiList.pois;
        var resultCount = poiArr.length;
        for (var i = 0; i < resultCount; i++) {
            resultStr1 += "<div id='divid" + (i + 1) + "' onmouseover='openMarkerTipById1(" + i + ",this)' onmouseout='onmouseout_MarkerStyle(" + (i + 1) + ",this)' style=\"font-size: 12px;cursor:pointer;padding:0px 0 4px 2px; border-bottom:1px solid #C1FFC1;\"><table><tr><td><img src=\"http://webapi.amap.com/images/" + (i + 1) + ".png\"></td>" + "<td><h3><font color=\"#00a6ac\">名称: " + poiArr[i].name + "</font></h3>";
            resultStr1 += TipContents(poiArr[i].type, poiArr[i].address, poiArr[i].tel) + "</td></tr></table></div>";
            addmarker(i, poiArr[i]);
        }
        mapObj.setFitView();
    }

    //鼠标滑过查询结果改变背景样式，根据id打开信息窗体
    function openMarkerTipById1(pointid, thiss) {
        thiss.style.background = '#CAE1FF';
        windowsArr[pointid].open(mapObj, marker[pointid]);
    }

    //添加查询结果的marker&infowindow
    function addmarker(i, d) {
        var lngX = d.location.getLng();
        var latY = d.location.getLat();
        var markerOption = {
            map:mapObj,
            icon:"http://webapi.amap.com/images/" + (i + 1) + ".png",
            position:new AMap.LngLat(lngX, latY)
        };
        var mar = new AMap.Marker(markerOption);
        marker.push(new AMap.LngLat(lngX, latY));

        var infoWindow = new AMap.InfoWindow({
            content:"<h3><font color=\"#00a6ac\">  " + (i + 1) + ". " + d.name + "</font></h3>" + TipContents(d.type, d.address, d.tel),
            size:new AMap.Size(300, 0),
            autoMove:true,
            offset:new AMap.Pixel(0,-30)
        });
        windowsArr.push(infoWindow);
        var autoData = function (e) {
            var nowPosition = mar.getPosition(),
                lng_str = nowPosition.lng,
                lat_str = nowPosition.lat;
            infoWindow.open(mapObj, nowPosition);
            document.getElementById("lngX").value = lng_str;
            document.getElementById("latY").value = lat_str;
            AMap.service('AMap.Geocoder',function(){//回调函数
                //实例化Geocoder
                geocoder = new AMap.Geocoder({
                    city: "杭州市"//城市，默认：“全国”
                });
                var lnglatXY=[lng_str, lat_str];//地图上所标点的坐标
                geocoder.getAddress(lnglatXY, function(status, result) {
                    if (status === 'complete' && result.info === 'OK') {
                        //获得了有效的地址信息:
                        //即，result.regeocode.formattedAddress
                        //console.log(result);
                        var city = result.regeocode.addressComponent.city;
                    }else{
                        var city = '获取失败';
                        //获取地址失败
                    }
                    document.getElementById("city").value=city;
                    console.log(city);
                });
            })
        };
        AMap.event.addListener(mar, "mouseover", autoData);
    }

    //infowindow显示内容
    function TipContents(type, address, tel) {  //窗体内容
        if (type == "" || type == "undefined" || type == null || type == " undefined" || typeof type == "undefined") {
            type = "暂无";
        }
        if (address == "" || address == "undefined" || address == null || address == " undefined" || typeof address == "undefined") {
            address = "暂无";
        }
        if (tel == "" || tel == "undefined" || tel == null || tel == " undefined" || typeof address == "tel") {
            tel = "暂无";
        }
        var str = "  地址：" + address + "<br />  电话：" + tel + " <br />  类型：" + type;
        return str;
    }
    function keydown(event){
        var key = (event||window.event).keyCode;
        var result = document.getElementById("result1")
        var cur = result.curSelect;
        if(key===40){//down
            if(cur + 1 < result.childNodes.length){
                if(result.childNodes[cur]){
                    result.childNodes[cur].style.background='';
                }
                result.curSelect=cur+1;
                result.childNodes[cur+1].style.background='#CAE1FF';
                document.getElementById("keyword").value = result.tipArr[cur+1].name;
            }
        }else if(key===38){//up
            if(cur-1>=0){
                if(result.childNodes[cur]){
                    result.childNodes[cur].style.background='';
                }
                result.curSelect=cur-1;
                result.childNodes[cur-1].style.background='#CAE1FF';
                document.getElementById("keyword").value = result.tipArr[cur-1].name;
            }
        }else if(key === 13){
            var res = document.getElementById("result1");
            if(res && res['curSelect'] !== -1){
                selectResult(document.getElementById("result1").curSelect);
            }
        }else{
            autoSearch();
        }
    }
</script>

<script>
    myInfoPage();
    //queryAppointmentList();
    //时间选择器设置
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        var myDate = new Date();
        var currDate = myDate.getFullYear()+myDate.getMonth()+myDate.getDate();
        //常规用法
        laydate.render({
            elem: '#test1'
            ,value: currDate
            ,isInitValue: true
        });
        laydate.render({
            elem: '#test2'
            ,value: currDate
            ,isInitValue: true
        });
        laydate.render({
            elem: '#test3'
            //,isInitValue: true
        });
        laydate.render({
            elem: '#judgeTime'
            ,value: currDate
            ,isInitValue: true
        });
    });

    function queryApply(){
        document.getElementById("reviewOrderListSp").click();
    }
    function queryApplyPlaceStaff(){
        document.getElementById("meetingroomOrderListSp").click();
    }
    function queryApplyPlaceVisitor(){
        document.getElementById("meetingroomOrderListSp").click();
        document.getElementById("visitorDetailAppointment").click();
    }

    //JavaScript代码区域
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;

        //日期
        laydate.render({
            elem: '#startdate'
        });
        laydate.render({
            elem: '#enddate'
        });
        laydate.render({
            elem: '#planstart'
        });
        laydate.render({
            elem: '#messageTime'
            ,type: 'datetime'
        });

        //自定义验证规则
        form.verify({
            title: function(value){
                if(value.length < 5){
                    return '标题至少得5个字符啊';
                }
            }
            ,repassword: function (value) {
                if (value !== document.getElementById("newPassword").value) {
                    return '两次密码应相同';
                }
            }
            , password: [/(.+){6,12}$/, '密码必须6到12位']

        });
    });
    layui.use('element', function(){
        var element = layui.element;
    });


    //上传文件
    layui.use('upload', function(){
        var $ = layui.jquery
            ,upload = layui.upload;
        //人脸信息上传
        upload.render({
            elem: '#test8'
            ,accept: 'file'
            ,auto: false
        });
        //场地信息上传
        upload.render({
            elem: '#placeImage'
            ,accept: 'file'
            ,auto: false
            ,multiple: true
        });
    });
    //初始化显示
    var layer;
    layui.use(['layer'], function(){
        layer = layui.layer //弹层
        layer.msg('欢迎您管理员!');
    });

    var xmlHttp;

    var tempId;
    var tempName;
    var tempJobnum;
    var appointmentId,start,end,last;
    var orderertype;
    var companyId;

    //添加职员
    function upMessage() {
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/admin/OAddOrUpdateStaff" ,//url
            data: $('#messageForm').serialize(),
            success: function (result) {
                layer.msg('添加成功！');
            },
            error : function() {
                document.getElementById("messageForm").reset();
                layer.msg('添加成功！');
            }
        });
    }
    //修改职员信息
    function upMessage2() {
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/admin/OAddOrUpdateStaff" ,//url
            data: $('#meetingsetting').serialize(),
            success: function (result) {
                layer.msg('修改成功！');
            },
            error : function() {
                layer.msg('修改成功！');
            }
        });
    }
    //设置会议参数
    function upMessage1() {
        //$("#meetingsetting").submit();
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/admin/setScheduleConfig" ,//url
            data: $('#meetingsetting').serialize(),
            success: function (result) {
                layer.msg('修改成功！');
            },
            error : function() {
                layer.msg('修改成功！');
            }
        });
    }

    function upMessage3() {
        layer.msg('修改成功');
    }

    function upMessage8() {
        document.getElementById("messageForm5").reset();
        layer.msg('添加成功');
    }
    //人脸信息提交
    function upload() {
        $("#formId").submit();
        $("#formId")[0] .reset();
    }

    //添加场地
    function upload2() {
       // $("#messageForm2").submit();
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/admin/imagesUpload" ,//url
            data: $('#messageForm2').serialize(),
            success: function (result) {
                layer.msg('上传成功！');
            },
            error : function() {
                layer.msg('上传成功！');
            }
        });
        $("#messageForm2")[0] .reset();
    }

    //设置页面的可见性
    function myInfoPage(){
        document.getElementById("infoPage").style.display="block";
        document.getElementById("safePage").style.display="none";
        document.getElementById("meetingPage").style.display="none";
        document.getElementById("companyPage").style.display="none";
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function mySafePage(){
        document.getElementById("safePage").style.display="block";
        document.getElementById("companyPage").style.display="none";
        document.getElementById("meetingPage").style.display="none";
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("infoPage").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function  myCompanyPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("companyPage").style.display="block";
        document.getElementById("meetingPage").style.display="none";
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function  myMeetingPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("companyPage").style.display="none";
        document.getElementById("meetingPage").style.display="block";
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function  myEmployInfoPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("meetingPage").style.display="none";
        document.getElementById("companyPage").style.display="none";
        document.getElementById("employeeInfoPage").style.display="block";
        document.getElementById("employeeInformationListSpan").style.display="block";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function myMeetingroomPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("meetingPage").style.display="none";
        document.getElementById("companyPage").style.display="none";
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("employeeInformationListSpan").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="block";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function myRentPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("meetingPage").style.display="none";
        document.getElementById("companyPage").style.display="none";
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("employeeInformationListSpan").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="block";
    }
    function meet1(){
        document.getElementById("meetingroomOrderListSpan").style.display="block";
        document.getElementById("meetingroomDetailListSpan").style.display="none";
        document.getElementById("addMeetingroomListSpan").style.display="none";
        document.getElementById("staffRemarkListSpan").style.display="none";
    }
    function meet2() {
        document.getElementById("meetingroomOrderListSpan").style.display="none";
        document.getElementById("meetingroomDetailListSpan").style.display="block";
        document.getElementById("addMeetingroomListSpan").style.display="none";
        document.getElementById("staffRemarkListSpan").style.display="none";
    }
    function meet3() {
        document.getElementById("meetingroomOrderListSpan").style.display="none";
        document.getElementById("meetingroomDetailListSpan").style.display="none";
        document.getElementById("staffRemarkListSpan").style.display="none";
        document.getElementById("addMeetingroomListSpan").style.display="block";
        document.getElementById("addmeet").click();
    }
    function meet4() {
        document.getElementById("meetingroomOrderListSpan").style.display="none";
        document.getElementById("meetingroomDetailListSpan").style.display="none";
        document.getElementById("addMeetingroomListSpan").style.display="none";
        document.getElementById("staffRemarkListSpan").style.display="block";
        document.getElementById("addmeet").click();
    }
    function rent1(){
        document.getElementById("guestOrderListSpan").style.display="block";
        document.getElementById("askForPayListSpan").style.display="none";
        document.getElementById("guestRemarkListSpan").style.display="none";
    }
    // function rent2() {
    //     document.getElementById("askForPayListSpan").style.display="block";
    //     document.getElementById("guestOrderListSpan").style.display="none";
    //     document.getElementById("guestRemarkListSpan").style.display="none";
    // }
    function rent3(){
        document.getElementById("guestRemarkListSpan").style.display="block";
        document.getElementById("askForPayListSpan").style.display="none";
        document.getElementById("guestOrderListSpan").style.display="none";
    }


    //创建XMLHttpRequest对象
    function createXMLHttpRequest(){
        if(window.ActiveXObject){
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }else if(window.XMLHttpRequest){
            xmlHttp = new XMLHttpRequest();
        }
    }
    function handleStateChange(){
        if(xmlHttp.readyState == 4) { //响应完成
            if (xmlHttp.status == 200) {  //请求成功
                if (xmlHttp.responseXML.getElementsByTagName("status")[0].firstChild.nodeValue
                    == "1") {
                    eval(xmlHttp.responseXML.getElementsByTagName("func")[0].firstChild.nodeValue);
                } else {
                    eval(xmlHttp.responseXML.getElementsByTagName("func")[0].firstChild.nodeValue);
                }
            }
        }
    }

    function setStaffSuccess() {
        var responseXML = xmlHttp.responseXML;
        var id = responseXML.getElementsByTagName("id")  [0].firstChild.nodeValue;
        var name = responseXML.getElementsByTagName("name")  [0].firstChild.nodeValue;
        var sex = responseXML.getElementsByTagName("sex")  [0].firstChild.nodeValue;
        var companyId = responseXML.getElementsByTagName("companyId")  [0].firstChild.nodeValue;
        var jobnum = responseXML.getElementsByTagName("jobnum")  [0].firstChild.nodeValue;
        var department = responseXML.getElementsByTagName("department")  [0].firstChild.nodeValue;
        var pswd = responseXML.getElementsByTagName("pswd")  [0].firstChild.nodeValue;
        var id_num = responseXML.getElementsByTagName("id_num")  [0].firstChild.nodeValue;
        var phone = responseXML.getElementsByTagName("phone")  [0].firstChild.nodeValue;
        document.getElementById('jobnumChange').setAttribute("value",jobnum);
        document.getElementById('name').setAttribute("value",name);
        document.getElementById('sex').setAttribute("value",sex);
        document.getElementById('companyId').setAttribute("value",companyId);
        document.getElementById('department').setAttribute("value",department);
        document.getElementById('pswd').setAttribute("value",pswd);
        document.getElementById('id_num').setAttribute("value",id_num);
        document.getElementById('phone').setAttribute("value",phone);
        var select = document.getElementById('department');
        for(var i=0; i<select.options.length; i++){
            if(select.options[i].innerHTML == department){
                select.options[i].selected = true;
                break;
            }
        }
        <%--获取部门下拉列表--%>
        $(document).ready(function () {
            var url="/admin/getDepartmentOptions";
            $.ajax({
                type:"get",
                url:url,//访问后台去数据库查询select的选项
                success:function(userList){
                    var data = userList.data;
                    var form = layui.form;
                    console.log(data);
                    var unitObj=document.getElementById("department");
                    unitObj.options.add(new Option(department,department));
                    if(userList!=null){ //后台传回来的select选项
                        for(var i=0;i<data.length;i++){
                            //遍历后台传回的结果，一项项往select中添加option
                            unitObj.options.add(new Option(data[i].pm.department_name,data[i].pm.department_name));
                            //alert(data[i].pm.department_name);
                        }
                    }
                    form.render();
                },
                error:function(){
                    alert('Error');
                }
            })
        })
        document.getElementById("updateStaff").click();
    }
    function setAppointmentSuccess() {
        var responseXML = xmlHttp.responseXML;
        var id   = responseXML.getElementsByTagName("id")    [0].firstChild.nodeValue;
        var orderer_id = responseXML.getElementsByTagName("orderer_id")  [0].firstChild.nodeValue;
        var ordererType = responseXML.getElementsByTagName("ordererType")  [0].firstChild.nodeValue;
        var startTime = responseXML.getElementsByTagName("startTime")  [0].firstChild.nodeValue;
        var endTime = responseXML.getElementsByTagName("endTime")  [0].firstChild.nodeValue;
        var place_id = responseXML.getElementsByTagName("place_id")  [0].firstChild.nodeValue;
        var place_name = responseXML.getElementsByTagName("place_name")  [0].firstChild.nodeValue;
        var companyId = responseXML.getElementsByTagName("companyId")  [0].firstChild.nodeValue;
        var type = responseXML.getElementsByTagName("type")  [0].firstChild.nodeValue;
        document.getElementById('appointmentId').setAttribute("value",id);
        document.getElementById('orderer_id').setAttribute("value",orderer_id);
        //document.getElementById('ordererType').setAttribute("value",ordererType);
        document.getElementById('startTime').setAttribute("value",startTime);
        document.getElementById('endTime').setAttribute("value",endTime);
        document.getElementById('place_id').setAttribute("value",place_id);
        document.getElementById('place_name').setAttribute("value",place_name);
        document.getElementById('companyId').setAttribute("value",companyId);
        document.getElementById('type').setAttribute("value",type);
        var select = document.getElementById('ordererType');
        for(var i=0; i<select.options.length; i++){
            if(select.options[i].innerHTML == ordererType){
                select.options[i].selected = true;
                break;
            }
        }

        document.getElementById("updateAppointment").click();
    }
    function setPlaceSuccess() {
        var responseXML = xmlHttp.responseXML;
        var id   = responseXML.getElementsByTagName("id")    [0].firstChild.nodeValue;
        var type = responseXML.getElementsByTagName("type")  [0].firstChild.nodeValue;
        var name = responseXML.getElementsByTagName("name")  [0].firstChild.nodeValue;
        var address = responseXML.getElementsByTagName("address")  [0].firstChild.nodeValue;
        var capacity = responseXML.getElementsByTagName("capacity")  [0].firstChild.nodeValue;
        var introduction = responseXML.getElementsByTagName("introduction")  [0].firstChild.nodeValue;
        var device = responseXML.getElementsByTagName("device")  [0].firstChild.nodeValue;
        var instruction = responseXML.getElementsByTagName("instruction")  [0].firstChild.nodeValue;
        var cost = responseXML.getElementsByTagName("cost")  [0].firstChild.nodeValue;
        document.getElementById('placeID').setAttribute("value",id);
        document.getElementById('placeName').setAttribute("value",name);
        document.getElementById('placeAddress').setAttribute("value",address);
        document.getElementById('capacity').setAttribute("value",capacity);
        document.getElementById('introduction').setAttribute("value",introduction);
        document.getElementById('device').setAttribute("value",device);
        document.getElementById('instruction').setAttribute("value",instruction);
        document.getElementById('placeCost').setAttribute("value",cost);
        var select = document.getElementById('place_type');
        for(var i=0; i<select.options.length; i++){
            if(select.options[i].innerHTML == type){
                select.options[i].selected = true;
                break;
            }
        }

        document.getElementById("updatePlace").click();
    }
    //获取会议人数
    function returnPeopleNum(){
        var responseXML = xmlHttp.responseXML;
        var num = responseXML.getElementsByTagName("num")    [0].firstChild.nodeValue;
        changePlace(tempId,start,end,last,num);
    }
    function getPeopleNum(id) {
        var url = "/admin/queryAttendeesList?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    //点击调度处理
    function changePlace(id,starttime,endtime,duration,capacity){
        document.getElementById("changeAppointment").click();
        document.getElementById("bestPlace").click();
        document.getElementById("target").innerText='当前处理预约id:'+id+' 类型:'+orderertype;
        layer.msg('符合条件的场地查询中，请稍等...');
        //查询空闲场地
        var canuseurl = "/place/staff/getRecommendList?companyId="+companyId+"&starttime="+starttime
        +"&endtime="+endtime+"&duration="+duration+"&capacity="+capacity+"&latitude=30.227659"+"&longitude=120.03334183333334";
        //最佳场地
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#changePlace'
                ,url:canuseurl
                ,cols: [[
                    {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'type', width:100, title: '场地类型'}
                    ,{field:'name', width:120, title: '场地名称'}
                    ,{field:'address', width:120, title: '场地地址'}
                    ,{field:'capacity', width:100, title: '场地容量'}
                    ,{field:'introduction', width:120, title: '场地简介'}
                    ,{field:'device', width:120, title: '场地设备'}
                    ,{field:'instruction', width:130, title: '使用须知'}
                    ,{field:'cost', width:100, title: '使用费用'}
                    ,{fixed: 'right', title:'操作', toolbar: '#selectOP', width:100}
                ]]
                ,page: true
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                    console.log(res.data[0].recommends);
                    var data = res.data[0].recommends;
                    return {
                        "code": res.status, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.count, //解析数据长度
                        "data": data //解析数据列表
                    };
                }
            });

            table.on('tool(changePlace)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                tempId = info.id;
                var tempName = info.name;
                //console.log(obj)
                if(obj.event === 'yes'){
                    layer.confirm('确认选择此场地么', function(index){
                        confirmPlace(id,tempId,tempName);
                    });
                }
            });
        });
        //可用场地
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#usefulPlace'
                ,url:canuseurl
                ,cols: [[
                    {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'type', width:100, title: '场地类型'}
                    ,{field:'name', width:120, title: '场地名称'}
                    ,{field:'address', width:120, title: '场地地址'}
                    ,{field:'capacity', width:100, title: '场地容量'}
                    ,{field:'introduction', width:120, title: '场地简介'}
                    ,{field:'device', width:120, title: '场地设备'}
                    ,{field:'instruction', width:130, title: '使用须知'}
                    ,{field:'cost', width:100, title: '使用费用'}
                    ,{fixed: 'right', title:'操作', toolbar: '#selectOP', width:100}
                ]]
                ,page: true
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                    console.log(res.data[1].recommends);
                    var data = res.data[1].recommends;
                    return {
                        "code": res.status, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.count, //解析数据长度
                        "data": data //解析数据列表
                    };
                }
            });

            table.on('tool(changePlace)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                tempId = info.id;
                var tempName = info.name;
                //console.log(obj)
                if(obj.event === 'yes'){
                    layer.confirm('确认选择此场地么', function(index){
                        confirmPlace(id,tempId,tempName);
                    });
                }
            });
            table.on('tool(usefulPlace)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                tempId = info.id;
                var tempName = info.name;
                //console.log(obj)
                if(obj.event === 'yes'){
                    layer.confirm('确认选择此场地么', function(index){
                        confirmPlace(id,tempId,tempName);
                    });
                }
            });
        });
    }
    // 初始化显示当前部门信息
    function queryDepartmentList(){
        var url = "/admin/queryDepartmentList";
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    //删除职员
    function deleteStaff(id){
        var url = "/admin/ODeleteStaff?staff_id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function deleteAppointment(id) {
        var url = "/admin/ODeleteAppointment?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function deleteVisitorAppointment(id) {
        var url = "/admin/ODeleteVisitorAppointment?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function deletePlace(id) {
        var url = "/admin/ODeletePlace?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function deleteEvaluation(id) {
        var url = "/admin/ODeleteEvaluation?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function agreeApply(id) {
        var url = "/admin/OAgreeApply?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function refreshVisitorAppointmentList(){
        document.getElementById("reviewOrderListSp").click();
    }
    function disagreeApply(id) {
        var url = "/admin/ODisagreeApply?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    //查询具体场地这一周内安排
    function queryAppointPlan(){
        var time = document.getElementById("planstart").value;
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#appointlist'
                ,url: '/admin/OFindStaffAppointmentsInWeek?time='+time+"&place_id="+tempId
                ,cols: [[
                    {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'staffId', width:120, title: '职员id'}
                    ,{field:'visitorId', width:120, title: '游客id'}
                    ,{field:'stime', width:250, title: '开始时间'}
                    ,{field:'etime', width:250, title: '结束时间'}
                    ,{field:'duration', width:80, title: '时长'}
                    ,{field:'place_id', width:120, title: '预约场地id'}
                    ,{field:'place_name', width:120, title: '预约场地名'}
                    ,{field:'companyId', width:130, title: '预约者所属公司'}
                    ,{field:'type', width:120, title: '预约场地类别'}
                ]]
                ,page: true
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                    return {
                        "code": res.status, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.count, //解析数据长度
                        "data": res.data //解析数据列表
                    };
                }
            });
        });
    }

    //查找职员
    function findTheEmployee(){
        var jobnum =document.getElementById("jobnum").value;
        var url = "/admin/theStaff?jobnum="+jobnum;
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#one'
                ,url: url
                ,cols: [[
                    {field:'id', width:100, title: 'id号', sort: true}
                    ,{field:'name', width:120, title: '姓名'}
                    ,{field:'companyId', width:80, title: '公司id'}
                    ,{field:'jobnum', width:120, title: '工号'}
                    ,{field:'department', width:120,title: '部门'}
                    ,{field:'pswd', width:120, title: '密码'}
                    ,{field:'id_num', width:120, title: '身份证号'}
                    ,{field:'phone', width:120, title: '手机号'}
                    ,{field:'face_info', width:150, title: '人脸信息'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:120}
                ]]
                ,page: true
            });
            table.on('tool(one)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                //console.log(obj)
                if(obj.event === 'delete'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    tempId = info.id;
                    tempName = info.name;
                    tempJobnum = info.jobnum;
                    layer.confirm('真的删除此职员么', function(index){
                        deleteStaff(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'change'){
                    tempJobnum = info.jobnum;
                    setStaffInSession(tempJobnum);
                    //document.getElementById("updateStaff").click();
                }
            });
        });
    }
    //更新当前部门信息
    function updateDepartmentInformationList() {

        var node = document.getElementById("seeDepartment");
        node.parentNode.removeChild(node);

        var departList = document.getElementById("departmentList");
        var div = createDiv("seeDepartment");
        var responseXML = xmlHttp.responseXML;
        for (var i = 0; i < responseXML.getElementsByTagName("showDepartList").length; i++) {
            var dname   = responseXML.getElementsByTagName("Dname")[i].firstChild.nodeValue;
            div.appendChild(createCard(dname,"employeeInformation(this);"));

            if((i+1)%3==0)
                div.appendChild(createP());

        }
        departList.appendChild(div);

        updateDepartmentListVisibility("departmentList");

    }
    //职员管理初始化
    function employeeInformation(obj) {
        var dname = obj.childNodes[0].nodeValue;
        document.getElementById("currentdname").name=dname;
        var DEPARTurl='/admin/department_employee?dname='+dname;
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#test'
                ,url: DEPARTurl
                ,cols: [[
                    {field:'id', width:100, title: 'id', sort: true}
                    ,{field:'name', width:120, title: '姓名'}
                    ,{field:'sex', width:80, title: '性别'}
                    ,{field:'companyId', width:120, title: '公司id'}
                    ,{field:'jobnum', width:120, title: '工号'}
                    ,{field:'department', width:120,title: '部门'}
                    ,{field:'pswd', width:120, title: '密码'}
                    ,{field:'id_num', width:120, title: '身份证号'}
                    ,{field:'phone', width:120, title: '手机号'}
                    ,{field:'face_info', width:150, title: '人脸信息'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:120}
                ]]
                ,page: true
            });
            table.on('tool(test)', function(obj){
                var data = obj.data;
                //console.log(obj)
                var info = JSON.parse(JSON.stringify(data));
                if(obj.event === 'delete'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    tempId = info.id;
                    tempName = info.name;
                    layer.confirm('真的删除此职员么', function(index){
                        deleteStaff(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'change'){
                    tempJobnum = info.jobnum;
                    setStaffInSession(tempJobnum);
                    //document.getElementById("updateStaff").click();
                }
            });
        });
    }
    //查询预约信息
    function queryAppointmentList(){
        var time1 = document.getElementById("test1").value;
        var time2 = document.getElementById("test2").value;
        document.getElementById("staffDetailAppointment").click();
        //var time = "1970-01-01";
        var HEADurl='/admin/OFindStaffAppointments?time='+time1;
        //职员预约管理
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#staffAppointment'
                ,url:HEADurl
                ,cols: [[
                    {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'orderer_id', width:120, title: '预约人id'}
                    ,{field:'ordererType', width:120, title: '预约人类型'}
                    ,{field:'stime', width:250, title: '开始时间'}
                    ,{field:'etime', width:250, title: '结束时间'}
                    ,{field:'duration', width:80, title: '时长'}
                    ,{field:'place_id', width:120, title: '预约场地id'}
                    ,{field:'place_name', width:120, title: '预约场地名'}
                    ,{field:'companyId', width:130, title: '预约者所属公司'}
                    ,{field:'type', width:120, title: '预约场地类别'}
                    ,{fixed: 'right', title:'操作', toolbar: '#appointmentOP', width:200}
                ]]
                ,page: true
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                    return {
                        "code": res.status, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.count, //解析数据长度
                        "data": res.data //解析数据列表
                    };
                }
            });
            table.on('tool(staffAppointment)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                tempId = info.id;
                start = info.stime;
                end = info.etime;
                last = info.duration;
                orderertype = info.ordererType;
                companyId = info.companyId;
                //console.log(obj)
                if(obj.event === 'delete'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    layer.confirm('真的删除此职员预约么', function(index){
                        deleteAppointment(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'update'){
                    setAppointmentInSession(tempId);
                }else if(obj.event === 'change'){
                    getPeopleNum(tempId);
                }
            });
        });
        //游客预约管理
        var visitorurl='/admin/OFindVisitorAppointments?time='+time2;
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#visitorAppointment'
                ,url:visitorurl
                ,cols: [[
                    {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'appointment_id', width:120, title: '预约id'}
                    ,{field:'orderer_id', width:120, title: '预约者id'}
                    ,{field:'ordererType', width:120, title: '预约人类型'}
                    ,{field:'startTime', width:200, title: '开始时间'}
                    ,{field:'endTime', width:200, title: '结束时间'}
                    ,{field:'duration', width:80, title: '时长'}
                    ,{field:'place_id', width:120, title: '预约场地id'}
                    ,{field:'place_name', width:120, title: '预约场地名'}
                    ,{field:'companyId', width:130, title: '预约者所属公司'}
                    ,{field:'type', width:120, title: '预约场地类别'}
                    ,{field:'state', width:120, title: '审核状态'}
                    ,{fixed: 'right', title:'操作', toolbar: '#appointmentOP', width:200}
                ]]
                ,page: true
            });
            table.on('tool(visitorAppointment)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                tempId = info.id;
                start = info.startTime;
                end = info.endTime;
                last = info.duration;
                appointmentId = info.appointment_id;
                orderertype = info.ordererType;
                companyId = info.companyId;
                //console.log(obj)
                if(obj.event === 'delete'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    layer.confirm('真的删除此游客预约么', function(index){
                        deleteVisitorAppointment(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'update'){
                    setAppointmentInSession(appointmentId);
                }else if(obj.event === 'change'){
                    getPeopleNum(appointmentId);
                }
            });
        });
    }
    //查询场地信息
    function queryPlaceInfo(){
        document.getElementById("detailPlace").click();
        var name = '';
        var HEADurl='/admin/OFindPlaces?name='+name;

        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#place'
                ,url:HEADurl
                ,cols: [[
                    {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'type', width:100, title: '场地类型'}
                    ,{field:'name', width:120, title: '场地名称'}
                    ,{field:'address', width:120, title: '场地地址'}
                    ,{field:'capacity', width:100, title: '场地容量'}
                    ,{field:'introduction', width:120, title: '场地简介'}
                    ,{field:'device', width:120, title: '场地设备'}
                    ,{field:'instruction', width:130, title: '使用须知'}
                    ,{field:'cost', width:100, title: '使用费用'}
                    ,{fixed: 'right', title:'操作', toolbar: '#placeOP', width:210}
                ]]
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                    return {
                        "code": res.status, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.count, //解析数据长度
                        "data": res.data //解析数据列表
                    };
                }
                ,page: true
            });

            table.on('tool(place)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                tempId = info.id;
                //console.log(obj)
                if(obj.event === 'delete'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    layer.confirm('真的删除此场地么', function(index){
                        deletePlace(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'change'){
                    setPlaceInSession(tempId);
                    //document.getElementById("updateStaff").click();
                }else if(obj.event === 'seeOrder'){
                    document.getElementById("appointmentPlace").click();
                }
            });
        });
    }
    //审核预约申请
    function auditingAppointment(){
        document.getElementById("appointmentContent").click();
        var currDate = document.getElementById("judgeTime").value;
        var HEADurl='/admin/OFindVisitorAppointments?time='+currDate+'&state='+'申请中';
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#appoint1'
                ,url:HEADurl
                ,cols: [[
                    {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'orderer_id', width:120, title: '预约人id'}
                    ,{field:'ordererType', width:120, title: '预约人类型'}
                    ,{field:'startTime', width:120, title: '开始时间'}
                    ,{field:'endTime', width:120, title: '结束时间'}
                    ,{field:'place_id', width:120, title: '预约场地id'}
                    ,{field:'place_name', width:120, title: '预约场地名'}
                    ,{field:'companyId', width:130, title: '预约者所属公司'}
                    ,{field:'type', width:120, title: '预约场地类别'}
                    ,{field:'state', width:120, title: '审核状态'}
                    ,{fixed: 'right', title:'操作', toolbar: '#judgeOP', width:250}
                ]]
                ,page: true
            });

            table.on('tool(appoint1)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                tempId = info.id;
                if(obj.event === 'agree'){
                    agreeApply(tempId);
                }else if(obj.event === 'disagree'){
                    disagreeApply(tempId);
                }
            });
        });
    }
    //游客评价
    function remarkVisitor(){
        var HEADurl='/admin/OFindEvaluations';
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#visitorRemark'
                ,url:HEADurl
                ,cols: [[
                    {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'placeId', width:100, title: '场地id'}
                    ,{field:'visitor', width:100, title: '游客ID',templet:'<div>{{d.visitor.id}}</div>'}
                    ,{field:'time', width:200, title: '评价时间'}
                    ,{field:'content', width:300, title: '评价内容'}
                ]]
                ,page: true
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                    console.log(res);
                    return {
                        "code": res.status, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.count, //解析数据长度
                        "data": res.data //解析数据列表
                    };
                }
            });
        });
    }
    //职员评价
    function remarkStaff(){
        var HEADurl='/admin/OFindStaffEvaluations';
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#staffRemark'
                ,url:HEADurl
                ,cols: [[
                    {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'placeId', width:100, title: '场地id'}
                    ,{field:'staff', width:100, title: '游客ID',templet:'<div>{{d.staff.id}}</div>'}
                    ,{field:'time', width:200, title: '评价时间'}
                    ,{field:'content', width:300, title: '评价内容'}
                ]]
                ,page: true
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                    console.log(res);
                    return {
                        "code": res.status, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.count, //解析数据长度
                        "data": res.data //解析数据列表
                    };
                }
            });
        });
    }

    //将职员信息放入seesion
    function setStaffInSession(jobnum) {
        var url = "/admin/setStaff?jobnum="+jobnum;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    //将预约信息放入seesion
    function setAppointmentInSession(id) {
        var url = "/admin/setAppointment?id="+id+"&rd="+new Date().getTime();
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    //手动调度确认选择
    function confirmPlace(appointmentId,placeId,placeName) {
        var url = "/admin/OAddOrUpdateAppointment?id="+appointmentId+"&place_id="+placeId+"&place_name="+placeName;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("POST", url, true); xmlHttp.send(null);
    }
    //调度选择成功
    function setNewPlaceSuccess() {
        layer.msg('选择成功！');
        document.getElementById("meetingroomOrderListSp").click();
        document.getElementById("").click();
    }
    //将场地信息放入seesion
    function setPlaceInSession(id) {
        var url = "/admin/setPlace?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }

    function createCellWithText(Lno,Lname,Cname,i){
        var cell = document.createElement("td");
        cell.appendChild(document.createTextNode(Lno+':'+Lname+Cname));
        var img = document.createElement("img");
        img.src='/img/img_default.png';
        cell.appendChild(img);
        cell.setAttribute("id",i);
        return cell;
    }
    function createBr(){
        var brDiv = document.createElement('br');
        brDiv.innerHTML = "<br/>";
        return brDiv;
    }
    function createP(){
        var p =document.createElement("p");
        p.innerHTML="&nbsp;<br/>";
        return p;
    }
    //创建当前已有部门的信息卡片
    function createCard(dname,method){
        var body = document.createElement("div");
        body.setAttribute("class","layui-card-body");
        body.setAttribute("id",dname);
        var head = document.createElement("div");
        head.setAttribute("class","layui-card-header");
        head.appendChild(createA(dname,method));
        var div = document.createElement("div");
        div.setAttribute("class","layui-card");div.setAttribute("id",dname);
        var secongdiv = document.createElement("div");
        secongdiv.setAttribute("class","layui-col-md4");
        secongdiv.setAttribute("id",dname);

        div.appendChild(head);
        div.appendChild(body);
        secongdiv.appendChild(div);
        return secongdiv;
    }
    function createHomeworkCard(Hname,StartDate,EndDate,Introduction,method){
        var body = document.createElement("div");
        body.setAttribute("class","layui-card-body");
        body.setAttribute("id",Hname);
        body.appendChild(document.createTextNode('开始日期：'+StartDate));
        body.appendChild(createBr());
        body.appendChild(document.createTextNode('截止日期：'+EndDate));
        body.appendChild(createBr());
        body.appendChild(document.createTextNode('作业说明：'+Introduction));
        var head = document.createElement("div");
        head.setAttribute("class","layui-card-header");
        head.appendChild(createA(Hname,method));
        var div = document.createElement("div");
        div.setAttribute("class","layui-card");
        var secongdiv = document.createElement("div");
        secongdiv.setAttribute("class","layui-col-md4");
        secongdiv.setAttribute("id",Hname);

        div.appendChild(head);
        div.appendChild(body);
        secongdiv.appendChild(div);
        return secongdiv;
    }
    function createDiv(id){
        var finaldiv = document.createElement("div");
        finaldiv.setAttribute("id",id);
        return finaldiv;
    }
    function createA(name,method) {
        var a = document.createElement("a");
        a.setAttribute("onclick",method);
        a.appendChild(document.createTextNode(name));
        return a;
    }

    //如果该ID的内容子节点不为空 那么IDSpan的内容显示
    function updateDepartmentListVisibility(listname) {
        var List = document.getElementById(listname);
        if (List.childNodes.length > 0) {
            document.getElementById(listname + "Span").style.display = "";
        } else {
            document.getElementById(listname + "Span").style.display = "none";
        }
    }

</script>
</body>
</html>