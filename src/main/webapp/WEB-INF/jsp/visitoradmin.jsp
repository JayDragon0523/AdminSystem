
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>场地管理系统</title>
    <link rel="stylesheet" href="/layui/css/layui.css">
    <link rel="stylesheet" href="/layui/css/site.css">
    <script src="/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">管理员端</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
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
                    <a class="" href="javascript:;">信息管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="myInfoPage();">个人资料</a></dd>
                        <dd><a href="javascript:;" onclick="mySafePage();">安全设置</a></dd>
                        <dd><a href="javascript:;" onclick="myFacePage();">人脸信息</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">场地管理</a>
                    <dl class="layui-nav-child" id="meetingroomList">
                        <dd><a href="javascript:;" onclick="meet1();myMeetingroomPage();queryAppointmentList();" id="meetingroomOrderListSp">场地预约情况</a></dd>
                        <dd><a href="javascript:;" onclick="meet2();myMeetingroomPage();queryPlaceInfo();" id="meetingroomDetailListSp">场地具体信息</a></dd>
                        <dd><a href="javascript:;" onclick="meet3();myMeetingroomPage();" id="addMeetingroomListSp">添加场地</a></dd>
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
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.VAdmin.getId_num()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">公司</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.VAdmin.getCompany().getName()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">联系方式</label>
                    <input type="tel" style="width: 500px" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input" value="${sessionScope.VAdmin.getPhone()}">
                </div>
            </div>

            <input type="hidden" name="password" value="${sessionScope.VAdmin.getPswd()}"/>
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
        <form class="layui-form layui-form-pane" id="formId" action="/admin/UploadFaceInfo" target="frame1" method="POST" enctype="multipart/form-data">
            <center>
            <img src="http://t.cn/RCzsdCq"/>
                <div class="layui-input-block"></div>
                <div id ="upfacediv" class="layui-form-item">
                    <button type="button" class="layui-btn layui-btn-normal" id="test8" >选择新照片</button>
                    <button type="button" class="layui-btn" id="faceUploadButton" onclick="upload();">开始上传</button><br>
                    <iframe name="frame1" frameborder="0" height="40"></iframe>
                </div>
            </center>
        </form>
    </div>
    <div id="meetingroomInfoPage" class="layui-body" style="background-color: rgb(242,242,242);display:block;">
        <!--场地预约情况-->
        <div style="display:none;" id="meetingroomOrderListSpan">
            <fieldset id="meetingroomOrderDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>场地预约详情</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="visitorDetailAppointment">顾客预约详情</li>
                    <li id="updateAppointment" style="display:none;">预约信息修改</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--顾客预约详情--%>
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
                    <%--预约信息修改表单--%>
                    <div class="layui-tab-item" id="updateAppointmentItem">
                        <form class="layui-form layui-form-pane" id="messageForm4" action="/admin/OAddOrUpdateAppointment"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">id</label>
                                <div class="layui-input-block">
                                    <input type="text" name="id" required  lay-verify="required"  autocomplete="off" class="layui-input" value="${sessionScope.appointment.getId()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">预约者id</label>
                                <div class="layui-input-block">
                                    <input type="text" name="orderer_id" required  lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.appointment.getOrderer_id()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">预约者类型</label>
                                <div class="layui-input-block">
                                    <select name="ordererType" lay-filter="aihao">
                                        <option value="${sessionScope.appointment.getOrdererType()}">${sessionScope.appointment.getOrdererType()}</option>
                                        <option value="staff">staff</option>
                                        <option value="visitor">visitor</option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">开始时间</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="startTime" placeholder="yyyy-MM-dd" value="${sessionScope.appointment.getStartTime()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">结束时间</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="endTime" placeholder="yyyy-MM-dd" value="${sessionScope.appointment.getEndTime()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">预约场地id</label>
                                <div class="layui-input-block">
                                    <input type="text" name="place_id" required  lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.appointment.getPlace_id()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">预约场地名</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="place_name" value="${sessionScope.appointment.getPlace_name()}"/>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">预约者公司id</label>
                                <div class="layui-input-block">
                                    <input type="text" name="companyId" required lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.appointment.getCompanyId()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地类型</label>
                                <div class="layui-input-block">
                                    <input type="text" name="type" required lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.appointment.getType()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit4" class="layui-btn" onclick="setTimeout(upMessage2,'1000');">确认修改</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset4">重置</button>
                            </div>
                        </form>
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
                    <li id="detailPlace">场地信息</li>
                    <li id="updatePlace" style="display:none;">场地信息修改</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--场地详情--%>
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="place" lay-filter="place"></table>
                    </div>
                    <%--场地信息修改表单--%>
                    <div class="layui-tab-item" id="updateAppointmentItem">
                        <form class="layui-form layui-form-pane" id="messageForm5" action="/admin/OUpdatePlace"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">id</label>
                                <div class="layui-input-block">
                                    <input type="text" name="id" required  lay-verify="required"  autocomplete="off" class="layui-input" value="${sessionScope.place.getId()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地名称</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" required  lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.place.getName()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地地址</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="address" value="${sessionScope.place.getAddress()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地容量</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="capacity" value="${sessionScope.place.getCapacity()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地简介</label>
                                <div class="layui-input-block">
                                    <input type="text" name="introduction" required  lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.place.getIntroduction()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地设备</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="device" value="${sessionScope.place.getDevice()}"/>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">使用须知</label>
                                <div class="layui-input-block">
                                    <input type="text" name="instruction" required lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.place.getInstruction()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">使用费用</label>
                                <div class="layui-input-block">
                                    <input type="text" name="cost" required lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.place.getCost()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit5" class="layui-btn" onclick="setTimeout(upMessage2,'1000');">确认修改</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset5">重置</button>
                            </div>
                        </form>
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
                                <label class="layui-form-label">地址</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" id="address" name="address" placeholder="请输入场地地址" autocomplete="off"/>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">介绍</label>
                                <div class="layui-input-block">
                                    <input type="text" name="introduction" required  lay-verify="required" placeholder="请输入场地介绍" autocomplete="off" class="layui-input">
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label">设备信息</label>
                                <div class="layui-input-block">
                                    <input type="text" name="device" required  lay-verify="required" placeholder="请输入场地内设备信息" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">使用须知</label>
                                <div class="layui-input-block">
                                    <input type="text" name="instruction" required  lay-verify="required" placeholder="请输入使用须知" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地容量</label>
                                <div class="layui-input-block">
                                    <input type="text" name="capacity" required  lay-verify="required|number" placeholder="请输入场地容量" autocomplete="off" class="layui-input">
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
                                        <input type="text" name="companyId" required lay-verify="required|number" placeholder="请输入所属组织ID"  class="layui-input">
                                    </div>
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
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © 管理员端
    </div>
</div>
<script src="/layui/layui.js"></script>
<script>
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


    //上传人脸信息
    layui.use('upload', function(){
        var $ = layui.jquery
            ,upload = layui.upload;
        //拖拽上传
        upload.render({
            elem: '#test8'
            ,accept: 'file'
            ,auto: false
        });
        //拖拽上传
        upload.render({
            elem: '#placeImage'
            ,accept: 'file'
            ,multiple: true
            ,auto: false
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

    function upMessage() {
        document.getElementById("messageForm").reset();
        layer.msg('添加成功');
    }
    function upMessage2() {
        document.getElementById("messageForm").reset();
        layer.msg('修改成功');
    }
    function upMessage1() {
        document.getElementById("messageForm1").reset();
        layer.msg('添加成功');
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

    function upload2() {
        $("#messageForm2").submit();
        $("#messageForm2")[0] .reset();
    }

    //设置页面的可见性
    function myInfoPage(){
        document.getElementById("infoPage").style.display="block";
        document.getElementById("facePage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="none";
    }
    function mySafePage(){
        document.getElementById("facePage").style.display="none";
        document.getElementById("safePage").style.display="block";
        document.getElementById("infoPage").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="none";
    }
    function  myFacePage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("facePage").style.display="block";
        document.getElementById("meetingroomInfoPage").style.display="none";
    }
    function myMeetingroomPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("facePage").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="block";
    }
    function meet1(){
        document.getElementById("meetingroomOrderListSpan").style.display="block";
        document.getElementById("meetingroomDetailListSpan").style.display="none";
        document.getElementById("addMeetingroomListSpan").style.display="none";
    }
    function meet2() {
        document.getElementById("meetingroomOrderListSpan").style.display="none";
        document.getElementById("meetingroomDetailListSpan").style.display="block";
        document.getElementById("addMeetingroomListSpan").style.display="none";
    }
    function meet3() {
        document.getElementById("meetingroomOrderListSpan").style.display="none";
        document.getElementById("meetingroomDetailListSpan").style.display="none";
        document.getElementById("addMeetingroomListSpan").style.display="block";
        document.getElementById("addmeet").click();
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
        document.getElementById("updateStaff").click();
    }
    function setAppointmentSuccess() {
        document.getElementById("updateAppointment").click();
    }
    function setPlaceSuccess() {
        document.getElementById("updatePlace").click();
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
    function disagreeApply(id) {
        var url = "/admin/ODisagreeApply?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
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
                    ,{field:'startTime', width:250, title: '开始时间'}
                    ,{field:'endTime', width:250, title: '结束时间'}
                    ,{field:'place_id', width:120, title: '预约场地id'}
                    ,{field:'place_name', width:120, title: '预约场地名'}
                    ,{field:'companyId', width:130, title: '预约者所属公司'}
                    ,{field:'type', width:120, title: '预约场地类别'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:120}
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
                //console.log(obj)
                if(obj.event === 'delete'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    layer.confirm('真的删除此职员预约么', function(index){
                        deleteAppointment(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'change'){
                    setAppointmentInSession(tempId);
                    //document.getElementById("updateStaff").click();
                }
            });
        });
        //游客预约管理
        var visitorurl='/admin/OFindVisitorAppointments?time='+time2+"&state="+'申请中';
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#visitorAppointment'
                ,url:visitorurl
                ,cols: [[
                    {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'orderer_id', width:120, title: '预约人id'}
                    ,{field:'ordererType', width:120, title: '预约人类型'}
                    ,{field:'startTime', width:250, title: '开始时间'}
                    ,{field:'endTime', width:250, title: '结束时间'}
                    ,{field:'place_id', width:120, title: '预约场地id'}
                    ,{field:'place_name', width:120, title: '预约场地名'}
                    ,{field:'companyId', width:130, title: '预约者所属公司'}
                    ,{field:'type', width:120, title: '预约场地类别'}
                    ,{field:'state', width:120, title: '审核状态'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:120}
                ]]
                ,page: true
            });
            table.on('tool(visitorAppointment)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                tempId = info.id;
                //console.log(obj)
                if(obj.event === 'delete'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    layer.confirm('真的删除此游客预约么', function(index){
                        deleteVisitorAppointment(tempId);
                        obj.del();
                        layer.close(index);
                    });
                }else if(obj.event === 'change'){
                    setAppointmentInSession(tempId);
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
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:120}
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
                }
            });
        });
    }
    //审核预约申请
    function auditingAppointment(){
        document.getElementById("appointmentContent").click();
        var currDate = document.getElementById("judgeTime").value;
        var HEADurl='/admin/OFindVisitorAppointments?time='+currDate+'&state='+'审核中';
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
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    agreeApply(tempId);
                }else if(obj.event === 'disagree'){
                    disagreeApply(tempId);
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
        var url = "/admin/setAppointment?id="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
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


