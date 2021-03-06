
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>会议室预约系统</title>
    <link rel="stylesheet" href="/layui/css/layui.css">
    <link rel="stylesheet" href="/layui/css/site.css">
    <script src="/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="/layui/jquery.js"></script>
    <script type="text/javascript" src="/layui/jquery.qrcode.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">职员端</div>
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
                    ${sessionScope.staff.getName()}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" onclick="myInfoPage();">个人资料</a></dd>
                    <dd><a href="javascript:;" onclick="mySafePage();">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="http://localhost:8080/staff/login">注销</a></li>
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
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">预约管理</a>
                    <dl class="layui-nav-child" id="meetingroomList">
                        <dd><a href="javascript:;" onclick="meet1();myAppointmentInfoPage();startOrder();" id="meetingroomOrderListSp">预约场地</a></dd>
                        <dd><a href="javascript:;" onclick="meet2();myAppointmentInfoPage();queryMyAppointmentInfo();" id="meetingroomDetailListSp">查看我的预约</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">会议管理</a>
                    <dl class="layui-nav-child" id="meetingList">
                        <dd><a href="javascript:;" onclick="m1();myMeetingInfoPage();queryLatestMeeting();" id="latestOrderListSp">近期会议</a></dd>
                        <dd><a href="javascript:;" onclick="m2();myMeetingInfoPage();queryOldMeeting();" id="oldOrderListSp">历史会议</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <div id="infoPage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">基本资料</legend>
        </fieldset>
        <form class="layui-form" action="/admin/OAddOrUpdateStaff" method="post" target="teacherInfoFrame">
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">id</label>
                    <input type="text" style="width: 500px" name="id" lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.staff.getId()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">姓名</label>
                    <input type="text" style="width: 500px"  name="name" lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.staff.getName()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">身份证号</label>
                    <input type="text" style="width: 500px"  name="id_num" lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.staff.getId_num()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">部门</label>
                    <input type="text" style="width: 500px"  name="department" lay-verify="required" autocomplete="off" class="layui-input" value="${sessionScope.staff.getDepartment()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">联系方式</label>
                    <input type="tel" style="width: 500px" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input" value="${sessionScope.staff.getPhone()}">
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
    <div id="safePage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">安全设置</legend>
        </fieldset>
        <form class="layui-form" action="/admin/staff/alterPass" method="post">
            <div class="layui-form-item" align="center">
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">职员ID</label>
                    <input type="text" style="width: 400px"  name="id" lay-verify="password" disabled="true" autocomplete="off" class="layui-input" value="${sessionScope.staff.getId()}">
                    <label class="layui-form-label" align="left">旧密码</label>
                    <input type="password"   style="width: 400px"  name="pswd" lay-verify="password" placeholder="请输入原密码" autocomplete="off" class="layui-input">
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
    <div id="appointmentInfoPage" class="layui-body" style="background-color: rgb(242,242,242);display:block;">
        <!--场地预约-->
        <div style="display:none;" id="makeOrderSpan">
            <fieldset id="meetingroomOrderDetail" class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>场地预约</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="detailAppointment">开始预约</li>
                    <li id="addAppointmentPeople">添加与会人员</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--预约详情--%>
                    <div class="layui-tab-item" id="queryPlaceItem">
                        <form class="layui-form layui-form-pane" id="messageForm2" action="/conference/staff/appointment"  method="POST"  target="messageFrame">
                            <input type="hidden" name="orderer_id" value="${sessionScope.staff.getId()}"/>
                            <input type="hidden" name="ordererType" value="staff"/>
                            <input type="hidden" name="place_id" id="placeId"/>
                            <input type="hidden" name="place_name" id="placeName"/>
                            <input type="hidden" name="type" id="placeType"/>
                            <div class="layui-form-item">
                                <label class="layui-form-label">公司ID</label>
                                <div class="layui-input-block">
                                    <input type="text" name="companyId" id="companyId" class="layui-input" lay-verify="required" value="${sessionScope.staff.getCompanyId()}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">开始时间</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="stime" id="start" lay-verify="required" placeholder="yyyy-MM-dd HH:mm:ss">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">结束时间</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="etime" id="end" lay-verify="required" placeholder="yyyy-MM-dd HH:mm:ss">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">会议时长</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" lay-verify="required" name="duration" id="duration" placeholder="请填写会议时长(分钟)">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">会议人数</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" lay-verify="required" name="capacity" id="capacity" placeholder="请填写会议人数">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">会议简介</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="introduction" id="introduction" placeholder="请填写会议简介">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">坐标</label>
                                <div class="layui-input-inline">
                                    <input type="text" class="layui-input" name="location" id="location" placeholder="当前位置经纬度，可缺省">
                                </div>
                                <button type="button" class="layui-btn" onclick="getLocation()">获取我的定位</button>
                            </div>
                            <input type="hidden" name="longitude" id="longitude">
                            <input type="hidden" name="latitude" id="latitude">
                            <div class="layui-form-item">
                                <button type="button" id="messageFormSubmit2" class="layui-btn" onclick="queryAvailablePlace();">查询可用场地</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset2">重置</button>
                            </div>
                        </form>
                        <div class="layui-tab layui-tab-card" style="height:100% ">
                            <ul class="layui-tab-title">
                                <li id="bestPlace">最佳推荐场地</li>
                                <li id="canUsePlace">可用场地</li>
                            </ul>
                            <div class="layui-tab-content" style="height: 100px;">
                                <div class="layui-tab-item" id="queryBestPlaceItem">
                                    <table class="layui-table" id="place" lay-filter="place"></table>
                                </div>
                                <div class="layui-tab-item" id="queryNextPlaceItem">
                                    <table class="layui-table" id="nextplace" lay-filter="nextplace"></table>
                                </div>
                                <button type="submit" id="messageFormSubmit3" class="layui-btn" style="display: none" onclick="nextOrder();">确认</button>
                            </div>
                        </div>
                        <script type="text/html" id="selectOP">
                            <a class="layui-btn layui-btn-xs" lay-event="yes">选择</a>
                        </script>
                        <script type="text/html" id="checkboxTpl">
                            <input type="checkbox" name="select" value="{{d.id}}" title="选中" lay-filter="lockDemo">
                        </script>
                    </div>
                    <%--添加与会人员--%>
                    <div class="layui-tab-item" id="updateAppointmentItem">
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="groupName" required="required" id="groupName" placeholder="请输入群组名">
                        </div>
                        <button class="layui-btn layui-btn-normal" onclick="confirmMember()">确认与会人员</button>
                        <%--群组--%>
                        <div class="layui-tab" lay-filter="demo">
                            <ul class="layui-tab-title">
                                <li class="layui-this" lay-id="11">我创建的群</li>
                                <li lay-id="22">我所在的群</li>
                                <li id="33">群成员</li>
                                <li lay-id="44">历史与会人员</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show"><table class="layui-hide" id="group3" lay-filter="group3"></table></div>
                                <div class="layui-tab-item"><table class="layui-hide" id="group6" lay-filter="group6"></table></div>
                                <div class="layui-tab-item"><table class="layui-hide" id="groupMembers" lay-filter="groupMembers"></table></div>
                                <div class="layui-tab-item">
                                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                                        <legend>历史与会人员</legend>
                                    </fieldset>
                                    <table class="layui-hide" id="attendpeople" lay-filter="attendpeople"></table>
                                </div>
                            </div>
                        </div>
                        <button type="submit" id="messageFormSubmit4" class="layui-btn" style="display: none" onclick="submitOrder();">提交预约</button>
                        <fieldset id="meetingcode" class="layui-elem-field layui-field-title" style="margin-top: 20px;display: none;">
                            <legend align="center">请保存会议二维码</legend>
                        </fieldset>
                        <div id="qrcode" align="center"></div><br>
                        <div align="center"><button class="layui-btn" type="submit" id="button" style="display:none;" >下载图片</button></div>
                    </div>
                    <script type="text/html" id="toolbarDemo">
                        <div class="layui-btn-container">
                            <button class="layui-btn layui-btn-sm" lay-event="getCheckData">确认添加选中的人员</button>
                            <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
                            <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
                        </div>
                    </script>
                        <script type="text/html" id="toolbarDemo2">
                            <div class="layui-btn-container">
                                <button class="layui-btn layui-btn-sm" lay-event="getCheckData">选定人员</button>
                            </div>
                        </script>
                </div>
            </div>
        </div>
        <!--查看我的预约-->
        <div style="display:none;" id="seeMyOrderSpan">
            <fieldset id="meetingroomDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>我的预约</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="myDetailAppointment">预约信息</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--预约信息--%>
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="myAppointment" lay-filter="myAppointment"></table>
                        <script type="text/html" id="appointmentOP">
                            <a class="layui-btn layui-btn-xs" lay-event="cancle">取消</a>
                        </script>
                        <script type="text/html" id="seeOP">
                            <a class="layui-btn layui-btn-xs" lay-event="see">查看群成员</a>
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="submit">选择此群并提交预约</a>
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="meetingInfoPage" class="layui-body" style="background-color: rgb(242,242,242);display:block;">
        <!--近期会议-->
        <div style="display:none;" id="latestAppointmentSpan">
            <fieldset id="latestDetail" class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>您近期需要参加的会议</legend>
            </fieldset>
            <table class="layui-hide" id="latestAppointment" lay-filter="latestAppointment"></table>
        </div>
        <!--历史会议-->
        <div style="display:none;" id="oldAppointmentSpan">
            <fieldset id="oldDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>历史会议</legend>
            </fieldset>
            <table class="layui-hide" id="oldAppointment" lay-filter="oldAppointment"></table>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © 管理员端
    </div>
</div>
<script src="/layui/layui.js"></script>
<%--获取自身定位--%>
<script>
    var x=document.getElementById("location");
    function getLocation()
    {
        if (navigator.geolocation)
        {
            navigator.geolocation.getCurrentPosition(showPosition);
        }
        else{x.innerHTML="Geolocation is not supported by this browser.";}
    }
    function showPosition(position)
    {
        x.value = position.coords.longitude + ',' + position.coords.latitude;
        // x.innerHTML="Latitude: " + position.coords.latitude +
        //     "<br />Longitude: " + position.coords.longitude;
        document.getElementById("latitude").value = position.coords.latitude;
        document.getElementById("longitude").value = position.coords.longitude;
    }
</script>

<script>
    layui.use('layer', function(){ //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句

        //触发事件
        var active = {
            confirmTrans: function(){
                //配置一个透明的询问框
                layer.msg('您需要将选择的人员建立为一个固定群组吗?', {
                    time: 200000, //200s后自动关闭
                    btn: ['是', '否']
                });
            }
        };

        $('#layerDemo .layui-btn').on('click', function(){
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });

    });
</script>

<script>
    myInfoPage();
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
        laydate.render({
            elem: '#start'
            ,type: 'datetime'
        });
        laydate.render({
            elem: '#end'
            ,type: 'datetime'
        });
    });

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

    var xmlHttp;

    var tempId;
    var tempName;
    var tempJobnum;
    var place_id,place_name,place_type;
    var code;
    var str = [];
    var isGroup = false;
    var length;
    var jsondata;

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
    //预约信息提交
    function nextOrder() {
        var layer;
        var submiturl = "/conference/staff/appointment?companyId=";
        if(document.getElementById("placeId").value==''){
            layui.use(['layer'], function(){
                layer = layui.layer //弹层
                layer.msg('请选择场地！');
            });
        }
        else{
            document.getElementById("messageFormSubmit4").style.display = "block";
            document.getElementById("addAppointmentPeople").click();
            getHistory();
        }
    }

    //预约信息提交
    function submitOrder() {
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/conference/staff/appointment" ,//url
            data: $('#messageForm2').serialize(),
            success: function (data) {
                code = data.data;
                alert(data.msg);
                document.getElementById("meetingcode").style.display = "block";
                document.getElementById("button").style.display = "block";
                $(function(){
                    $('#qrcode').qrcode({
                        width: 128,
                        height: 128,
                        text: "{code:"+code+",type:200}"
                    });
                })
                $("#button").click(function () {
                    var canvasImg = document.getElementsByTagName('canvas')[0];
                    var img =convertCanvasToImage(canvasImg);
                    $('#qrcode').empty();
                    $('#qrcode').append(img);
                    downLoadCode();
                    alert("下载完成");
                })
            },
            error : function() {
                alert("异常！");
            }
        });
        //$("#messageForm2").submit();
    }

    function convertCanvasToImage(canvas) {
        //新Image对象，可以理解为DOM
        var image = new Image();
        // canvas.toDataURL 返回的是一串Base64编码的URL，当然,浏览器自己肯定支持
        // 指定格式PNG
        image.src = canvas.toDataURL("image/png");
        return image;
    };

    // 下载二维码
    function downLoadCode(){
        var img = $('#qrcode').children('img').attr("src");
        var alink = document.createElement("a");
        alink.href = img;
        alink.download = "分享.png";
        alink.click();
    }

    function upload2() {
        $("#messageForm2").submit();
        $("#messageForm2")[0] .reset();
    }

    //设置页面的可见性
    function myInfoPage(){
        document.getElementById("infoPage").style.display="block";
        document.getElementById("safePage").style.display="none";
        document.getElementById("appointmentInfoPage").style.display="none";
        document.getElementById("meetingInfoPage").style.display="none";
    }
    function mySafePage(){
        document.getElementById("safePage").style.display="block";
        document.getElementById("infoPage").style.display="none";
        document.getElementById("appointmentInfoPage").style.display="none";
        document.getElementById("meetingInfoPage").style.display="none";
    }
    function myAppointmentInfoPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("appointmentInfoPage").style.display="block";
        document.getElementById("meetingInfoPage").style.display="none";
    }
    function myMeetingInfoPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("appointmentInfoPage").style.display="none";
        document.getElementById("meetingInfoPage").style.display="block";
    }
    function meet1(){
        document.getElementById("makeOrderSpan").style.display="block";
        document.getElementById("seeMyOrderSpan").style.display="none";
    }
    function meet2() {
        document.getElementById("makeOrderSpan").style.display="none";
        document.getElementById("seeMyOrderSpan").style.display="block";
    }
    function m1() {
        document.getElementById("latestAppointmentSpan").style.display="block";
        document.getElementById("oldAppointmentSpan").style.display="none";
    }
    function m2() {
        document.getElementById("latestAppointmentSpan").style.display="none";
        document.getElementById("oldAppointmentSpan").style.display="block";
    }
    function startOrder() {
        document.getElementById("detailAppointment").click();
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
    //确认与会人员
    function confirmMember() {
        var groupName = document.getElementById("groupName").value;
        var msg = "您需要将当前所选人员创建为一个固定群组吗";
        if (confirm(msg)==true){
            isGroup = true;
        }else{
            return false;
        }
        $.ajax({
            url: '/staff/createGroup?groupName='+groupName,
            type: 'get',
            dataType: 'json',
            data: str,
            success: function (data) {
                //console.log(data);
                var jsonObj = JSON.parse(JSON.stringify(data));
                layer.msg("创建成功！");
            }
        });
    }

    //查看近期会议
    function queryLatestMeeting(){
        var HEADurl='/conference/staff/getRecently?personId='+'<%=session.getAttribute("staffId")%>';
        //近期会议
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#latestAppointment'
                ,url:HEADurl
                ,cols: [[
                    {field:'appointmentId', width:80, title: 'id', sort: true}
                    ,{field:'place', width:120, title: '场地名'}
                    ,{field:'address', width:120, title: '场地地址'}
                    ,{field:'start_time', width:250, title: '开始时间'}
                    ,{field:'end_time', width:250, title: '结束时间'}
                    ,{field:'introduction', width:250, title: '会议简介'}
                    ,{field:'organizer', width:250, title: '组织者'}
                    ,{field:'phone', width:250, title: '联系电话'}
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

    //查看历史会议
    function queryOldMeeting(){
        var HEADurl='/conference/staff/getHistory?personId='+'<%=session.getAttribute("staffId")%>';
        //历史会议
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#oldAppointment'
                ,url:HEADurl
                ,cols: [[
                    {field:'appointmentId', width:80, title: 'id', sort: true}
                    ,{field:'place', width:120, title: '场地名'}
                    ,{field:'address', width:120, title: '场地地址'}
                    ,{field:'start_time', width:250, title: '开始时间'}
                    ,{field:'end_time', width:250, title: '结束时间'}
                    ,{field:'introduction', width:250, title: '会议简介'}
                    ,{field:'organizer', width:250, title: '组织者'}
                    ,{field:'phone', width:250, title: '联系电话'}
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

    //群成员
    function showGroupMembers(group) {
        document.getElementById("33").click();
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#groupMembers'
                ,data:group
                ,toolbar: '#toolbarDemo2'
                ,cols: [[
                    {type: 'checkbox', fixed: 'left'}
                    ,{field:'id', width:80, title: 'id', sort: true}
                    ,{field:'groupId', width:80, title: '群组id'}
                    ,{field:'personId', width:80, title: '人员id'}
                    ,{field:'name', width:100, title: '姓名'}
                    ,{field:'identity', width:80, title: '身份'}
                ]]
                ,page: true
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
            });
            table.on('toolbar(groupMembers)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'getCheckData':
                        var data = checkStatus.data;
                        //var text = JSON.stringify(data);
                        for (var i = 0; i < data.length; i++) {
                            str.push(data[i]);
                        }
                        layer.msg("已选择！");
                        break;
                };
            });
        });
    }

    //查询历史与会人员
    function getHistory(){
        var group;
        var HEADurl='/staff/getPersonFromHistory?staff_id='+'<%=session.getAttribute("staffId")%>';
        var url='/staff/getGroup?staffId='+'<%=session.getAttribute("staffId")%>';
        // 初始化我创建的群组
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#group3'
                ,url:url
                ,cols: [[
                     {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'groupLeader', width:80, title: '群主'}
                    ,{field:'groupName', width:200, title: '群名'}
                    ,{field:'groupStyle', width:80, title: '状态'}
                    ,{fixed: 'right', title:'操作', toolbar: '#seeOP', width:260}
                ]]
                ,page: true
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                    var data = res.data[0].recommends;
                    jsondata = data;
                    length = data.length;
                    console.log(data);
                    return {
                        "code": res.status, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.count, //解析数据长度
                        "data": data //解析数据列表
                    };
                }
            });
            table.on('tool(group3)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                var groupId = info.id;
                if(obj.event === 'see'){
                    for(var i=0;i<length;i++){
                        if(jsondata[i].id == groupId){
                            group = jsondata[i].groupMembers;
                            console.log(group);
                            break;
                        }
                    }
                    showGroupMembers(group);
                }
                else if(obj.event === 'submit'){
                    $.ajax({
                        //几个参数需要注意一下
                        type: "POST",//方法类型
                        dataType: "json",//预期服务器返回的数据类型
                        url: "/conference/staff/appointment?isGroup=true"+"&groupId="+ groupId,//url
                        data: $('#messageForm2').serialize(),
                        success: function (data) {
                            code = data.data;
                            alert(data.msg);
                            document.getElementById("meetingcode").style.display = "block";
                            document.getElementById("button").style.display = "block";
                            $(function(){
                                $('#qrcode').qrcode({
                                    width: 128,
                                    height: 128,
                                    text: "{code:"+code+",type:200}"
                                });
                            })
                            $("#button").click(function () {
                                var canvasImg = document.getElementsByTagName('canvas')[0];
                                var img =convertCanvasToImage(canvasImg);
                                $('#qrcode').empty();
                                $('#qrcode').append(img);
                                downLoadCode();
                                alert("下载完成");
                            })
                        },
                        error : function() {
                            alert("异常！");
                        }
                    });
                }
            });
        });
        // 初始化我所在的群组
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#group6'
                ,url:url
                ,cols: [[
                     {field:'id', width:80, title: 'id', sort: true}
                    ,{field:'groupLeader', width:80, title: '群主'}
                    ,{field:'groupName', width:200, title: '群名'}
                    ,{field:'groupStyle', width:80, title: '状态'}
                    ,{fixed: 'right', title:'操作', toolbar: '#seeOP', width:260}
                ]]
                ,page: true
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                    var data = res.data[1].recommends;
                    group = res.data[1].recommends.groupMembers;
                    return {
                        "code": res.status, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.count, //解析数据长度
                        "data": data //解析数据列表
                    };
                }
            });
            table.on('tool(group6)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                var groupId = info.id;
                if(obj.event === 'see'){
                    showGroupMembers(group);
                }
                else if(obj.event === 'submit'){
                    $.ajax({
                        //几个参数需要注意一下
                        type: "POST",//方法类型
                        dataType: "json",//预期服务器返回的数据类型
                        url: "/conference/staff/appointment?isGroup=true"+"&groupId="+ groupId,//url
                        data: $('#messageForm2').serialize(),
                        success: function (data) {
                            code = data.data;
                            alert(data.msg);
                            document.getElementById("meetingcode").style.display = "block";
                            document.getElementById("button").style.display = "block";
                            $(function(){
                                $('#qrcode').qrcode({
                                    width: 128,
                                    height: 128,
                                    text: "{code:"+code+",type:200}"
                                });
                            })
                            $("#button").click(function () {
                                var canvasImg = document.getElementsByTagName('canvas')[0];
                                var img =convertCanvasToImage(canvasImg);
                                $('#qrcode').empty();
                                $('#qrcode').append(img);
                                downLoadCode();
                                alert("下载完成");
                            })
                        },
                        error : function() {
                            alert("异常！");
                        }
                    });
                }
            });
        });
        // 历史与会人员
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#attendpeople'
                ,url:HEADurl
                ,toolbar: '#toolbarDemo'
                ,cols: [[
                    {type: 'checkbox', fixed: 'left'}
                    ,{field:'id', width:80, title: 'id', sort: true}
                    ,{field:'name', width:100, title: '姓名'}
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
            table.on('toolbar(attendpeople)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'getCheckData':
                        document.getElementById("messageFormSubmit4").style.display="none";
                        var data = checkStatus.data;
                        var text = JSON.stringify(data);
                        $.ajax({
                            //几个参数需要注意一下
                            type: "POST",//方法类型
                            dataType: "json",//预期服务器返回的数据类型
                            url: "/conference/staff/appointment" ,//url
                            data: $('#messageForm2').serialize(),
                            success: function (data) {
                                code = data.data;
                                alert(data.msg);
                                $(function(){
                                    $('#qrcode').qrcode({
                                        width: 128,
                                        height: 128,
                                        text: "{code:"+code+",type:200}"
                                    });
                                })

                                $.ajax({
                                    url : '/conference/staff/addAttendPerson?meetingId='+code,
                                    data : JSON.stringify(text),
                                    type : "POST",
                                    success : function(data) {
                                        alert(data.msg);
                                    }
                                });

                                $("#button").click(function () {
                                    var canvasImg = document.getElementsByTagName('canvas')[0];
                                    var img =convertCanvasToImage(canvasImg);
                                    $('#qrcode').empty();
                                    $('#qrcode').append(img);
                                    downLoadCode();
                                    alert("下载完成");
                                })
                            },
                            error : function() {
                                alert("异常！");
                            }
                        });
                        break;
                    case 'getCheckLength':
                        var data = checkStatus.data;
                        layer.msg('选中了：'+ data.length + ' 个');
                        break;
                    case 'isAll':
                        layer.msg(checkStatus.isAll ? '全选': '未全选');
                        break;
                };
            });
        });
    }

    //取消预约
    function cancleMyAppointment(id){
        var url = "/conference/cancelAppointment?appointmentId="+id;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    //取消会议成功
    function cancelSuccess() {
        layer.msg("取消成功！");
        document.getElementById().click();
        queryMyAppointmentInfo();
    }

    //查询我的预约
    function queryMyAppointmentInfo(){
        document.getElementById("myDetailAppointment").click();
        var HEADurl='/conference/staff/getAppointment?personId='+'<%=session.getAttribute("staffId")%>';

        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#myAppointment'
                ,url:HEADurl
                ,cols: [[
                    {field:'appointmentId', width:80, title: '预约id', sort: true}
                    ,{field:'start_time', width:200, title: '开始时间'}
                    ,{field:'end_time', width:200, title: '结束时间'}
                    ,{field:'introduction', width:120, title: '会议简介'}
                    ,{field:'place', width:120, title: '场地名'}
                    ,{field:'address', width:120, title: '地址'}
                    ,{field:'organizer', width:120, title: '组织人'}
                    ,{field:'phone', width:120, title: '联系电话'}
                    ,{fixed: 'right', title:'操作', toolbar: '#appointmentOP', width:80}
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
            table.on('tool(myAppointment)', function(obj){
                var data = obj.data;
                var info = JSON.parse(JSON.stringify(data));
                tempId = info.appointmentId;
                //console.log(obj)
                if(obj.event === 'cancle'){
                    layer.confirm('确认取消此预约么', function(index){
                        cancleMyAppointment(tempId);
                    });
                }
            });
        });
    }

    //查询符合条件的可用场地信息
    function queryAvailablePlace() {
        document.getElementById("bestPlace").click();
        var layer;
        if (document.getElementById("start").value == '' || document.getElementById("end").value == '') {
            layui.use(['layer'], function () {
                layer = layui.layer //弹层
                layer.msg('请输入完整信息！');
            });
        } else {
            layui.use(['layer'], function () {
                layer = layui.layer //弹层
                layer.msg('正在查询中...');
            });
            document.getElementById("messageFormSubmit3").style.display = "block";
            var id = document.getElementById("companyId").value;
            var start = document.getElementById("start").value;
            var end = document.getElementById("end").value;
            var duration = document.getElementById("duration").value;
            var capacity = document.getElementById("capacity").value;
            var longitude = document.getElementById("longitude").value;
            var latitude = document.getElementById("latitude").value;

            if(longitude == '' || latitude == ''){
                longitude = "120.043227827469";
                latitude = "30.235229647064685";
            }
            var ajaxurl = '/place/staff/getRecommendList';
            var HEADurl = '/place/staff/getRecommendList?companyId=' + id + '&starttime=' + start + "&endtime=" + end + "&duration="
                + duration + "&capacity=" + capacity + '&longitude=' + longitude+'&latitude=' + latitude;
            $.ajax({
                url: HEADurl,
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    //console.log(data);
                    var jsonObj = JSON.parse(JSON.stringify(data));
                    showAvailablePlace(jsonObj);
                }
            });
        }

    }

    function showAvailablePlace(datalist) {
        $.ajax({
            type:"POST",
            async:false,
            dataType:'text',
            contentType : "application/json",
            url:"/place/staff/showBestRecommand",
            data: JSON.stringify(datalist),
            success:function (data) {
                //最佳推荐会议室
                layui.use('table', function(){
                    var table = layui.table,form = layui.form;
                    table.render({
                        elem: '#place'
                        ,url : "/place/staff/showBestRecommand2"
                        ,cols: [[
                            {field:'id', width:80, title: 'id', sort: true}
                            ,{field:'type', width:100, title: '场地类型'}
                            ,{field:'name', width:120, title: '场地名称'}
                            ,{field:'address', width:120, title: '场地地址'}
                            ,{field:'capacity', width:100, title: '场地容量'}
                            ,{field:'introduction', width:120, title: '场地简介'}
                            ,{field:'device', width:120, title: '场地设备'}
                            ,{field:'instruction', width:130, title: '使用须知'}
                            ,{field:'lock', title:'是否选中', width:110, templet: '#checkboxTpl', unresize: true}
                        ]]
                        ,page: true
                    });
                    form.on('checkbox(lockDemo)', function(obj){
                        layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
                    });
                    table.on('row(place)', function(obj){
                        var data = obj.data;
                        var info = JSON.parse(JSON.stringify(data));
                        tempId = info.id;
                        document.getElementById("placeId").value=info.id;
                        document.getElementById("placeName").value=info.name;
                        document.getElementById("placeType").value=info.type;
                        //标注选中样式
                        obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
                    });
                });
                //可用会议室
                layui.use('table', function(){
                    var table = layui.table,form = layui.form;
                    table.render({
                        elem: '#nextplace'
                        ,url : "/place/staff/showNextRecommand"
                        ,cols: [[
                            {field:'id', width:80, title: 'id', sort: true}
                            ,{field:'type', width:100, title: '场地类型'}
                            ,{field:'name', width:120, title: '场地名称'}
                            ,{field:'address', width:120, title: '场地地址'}
                            ,{field:'capacity', width:100, title: '场地容量'}
                            ,{field:'introduction', width:120, title: '场地简介'}
                            ,{field:'device', width:120, title: '场地设备'}
                            ,{field:'instruction', width:130, title: '使用须知'}
                            ,{field:'lock', title:'是否选中', width:110, templet: '#checkboxTpl', unresize: true}
                        ]]
                        ,page: true
                    });
                    form.on('checkbox(lockDemo)', function(obj){
                        layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
                    });
                    table.on('row(nextplace)', function(obj){
                        var data = obj.data;
                        var info = JSON.parse(JSON.stringify(data));
                        tempId = info.id;
                        document.getElementById("placeId").value=info.id;
                        document.getElementById("placeName").value=info.name;
                        document.getElementById("placeType").value=info.type;
                        //标注选中样式
                        obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
                    });
                });
            }
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


