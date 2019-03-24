
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
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">系统管理员端</div>
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
                    ${sessionScope.SAdmin.getId_num()}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" onclick="myInfoPage();">基本资料</a></dd>
                    <dd><a href="javascript:;" onclick="mySafePage();">安全设置</a></dd>
                    <dd><a href="javascript:;" onclick="myFacePage();">人脸信息</a></dd>
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
                    <a class="" href="javascript:;">个人信息</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="myInfoPage();">基本资料</a></dd>
                        <dd><a href="javascript:;" onclick="mySafePage();">安全设置</a></dd>
                        <dd><a href="javascript:;" onclick="myFacePage();">人脸信息</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">后台管理</a>
                    <dl class="layui-nav-child" id="meetingroomList">
                        <dd><a href="javascript:;" onclick="myManagePage();manage1();queryCompany();queryApplyCompany();" id="reviewcompAdminSp">组织管理</a></dd>
                        <dd><a href="javascript:;" onclick="myManagePage();manage2();queryAdmin();" id="adminInfoSp">管理员信息管理</a></dd>
                        <dd><a href="javascript:;" onclick="myManagePage();manage3();queryVisitor();" id="visitorInfoSp">游客管理</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <div id="infoPage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">基本资料</legend>
        </fieldset>
        <form class="layui-form" action="/admin/SUpdateSelf" method="post" target="teacherInfoFrame">


            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">姓名</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.SAdmin.getId_num()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">联系方式</label>
                    <input type="tel" style="width: 500px" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input" value="${sessionScope.SAdmin.getPhone()}">
                </div>
            </div>

            <input type="hidden" name="pswd" value="${sessionScope.SAdmin.getPswd()}"/>
            <div class="layui-form-item" align="center">
                <div class="layui-inline">
                    <button class="layui-btn" type="submit" lay-submit="" lay-filter="demo1">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <div id="safePage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">安全设置</legend>
        </fieldset>
        <form class="layui-form" action="/admin/SAdminSafe" method="post">
            <div class="layui-form-item" align="center">
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">新密码</label>
                    <input type="password"  id="newPassword" style="width: 400px"  name="pswd" lay-verify="password" placeholder="请输入新密码" autocomplete="off" class="layui-input">

                    <label class="layui-form-label" align="left">请确认</label>
                    <input type="password" style="width: 400px"  name="repassword" lay-verify="repassword" placeholder="请输入新密码" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-word-aux">请填写6到12位新密码</div>
            </div>
            <div class="layui-form-item" align="center">
                <div class="layui-inline">
                    <button class="layui-btn"  type="submit" lay-submit="" lay-filter="demo1">立即提交</button>
                    <button type="reset"  class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <div id="facePage" class="layui-body" style="background-color: rgb(242,242,242);display:block;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">当前人脸信息</legend>
        </fieldset>
        <form class="layui-form layui-form-pane" id="faceFormId" action="/UploadFaceInfo" target="frame1" method="POST" enctype="multipart/form-data">
            <center>
                <img src="http://t.cn/RCzsdCq">
                <div class="layui-input-block"></div>
                <div id ="upfacediv" class="layui-form-item">
                    <button type="button" class="layui-btn layui-btn-normal" id="test8" >选择新照片</button>
                    <button type="button" class="layui-btn" id="faceUploadButton" onclick="upload();">开始上传</button><br>
                    <iframe name="frame1" frameborder="0" height="40"></iframe>
                </div>
            </center>
        </form>
    </div>
    <div id="managePage" class="layui-body" style="background-color: rgb(242,242,242);display:block;">
        <!-- 组织信息 -->
        <div style="display:block;" id="organizationListSpan">
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>组织管理</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li >组织信息</li>
                    <li id="judgeAdmin">审核组织</li>
                    <li id="addCompany">新增组织</li>
                    <li id="updateCompany" style="display: none">修改组织信息</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--组织信息--%>
                    <div class="layui-tab-item">
                        <table class="layui-table" id="organization" lay-filter="organization"></table>
                    </div>
                    <%--审核组织--%>
                    <div class="layui-tab-item">
                        <table class="layui-table" id="reviewOrganization" lay-filter="reviewOrganization"></table>
                        <script type="text/html" id="judgeOP">
                            <a class="layui-btn layui-btn-xs" lay-event="agree">同意</a>
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="disagree">拒绝</a>
                        </script>
                    </div>
                    <%--添加组织--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm3" action="/admin/SAddCompany"  method="POST"  target="messageFrame" enctype="multipart/form-data">
                            <div class="layui-form-item">
                                <label class="layui-form-label">名称</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" required  lay-verify="required" placeholder="请输入组织名称" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">地址</label>
                                <div class="layui-input-block">
                                    <input type="text" name="address" required  lay-verify="required" placeholder="请输入组织地址" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">企业注册号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="register_num" required  lay-verify="required" placeholder="请输入组织注册号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">介绍</label>
                                <div class="layui-input-block">
                                    <input type="text" name="introduction" required  lay-verify="required" placeholder="请输入组织介绍" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">代表人姓名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="head_name" required  lay-verify="required" placeholder="请输入组织代表姓名" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">联系方式</label>
                                <div class="layui-input-block">
                                    <input type="text" name="head_phone" required  lay-verify="required|phone" placeholder="请输入组织联系方式" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <button class="layui-btn" type="button" lay-submit="" lay-filter="demo1" onclick="addCompany()">立即提交</button>
                                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                                </div>
                            </div>
                        </form>
                        <script type="text/html" id="barOP">
                            <a class="layui-btn layui-btn-xs" lay-event="change" id="changeButton">修改</a>
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
                        </script>
                        <script type="text/html" id="mixOP">
                            <a class="layui-btn layui-btn-xs" lay-event="change">修改</a>
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
                            <a class="layui-btn layui-btn-xs" lay-event="agree">同意申请</a>
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="disagree">拒绝申请</a>
                        </script>
                    </div>
                    <%--修改组织信息--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm6" action="/admin/SUpdateCompany"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">名称</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" required  lay-verify="required" placeholder="请输入组织名称" autocomplete="off" class="layui-input"
                                    value="${sessionScope.company.getName()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">地址</label>
                                <div class="layui-input-block">
                                    <input type="text" name="address" required  lay-verify="required" placeholder="请输入组织地址" autocomplete="off" class="layui-input"
                                    value="${sessionScope.company.getAddress()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">企业注册号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="register_num" required  lay-verify="required" placeholder="请输入组织注册号" autocomplete="off" class="layui-input"
                                    value="${sessionScope.company.getRegister_num()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">介绍</label>
                                <div class="layui-input-block">
                                    <input type="text" name="introduction" required  lay-verify="required" placeholder="请输入组织介绍" autocomplete="off" class="layui-input"
                                    value="${sessionScope.company.getIntroduction()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">组织代表姓名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="head_name" required  lay-verify="required" placeholder="请输入组织代表姓名" autocomplete="off" class="layui-input"\
                                    value="${sessionScope.company.getHead_name()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">联系方式</label>
                                <div class="layui-input-block">
                                    <input type="text" name="phone" required  lay-verify="required" placeholder="请输入组织联系方式" autocomplete="off" class="layui-input"
                                    value="${sessionScope.company.getHead_phone()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit6" class="layui-btn" onclick="setTimeout(upMessage2,'1000');">确认修改</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset6">重置</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--管理员信息管理-->
        <div style="display:none;" id="OAdminListSpan">
            <fieldset id="homeworkLno"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>管理员信息管理</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li class="layui-this">系统管理员信息</li>
                    <li class="layui-this">组织管理员信息</li>
                    <li>新增管理员</li>
                    <li id="updateOAdmin" style="display:none">修改组织管理员信息</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--系统管理员信息--%>
                    <div class="layui-tab-item">
                        <table class="layui-table" id="SAdminInfo" lay-filter="SAdminInfo"></table>
                    </div>
                    <%--组织管理员信息--%>
                    <div class="layui-tab-item">
                        <table class="layui-table" id="OAdminInfo" lay-filter="OAdminInfo"></table>
                    </div>
                    <%--新增管理员--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm" action="/admin/SAddOAdmin"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">管理员类别</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="identity" value="系统管理员" title="系统管理员">
                                    <input type="radio" name="identity" value="组织管理员" title="组织管理员" checked>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">身份证号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="id_num" required  lay-verify="required" placeholder="请输入身份证号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">账号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="account" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">密码</label>
                                    <div class="layui-input-block">
                                        <input type="password" class="layui-input" name="pswd" placeholder="请输入密码"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">联系方式</label>
                                <div class="layui-input-block">
                                    <input type="text" name="phone" required  lay-verify="required" placeholder="请输入联系方式" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">所属公司id</label>
                                <div class="layui-input-block">
                                    <input type="text" name="companyId" required lay-verify="required" placeholder="请输入所属公司id" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="button" id="messageFormSubmit" class="layui-btn" onclick="addAdmin();">确认添加</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset">重置</button>
                            </div>
                        </form>
                    </div>
                    <%--修改组织管理员--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm7" action="/admin/SUpdateOAdmin"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">管理员身份</label>
                                <div class="layui-input-block">
                                    <input type="text" name="identity" required  lay-verify="required" autocomplete="off" class="layui-input" disabled="true"
                                    value="${sessionScope.admin.getIdentity()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">管理员身份证号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="id_num" required  lay-verify="required" placeholder="请输入身份证号" autocomplete="off" class="layui-input"
                                    value="${sessionScope.admin.getId_num()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">账号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="account" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input"
                                    value="${sessionScope.admin.getAccount()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">密码</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" name="pswd" placeholder="请输入密码"
                                        value="${sessionScope.admin.getPswd()}"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">联系方式</label>
                                <div class="layui-input-block">
                                    <input type="text" name="phone" required  lay-verify="required" placeholder="请输入联系方式" autocomplete="off" class="layui-input"
                                    value="${sessionScope.admin.getPhone()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">所属公司id</label>
                                <div class="layui-input-block">
                                    <input type="text" name="companyId" required lay-verify="required" placeholder="请输入所属公司id" autocomplete="off" class="layui-input"
                                    value="${sessionScope.admin.getCompanyId()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="button" id="messageFormSubmit7" class="layui-btn" onclick="updateOAdminInfo();">确认修改</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset7">重置</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--游客管理-->
        <div style="display:none;" id="visitorListSpan">
            <fieldset id="visitorManagement"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>游客信息管理</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="visitorInfoLi">游客信息</li>
                    <li id="addVisitorLi">新增游客</li>
                    <li id="updateVisitorLi" style="display: none">修改游客信息</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--游客信息--%>
                    <div class="layui-tab-item">
                        <table class="layui-table" id="visitor" lay-filter="visitor"></table>
                    </div>
                    <%--新增游客--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm4" action="/admin/SAddVisitor"  method="POST">
                            <div class="layui-form-item">
                                <label class="layui-form-label">姓名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" required  lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">性别</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="sex" value="男" title="男" checked>
                                    <input type="radio" name="sex" value="女" title="女">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">账号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="account" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">密码</label>
                                <div class="layui-input-block">
                                    <input type="text" name="pswd" required  lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
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
                                <label class="layui-form-label">信用卡账号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="credit_card" required  lay-verify="required" placeholder="请输入信用卡账号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="button" id="messageFormSubmit4" class="layui-btn" onclick="addVisitor()">确认添加</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset4">重置</button>
                            </div>
                        </form>
                    </div>
                    <%--修改游客信息--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm5" action="/admin/SUpdateVisitor"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">姓名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" required  lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input"
                                    value="${sessionScope.visitor.getName()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">性别</label>
                                <div class="layui-input-block">
                                    <input type="text" name="sex" required  lay-verify="required" placeholder="请输入性别" autocomplete="off" class="layui-input"
                                           value="${sessionScope.visitor.getSex()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">账号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="account" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input"
                                           value="${sessionScope.visitor.getAccount()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">密码</label>
                                <div class="layui-input-block">
                                    <input type="text" name="pswd" required  lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input"
                                           value="${sessionScope.visitor.getPswd()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">身份证号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="id_num" required  lay-verify="required" placeholder="请输入身份证号" autocomplete="off" class="layui-input"
                                           value="${sessionScope.visitor.getId_num()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">联系方式</label>
                                <div class="layui-input-block">
                                    <input type="text" name="phone" required  lay-verify="required" placeholder="请输入组织联系方式" autocomplete="off" class="layui-input"
                                           value="${sessionScope.visitor.getPhone()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">信用卡账号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="credit_card" required  lay-verify="required" placeholder="请输入信用卡账号" autocomplete="off" class="layui-input"
                                           value="${sessionScope.visitor.getCredit_card()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="button" id="messageFormSubmit5" class="layui-btn" onclick="updateVisitorInfo();">确认修改</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset5">重置</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%--//信息窗口--%>
        <iframe  id="messageFrame1" name="messageFrame1" style="display: none;width:0; height:0" name="submitFrame"  src="about:blank"></iframe>
        <iframe  id="messageFrame" name="messageFrame" style="display: none;width:0; height:0" name="submitFrame"  src="about:blank"></iframe>
        <iframe  id="teacherInfoFrame" name="teacherInfoFrame" style="display: none;width:0; height:0" name="submitFrame"  src="about:blank"></iframe>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © 管理员端
    </div>
</div>
<script src="/layui/layui.js"></script>
<script>

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
        //拖拽上传
        upload.render({
            elem: '#test8'
            ,accept: 'file'
            ,auto: false
        });
        upload.render({
            elem: '#placeImage'
            ,accept: 'file'
            ,auto: false
        });
    });
    //日期时间选择器：课程通知
    var layer;
    layui.use(['layer'], function(){
        layer = layui.layer //弹层
        layer.msg('欢迎您，系统管理员!');
    });


    var xmlHttp;
    var tempId;

    function upMessage() {
        document.getElementById("messageForm").reset();
        layer.msg('添加成功');
    }
    //修改组织管理员信息
    function updateOAdminInfo() {
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/admin/SUpdateOAdmin" ,//url
            data: $('#messageForm7').serialize(),
            success: function (data) {
                alert("修改成功！");
                document.getElementById("messageForm7").reset();
            },
            error : function() {
                alert("修改成功！");
                document.getElementById("messageForm7").reset();
            }
        });
    }
    //新增组织管理员
    function addAdmin() {
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/admin/SAddOAdmin" ,//url
            data: $('#messageForm').serialize(),
            success: function (data) {
                alert("添加成功！");
                document.getElementById("messageForm").reset();
            },
            error : function() {
                alert("添加成功！");
                document.getElementById("messageForm").reset();
            }
        });
    }
    //新增组织
    function addCompany() {
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/admin/SAddCompany" ,//url
            data: $('#messageForm3').serialize(),
            success: function (data) {
                alert("添加成功！");
                document.getElementById("messageForm3").reset();
            },
            error : function() {
                alert("添加成功！");
                document.getElementById("messageForm3").reset();
            }
        });
    }
    //新增游客
    function addVisitor() {
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/admin/SAddVisitor" ,//url
            data: $('#messageForm4').serialize(),
            success: function (data) {
                alert("添加成功！");
                document.getElementById("messageForm4").reset();
            },
            error : function() {
                alert("添加成功！");
                document.getElementById("messageForm4").reset();
            }
        });
    }
    //修改游客信息
    function updateVisitorInfo() {
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/admin/SUpdateVisitor" ,//url
            data: $('#messageForm5').serialize(),
            success: function (data) {
                alert("修改成功！");
                document.getElementById("messageForm5").reset();
            },
            error : function() {
                alert("修改成功！");
                document.getElementById("messageForm5").reset();
            }
        });
    }
    function upMessage1() {
        document.getElementById("messageForm1").reset();
        layer.msg('添加成功');
    }

    function upMessage8() {
        document.getElementById("messageForm5").reset();
        layer.msg('添加成功');
    }
    function upMessage2() {
        layer.msg('修改成功');
    }
    function upload() {
        $("#formId").submit();
        $("#formId")[0] .reset();
    }
    function upload2() {
        $("#messageForm3").submit();
        $("#messageForm3")[0] .reset();
    }
    function hideOthers(obj) {
        var id = obj.id+'an';
        var tab = document.getElementById("functionList");
        for(var i =3;i<tab.childNodes.length;i=i+2){
            if(tab.childNodes[i].childNodes[0].id+'an'==id)
                document.getElementById(tab.childNodes[i].childNodes[0].id+'an').style.display="";
            else
                document.getElementById(tab.childNodes[i].childNodes[0].id+'an').style.display="none";
        }

    }

    //设置页面的可见性
    function myInfoPage(){
        document.getElementById("infoPage").style.display="block";
        document.getElementById("facePage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("managePage").style.display="none";
    }
    function mySafePage(){
        document.getElementById("facePage").style.display="none";
        document.getElementById("safePage").style.display="block";
        document.getElementById("infoPage").style.display="none";
        document.getElementById("managePage").style.display="none";
    }
    function  myFacePage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("facePage").style.display="block";
        document.getElementById("managePage").style.display="none";

    }
    function myManagePage() {
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("facePage").style.display="none";
        document.getElementById("managePage").style.display="block";
    }
    function manage1() {
        document.getElementById("organizationListSpan").style.display="block";
        document.getElementById("OAdminListSpan").style.display="none";
        document.getElementById("visitorListSpan").style.display="none";
    }
    function manage2() {
        document.getElementById("organizationListSpan").style.display="none";
        document.getElementById("OAdminListSpan").style.display="block";
        document.getElementById("visitorListSpan").style.display="none";
    }
    function manage3() {
        document.getElementById("organizationListSpan").style.display="none";
        document.getElementById("OAdminListSpan").style.display="none";
        document.getElementById("visitorListSpan").style.display="block";
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

    function agreeOAdmin(id) {
        var url = "/admin/SReviewOAdmin?id="+ id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true);
        xmlHttp.send(null);
    }
    function disagreeOAdmin(id) {
        var url = "/admin/SDisagreeOAdmin?id="+ id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true);
        xmlHttp.send(null);
    }
    function agreeApplyCompany(id) {
        var url = "/admin/SReviewCompany?id="+ id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true);
        xmlHttp.send(null);
    }
    function disagreeApplyCompany(id) {
        var url = "/admin/SDisagreeApply?id="+ id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true);
        xmlHttp.send(null);
    }
    function opSuccess(){
        document.getElementById("reviewcompAdminSp").click();
        document.getElementById("judgeAdmin").click();
    }
    function setCompanySuccess() {
        document.getElementById("updateCompany").click();
    }
    function setOAdminSuccess() {
        document.getElementById("updateOAdmin").click();
    }
    function setVisitorSuccess() {
        document.getElementById("updateVisitorLi").click();
    }
    function setCompanyInSession(id){
        var url = "/admin/setCompany?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function setOAdminInSession(id) {
        var url = "/admin/setOAdmin?id="+ id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true);
        xmlHttp.send(null);
    }
    function setVisitorInSession(id) {
        var url = "/admin/setVisitor?id="+ id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true);
        xmlHttp.send(null);
    }
    function deleteCompany(id) {
        var url = "/admin/SDeleteCompany?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function deleteOAdmin(id) {
        var url = "/admin/SDeleteOAdmin?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function deleteVisitor(id) {
        var url = "/admin/SDeleteVisitor?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function queryCompany(){
        var DEPARTurl='/admin/SFindCompanies';
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#organization'
                ,url: DEPARTurl
                ,cols: [[
                    {field:'id', width:100, title: 'id', sort: true}
                    ,{field:'name', width:200, title: '公司名'}
                    ,{field:'address', width:200, title: '地址'}
                    ,{field:'register_num', width:120, title: '公司注册号'}
                    ,{field:'introduction', width:200, title: '简介'}
                    ,{field:'head_name', width:100,title: '代表人姓名'}
                    ,{field:'head_phone', width:120, title: '联系方式'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:120}
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
                ,page:true
            });
            table.on('tool(organization)', function(obj){
                var data = obj.data;
                //console.log(obj)
                var info = JSON.parse(JSON.stringify(data));
                if(obj.event === 'delete'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    tempId = info.id;
                    layer.confirm('真的删除此组织么', function(index){
                        deleteCompany(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'change'){
                    tempId = info.id;
                    setCompanyInSession(tempId);
                    //document.getElementById("updateStaff").click();
                }
            });
        });
    }
    function queryApplyCompany(){
        var DEPARTurl='/admin/SFindApplyCompanies';
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#reviewOrganization'
                ,url: DEPARTurl
                ,cols: [[
                    {field:'id', width:100, title: 'id', sort: true}
                    ,{field:'name', width:200, title: '公司名'}
                    ,{field:'address', width:200, title: '地址'}
                    ,{field:'register_num', width:120, title: '公司注册号'}
                    ,{field:'introduction', width:120, title: '简介'}
                    ,{field:'head_name', width:100,title: '代表人姓名'}
                    ,{field:'head_phone', width:120, title: '联系方式'}
                    ,{fixed: 'right', title:'操作', toolbar: '#judgeOP', width:120}
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
                ,page:true
            });
            table.on('tool(reviewOrganization)', function(obj){
                var data = obj.data;
                //console.log(obj)
                var info = JSON.parse(JSON.stringify(data));
                if(obj.event === 'agree'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    tempId = info.id;
                    layer.confirm('确认同意申请?', function(index){
                        agreeApplyCompany(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'disagree'){
                    tempId = info.id;
                    layer.confirm('确认拒绝申请?', function(index){
                        disagreeApplyCompany(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }
            });
        });
    }
    function queryAdmin(){
        //查系统管理员
        var SAdminurl='/admin/SFindSAdmins';
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#SAdminInfo'
                ,url: SAdminurl
                ,cols: [[
                    {field:'id', width:100, title: 'id', sort: true}
                    ,{field:'identity', width:120, title: '身份'}
                    ,{field:'id_num', width:200, title: '身份证号'}
                    ,{field:'account', width:120, title: '账号'}
                    ,{field:'pswd', width:120, title: '密码'}
                    ,{field:'phone', width:150,title: '联系方式'}
                    ,{field:'face_info', width:200, title: '人脸信息'}
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
                ,page:true
            });
        });
        //查组织管理员
        var OAdminurl='/admin/SFindOAdmins';
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#OAdminInfo'
                ,url: OAdminurl
                ,cols: [[
                    {field:'id', width:100, title: 'id', sort: true}
                    ,{field:'identity', width:100, title: '身份'}
                    ,{field:'id_num', width:200, title: '身份证号'}
                    ,{field:'account', width:120, title: '账号'}
                    ,{field:'pswd', width:120, title: '密码'}
                    ,{field:'phone', width:120,title: '联系方式'}
                    ,{field:'face_info', width:120, title: '人脸信息'}
                    ,{field:'state', width:120, title: '审核状态'}
                    ,{fixed: 'right', title:'操作', toolbar: '#mixOP', width:260}
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
                ,page:true
            });
            table.on('tool(OAdminInfo)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                if(obj.event === 'delete'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    tempId = info.id;
                    layer.confirm('真的删除此组织管理员么', function(index){
                        deleteOAdmin(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'change'){
                    tempId = info.id;
                    setOAdminInSession(tempId);
                }else if(obj.event === 'agree'){
                    tempId = info.id;
                    layer.confirm('同意此申请么', function(index){
                        agreeOAdmin(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }
                else if(obj.event === 'disagree'){
                    tempId = info.id;
                    disagreeOAdmin(tempId);
                }
            });
        });
    }
    function queryVisitor(){
        //查游客
        var OAdminurl='/admin/SFindVisitors';
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#visitor'
                ,url: OAdminurl
                ,cols: [[
                    {field:'id', width:100, title: 'id', sort: true}
                    ,{field:'name', width:120, title: '名字'}
                    ,{field:'sex', width:120, title: '性别'}
                    ,{field:'id_num', width:200, title: '身份证号'}
                    ,{field:'account', width:120, title: '账号'}
                    ,{field:'pswd', width:120, title: '密码'}
                    ,{field:'phone', width:120,title: '联系方式'}
                    ,{field:'credit_card', width:120,title: '信用卡卡号'}
                    ,{field:'identified', width:130,title: '是否人脸验证'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:120}
                ]]
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
                ,page:true
            });
            table.on('tool(visitor)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                if(obj.event === 'delete'){
                    tempId = info.id;
                    layer.confirm('真的删除此游客么', function(index){
                        deleteVisitor(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'change'){
                    tempId = info.id;
                    setVisitorInSession(tempId);
                }
            });
        });
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
    //创建当前已经开课的信息卡片
    function createCard(Gno,Lno,Tno,Cno,method){
        var body = document.createElement("div");
        body.setAttribute("class","layui-card-body");
        body.setAttribute("id",Gno);
        body.appendChild(document.createTextNode('课程编号：'+Lno));
        body.appendChild(createBr());
        body.appendChild(document.createTextNode('班级编号：'+Cno));
        body.appendChild(createBr());
        body.appendChild(document.createTextNode('教师编号：'+Tno));
        var head = document.createElement("div");
        head.setAttribute("class","layui-card-header");
        head.appendChild(createA(Lno,method));
        var div = document.createElement("div");
        div.setAttribute("class","layui-card");div.setAttribute("id",Gno);
        var secongdiv = document.createElement("div");
        secongdiv.setAttribute("class","layui-col-md4");
        secongdiv.setAttribute("id",Gno);

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
    function updateLessonListVisibility(listname) {
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


