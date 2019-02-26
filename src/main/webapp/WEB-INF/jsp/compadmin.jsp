
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
        <div class="layui-logo">组织管理员端</div>
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
                    ${sessionScope.admin.getId_num()}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" onclick="myInfoPage();">基本资料</a></dd>
                    <dd><a href="javascript:;" onclick="mySafePage();">安全设置</a></dd>
                    <dd><a href="javascript:;" onclick="myFacePage();">人脸信息</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">注销</a></li>
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
                    <a href="javascript:;" onclick="queryDepartmentList();myEmployInfoPage();">职员管理</a>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;">场地管理</a>
                    <dl class="layui-nav-child" id="meetingroomList">
                        <dd><a href="javascript:;" onclick="hideOthers(this);myMeetingroomPage();" id="meetingroomOrderListSp">场地预约情况</a></dd>
                        <dd><a href="javascript:;" onclick="hideOthers(this);myMeetingroomPage();" id="meetingroomDetailListSp">场地具体信息</a></dd>
                        <dd><a href="javascript:;" onclick="hideOthers(this);myMeetingroomPage();" id="addMeetingroomListSp">添加场地</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;">出租管理</a>
                    <dl class="layui-nav-child" id="rentoutList">
                        <dd><a href="javascript:;" onclick="myRentPage();rent1();" id="reviewOrderListSp">审核预约申请</a></dd>
                        <dd><a href="javascript:;" onclick="myRentPage();rent2();" id="askForPayListSp">申请索赔</a></dd>
                        <dd><a href="javascript:;" onclick="myRentPage();rent3();" id="remarkListSp">游客评价</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <div id="infoPage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">基本资料</legend>
        </fieldset>
        <form class="layui-form" action="/updateAdmin" method="post" target="teacherInfoFrame">
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">姓名</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.admin.getId_num()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">公司</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.admin.getCompany().getName()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">联系方式</label>
                    <input type="tel" style="width: 500px" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input" value="${sessionScope.admin.getPhone()}">
                </div>
            </div>

            <input type="hidden" name="password" value="${sessionScope.admin.getPswd()}"/>
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
        <form class="layui-form" action="/adminSafe" method="post">
            <div class="layui-form-item" align="center">
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">旧密码</label>
                    <input type="password" style="width: 400px"  name="phone"    lay-verify="required|old" placeholder="请输入旧密码" autocomplete="off" class="layui-input">

                    <label class="layui-form-label" align="left">新密码</label>
                    <input type="password"  id="newPassword" style="width: 400px"  name="pswd" lay-verify="password" placeholder="请输入新密码" autocomplete="off" class="layui-input">

                    <label class="layui-form-label" align="left">请确认</label>
                    <input type="password" style="width: 400px"  name="repswd" lay-verify="repassword" placeholder="请输入新密码" autocomplete="off" class="layui-input">
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
                    <button type="button" class="layui-btn layui-btn-normal" id="selectface" >选择新照片</button>
                    <button type="button" class="layui-btn" id="faceUploadButton" onclick="upload();">开始上传</button><br>
                    <iframe name="frame1" frameborder="0" height="40"></iframe>
                </div>
            </center>
        </form>
    </div>
    <div id="employeeInfoPage" class="layui-body" style="background-color: rgb(242,242,242);display:block;">
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
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--职员信息--%>
                    <div class="layui-tab-item"><table class="layui-hide" id="test" lay-filter="test"></table></div>
                    <%--添加职员--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm" action="/upEmployee"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">职员编号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="id" required  lay-verify="required" placeholder="请输入职员编号" autocomplete="off" class="layui-input">
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
                                    <input type="radio" name="sex" value="男" title="男">
                                    <input type="radio" name="sex" value="女" title="女" checked>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">公司ID</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" id="company_id" name="company_id" placeholder=""/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">部门</label>
                                <div class="layui-input-block">
                                    <input type="text" name="department_name" required  lay-verify="required" placeholder="请输入所在部门名称" autocomplete="off" class="layui-input">
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
                                <div class="layui-inline">
                                    <label class="layui-form-label">人脸信息</label>
                                    <div class="layui-input-block">
                                        <input type="text" class="layui-input" id=face_info" name="face_info" placeholder="人脸图片地址"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">登陆密码</label>
                                <div class="layui-input-block">
                                    <input type="password" name="pswd" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit" class="layui-btn" onclick="setTimeout(upMessage,'1000');">确认添加</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset">重置</button>
                            </div>
                        </form>
                        <script type="text/html" id="barOP">
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="deleteMessage">删除</a>
                        </script>
                    </div>
                    <%--查找职员--%>
                    <div class="layui-tab-item">
                        <div class="layui-form-item">
                            <label class="layui-form-label">输入工号</label>
                            <div class="layui-input-block">
                                <input type="text" name="tno" id="tno" autocomplete="off" placeholder="请输入职员工号" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button  class="layui-btn" lay-submit lay-filter="formDemo10" onclick="findTheEmployee();">立即查询</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                            </div>
                        </div>

                        <table id="TT" lay-filter="test11"></table>
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
        </div>
        <div class="layui-tab-item"><table class="layui-hide" id="meetingroom" lay-filter="meetingroom"></table></div>
        <!--场地具体信息-->
        <div style="display:none;" id="meetingroomDetailListSpan">
            <fieldset id="meetingroomDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>场地详情</legend>
            </fieldset>
        </div>
        <!--添加场地-->
        <div style="display:none;" id="addMeetingroomListSpan">
            <fieldset id="addMeetingroom"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>添加场地</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="addmeet">点击添加场地</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm2" action="/upStudent"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地编号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="id" required  lay-verify="required" placeholder="请输入场地编号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地名称</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" required  lay-verify="required" placeholder="请输入场地名称" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">场地类型</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="type" value="大会议室" title="大会议室">
                                    <input type="radio" name="type" value="小会议室" title="小会议室" checked>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">地址</label>
                                    <div class="layui-input-block">
                                        <input type="text" class="layui-input" id="address" name="company_id" placeholder="请输入场地地址" autocomplete="off"/>
                                    </div>
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
                                    <input type="text" name="equipment_info" required  lay-verify="required" placeholder="请输入场地内设备信息" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">使用须知</label>
                                <div class="layui-input-block">
                                    <input type="text" name="instruction" required  lay-verify="required" placeholder="请输入使用须知" autocomplete="off" class="layui-input">
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
                                <label class="layui-form-label">所属组织</label>
                                <div class="layui-input-block">
                                    <input type="password" name="company_id" required lay-verify="required" placeholder="请输入所属组织ID"  class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit2" class="layui-btn" onclick="setTimeout(upMessage,'1000');">确认添加</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset2">重置</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="rentInfoPage" class="layui-body" style="background-color: rgb(242,242,242);display:block;">
        <!--审核游客预约申请-->
        <div style="display:none;" id="guestOrderListSpan">
            <fieldset id="guestOrderDetail"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>审核预约申请</legend>
            </fieldset>
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
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © 管理员端
    </div>
</div>
<script src="/layui/layui.js"></script>
<script>

    //查找学生信息
    function findones(){

        var sno = document.getElementById('snosno').value;

        layui.use('table', function () {
            var table = layui.table;

            table.render({
                elem: '#ST'
                , height: 312
                , url: 'findStudent?sno='+sno
                , page: true //开启分页
                , cols: [[ //表头
                    {field: 'sno', title: '学生编号',edit: 'text', width: 80, sort: true, fixed: 'left'}
                    , {field: 'sname', title: '学生姓名',edit: 'text', width: 80}
                    , {field: 'sex', title: '性别',edit: 'text', width: 80, sort: true}
                    , {field: 'cno', title: '班级编号',edit: 'text', width: 80}
                    , {field: 'birthday', title: '出生日期',edit: 'text', width: 100}
                    , {field: 'enteryear', title: '入学年份',edit: 'text', width: 80, sort: true}
                    ,{fixed: 'right', width:178, align:'center', toolbar: '#barDemo1'}

                ]]
            });

        });
    }
    //查找教师信息
    function findTones(){

        var tno = document.getElementById('tno').value;

        layui.use('table', function () {
            var table = layui.table;

            table.render({
                elem: '#TT'
                , height: 312
                , url: 'findTeacher?tno='+tno
                , page: true //开启分页
                , cols: [[ //表头
                    {field: 'tno', title: '教师编号',edit: 'text', width: 80, sort: true, fixed: 'left'}
                    , {field: 'tname', title: '教师姓名',edit: 'text', width: 80}
                    , {field: 'sex', title: '性别',edit: 'text', width: 80, sort: true}
                    , {field: 'title', title: '职称',edit: 'text', width: 80}
                    , {field: 'birthday', title: '出生日期',edit: 'text', width: 100}
                    , {field: 'phone', title: '联系方式',edit: 'text', width: 100}
                    ,{fixed: 'right', width:178, align:'center', toolbar: '#barDemo10'}

                ]]
            });

        });
    }

    //监听教师删除事件
    layui.use('table', function(){
        var table = layui.table;

        //监听单元格编辑
        table.on('tool(test11)', function(obj){
            var data = obj.data;
            if(obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            }
            createXMLHttpRequest();
            xmlHttp.open("GET", 'delTeacher1?tno='+data.tno, true); xmlHttp.send(null);


        });
    });
    //监听学生删除事件
    layui.use('table', function(){
        var table = layui.table;

        //监听单元格编辑
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            }
            createXMLHttpRequest();
            xmlHttp.open("GET", 'delStudent?sno='+data.sno, true); xmlHttp.send(null);


        });
    });
    //监听开课删除事件
    layui.use('table', function(){
        var table = layui.table;

        //监听单元格编辑
        table.on('tool(test5)', function(obj){
            var data = obj.data;
            if(obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            }
            createXMLHttpRequest();
            xmlHttp.open("GET", 'delOpenl?gno='+data.gno, true); xmlHttp.send(null);


        });
    });



    //显示所有学生信息并监听更新
    layui.use('table', function(){
            var table = layui.table;

            //监听单元格编辑
            table.on('edit(test3)', function(obj){
                var value = obj.value //得到修改后的值
                    ,data = obj.data //得到所在行所有键值
                    ,field = obj.field; //得到字段
                layer.msg('[ID: '+ data.sno +'] ' + field + ' 字段更改为：'+ value);
                createXMLHttpRequest();
                xmlHttp.open("GET", 'updateStudent?sno='+data.sno+'&sname='+data.sname+'&sex='+data.sex+
                    "&cno="+data.cno+"&enteryear="+data.enteryear+"&birthday="+data.birthday+'&phone='+data.phone+'&password='+data.password, true); xmlHttp.send(null);
                layer.msg("更新成功");

            });
        });
    //显示所有教师信息并监听更新
    layui.use('table', function(){
        var table = layui.table;

        //监听单元格编辑
        table.on('edit(test10)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段
            layer.msg('[ID: '+ data.tno +'] ' + field + ' 字段更改为：'+ value);
            createXMLHttpRequest();
            xmlHttp.open("GET", 'updateTeacher1?tno='+data.tno+'&tname='+data.tname+'&sex='+data.sex+
                "&title="+data.title+"&birthday="+data.birthday+'&phone='+data.phone+'&password='+data.password, true); xmlHttp.send(null);
            layer.msg("更新成功");

        });
    });
    //显示所有开课信息并监听更新
    layui.use('table', function () {
        var table = layui.table;

        //监听单元格编辑
        table.on('edit(test4)', function (obj) {
            var value = obj.value //得到修改后的值
                , data = obj.data //得到所在行所有键值
                , field = obj.field; //得到字段
            layer.msg('[ID: ' + data.gno + '] ' + field + ' 字段更改为：' + value);
            createXMLHttpRequest();
            xmlHttp.open("GET", 'updateOpenl?gno=' + data.gno + '&cno=' + data.cno + '&day=' + data.day +
                "&lno=" +data.lno + "&tno=" +data.tno, true);
            xmlHttp.send(null);

        });
    });
    //查找单个已开课程信息并且修改信息
    function findoneopenones() {
        var gno = document.getElementById('opno').value;

        layui.use('table', function () {
            var table = layui.table;

            table.render({
                elem: '#findonel'
                , height: 312
                , url: 'findoneopenl?gno='+gno
                , page: true //开启分页
                , cols: [[ //表头
                    {field: 'gno', title: '开课编号', width: 80, sort: true, edit: 'text',fixed: 'left'}
                    , {field: 'lno', title: '课程编号',edit: 'text', width: 80}
                    , {field: 'tno', title: '教师编号',edit: 'text', width: 80, sort: true}
                    , {field: 'cno', title: '班级编号',edit: 'text', width: 80}
                    , {field: 'day', title: '课程学时', edit: 'text',width: 100}
                    ,{fixed: 'right', width:178, align:'center', toolbar: '#barDemo2'}

                ]]
            });

        });
    }
    //监听查出单个教师信息修改
    layui.use('table', function () {
        var table = layui.table;

        //监听单元格编辑
        table.on('edit(test11)', function (obj) {
            var value = obj.value //得到修改后的值
                , data = obj.data //得到所在行所有键值
                , field = obj.field; //得到字段
            layer.msg('[ID: ' + data.tno + '] ' + field + ' 字段更改为：' + value);
            createXMLHttpRequest();
            xmlHttp.open("GET", 'updateTeacher1?tno='+data.tno+'&tname='+data.tname+'&sex='+data.sex+
                "&title="+data.title+"&birthday="+data.birthday+'&phone='+data.phone+'&password='+data.password, true); xmlHttp.send(null);
            layer.msg("更新成功");

        });
    });
    //监听查出单个学生信息修改
    layui.use('table', function(){
        var table = layui.table;

        //监听单元格编辑
        table.on('edit(test)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段
            layer.msg('[ID: '+ data.sno +'] ' + field + ' 字段更改为：'+ value);
            createXMLHttpRequest();
            xmlHttp.open("GET", 'updateStudent?sno='+data.sno+'&sname='+data.sname+'&sex='+data.sex+
                "&cno="+data.cno+"&enteryear="+data.enteryear+"&birthday="+data.birthday+'&phone='+data.phone+'&password='+data.password, true); xmlHttp.send(null);
            layer.msg("更新成功");

        });
    });


    //查询课程库里的课程并修改
    function findonele() {
        var lno = document.getElementById('lesson').value;

        layui.use('table', function () {
            var table = layui.table;

            table.render({
                elem: '#findone3'
                , height: 312
                , url: 'findonel?lno='+lno
                , page: true //开启分页
                , cols: [[ //表头
                     {field: 'lno', title: '课程编号',edit: 'text',sort: true, width: 80 ,fixed: 'left'}
                    , {field: 'lhour', title: '课程学时',edit: 'text', width: 80, sort: true}
                    , {field: 'lname', title: '课程名称',edit: 'text', width: 80}
                    ,{fixed: 'right', width:178, align:'center', toolbar: '#barDemo3'}
                ]]
            });

        });
    }

    //监听查出的单个课程库信息
    layui.use('table', function () {
        var table = layui.table;

        //监听单元格编辑
        table.on('edit(test6)', function (obj) {
            var value = obj.value //得到修改后的值
                , data = obj.data //得到所在行所有键值
                , field = obj.field; //得到字段
            layer.msg('[ID: ' + data.lno + '] ' + field + ' 字段更改为：' + value);
            createXMLHttpRequest();
            xmlHttp.open("GET", 'updatel?lno=' + data.lno + '&lhour=' + data.lhour + '&lname=' + data.lname , true);
            xmlHttp.send(null);

        });
    });
    //监听课程库删除事件
    layui.use('table', function(){
        var table = layui.table;

        //监听单元格编辑
        table.on('tool(test6)', function(obj){
            var data = obj.data;
            if(obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            }
            createXMLHttpRequest();
            xmlHttp.open("GET", 'dell?lno='+data.lno, true); xmlHttp.send(null);


        });
    });

    //监听查出的单个开课信息
    layui.use('table', function () {
        var table = layui.table;


        //监听单元格编辑
        table.on('edit(test5)', function (obj) {
            var value = obj.value //得到修改后的值
                , data = obj.data //得到所在行所有键值
                , field = obj.field; //得到字段
            layer.msg('[ID: ' + data.gno + '] ' + field + ' 字段更改为：' + value);
            createXMLHttpRequest();
            xmlHttp.open("GET", 'updateOpenl?gno=' + data.gno + '&cno=' + data.cno + '&day=' + data.day +
                "&lno=" + data.lno + "&tno=" + data.tno, true);
            xmlHttp.send(null);

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
    });
    //日期时间选择器：课程通知
    var layer;
    layui.use(['layer'], function(){
        layer = layui.layer //弹层
        layer.msg('欢迎您管理员!');
    });


    var xmlHttp;
    var type;

    var tempId;
    var tempName;

    function upMessage() {
        document.getElementById("messageForm").reset();
        layer.msg('添加成功');
    }
    function upMessage1() {
        document.getElementById("messageForm1").reset();
        layer.msg('添加成功');
    }

    function upMessage8() {
        document.getElementById("messageForm5").reset();
        layer.msg('添加成功');
    }
    function upload() {
        $("#formId").submit();
        $("#formId")[0] .reset();
    }
    function hideOthers(obj) {
        var id = obj.id+'an';
        var tab = document.getElementById("meetingroomList");
        for(var i =3;i<tab.childNodes.length;i=i+2){
            if(tab.childNodes[i].childNodes[0].id+'an'==id)
                document.getElementById(tab.childNodes[i].childNodes[0].id+'an').style.display="";
            else
                document.getElementById(tab.childNodes[i].childNodes[0].id+'an').style.display="none";
        }

    }
    function hideOthers2(obj) {
        var id = obj.id+'an';
        var tab = document.getElementById("rentoutList");
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
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function mySafePage(){
        document.getElementById("facePage").style.display="none";
        document.getElementById("safePage").style.display="block";
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("infoPage").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function  myFacePage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("facePage").style.display="block";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function  myEmployInfoPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("facePage").style.display="none";
        document.getElementById("employeeInfoPage").style.display="block";
        document.getElementById("employeeInformationListSpan").style.display="block";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function myMeetingroomPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("facePage").style.display="none";
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("employeeInformationListSpan").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="block";
        document.getElementById("rentInfoPage").style.display="none";
    }
    function myRentPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("facePage").style.display="none";
        document.getElementById("employeeInfoPage").style.display="none";
        document.getElementById("employeeInformationListSpan").style.display="none";
        document.getElementById("meetingroomInfoPage").style.display="none";
        document.getElementById("rentInfoPage").style.display="block";
    }
    function rent1(){
        document.getElementById("guestOrderListSpan").style.display="block";
        document.getElementById("askForPayListSpan").style.display="none";
        document.getElementById("guestRemarkListSpan").style.display="none";
    }
    function rent2() {
        document.getElementById("askForPayListSpan").style.display="block";
        document.getElementById("guestOrderListSpan").style.display="none";
        document.getElementById("guestRemarkListSpan").style.display="none";
    }
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

    // 初始化显示当前部门信息
    function queryDepartmentList(){
        var url = "queryDepartmentList";
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    //删除职员
    function deleteStaff(){

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
    // 职员管理初始化
    function employeeInformation(obj) {
        var dname = obj.childNodes[0].nodeValue;

        document.getElementById("currentdname").name=dname;

        var DEPARTurl='department_employee?dname='+dname;
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#test'
                ,url: DEPARTurl
                ,cols: [[
                    {field:'id', width:100, title: 'id号', sort: true}
                    ,{field:'name', width:80, title: '姓名'}
                    ,{field:'company_id', width:80, title: '公司id'}
                    ,{field:'job_num', width:120, title: '工号'}
                    ,{field:'department_name', width:120,title: '部门'}
                    ,{field:'pswd', width:120, title: '密码'}
                    ,{field:'id_num', width:120, title: '身份证号'}
                    ,{field:'phone', width:120, title: '手机号'}
                    ,{field:'face_info', width:150, title: '人脸信息'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:80}
                ]]
                ,page: true
            });
            table.on('tool(test)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'delete'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    var info = JSON.parse(JSON.stringify(data));
                    tempId = info.id;
                    tempName = info.name;
                    layer.confirm('真的删除此职员么', function(index){
                        obj.del();
                        layer.close(index);
                    });
                }
            });
        });
    }
    // 查找班主任的学生
    function midInformation(){
        var HEADurl='remarkStudentInformation?tno='+'${sessionScope.Tno}';

        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#mid1'
                ,url:HEADurl
                ,cols: [[
                    {field:'sno', width:150, title: '学号', sort: true}
                    ,{field:'sname', width:80, title: '姓名'}
                    ,{field:'sex', width:80, title: '性别'}
                    ,{field:'cno', width:120, title: '班级'}
                    ,{field:'birthday', width:120, title: '出生日期'}
                    ,{field:'enteryear', width:120, title: '入学年份'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:150}
                ]]
                ,page: true
            });

            table.on('tool(mid1)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'remark'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    //这里设置评价对象
                    document.getElementById('person').innerHTML='评价对象：'+tempSno+','+tempSname;
                    document.getElementById('headTeacherRemarkTable').click();
                }else if(obj.event === 'change'){
                    document.getElementById('headTeacherRemarkTable').click();
                }
            });
        });

        //这里设置评分星星
        layui.use(['rate'], function() {
            var rate = layui.rate;
            rate.render({
                elem: '#score1'
                , length: 10
                , value: 0 //初始值
                ,text: true
                ,setText: function(value) {
                    this.span.text(value);
                }
                ,choose:function (value) {
                    headscore1=value
                }
            });
            rate.render({
                elem: '#score2'
                , length: 10
                , value: 0 //初始值
                ,text: true
                ,setText: function(value) {
                    this.span.text(value);
                }
                ,choose:function (value) {
                    headscore2=value
                }
            });
            rate.render({
                elem: '#score3'
                , length: 10
                , value: 0 //初始值
                ,text: true
                ,setText: function(value) {
                    this.span.text(value);
                }
                ,choose:function (value) {
                    headscore3=value
                }
            });
            rate.render({
                elem: '#score4'
                , length: 10
                , value: 0 //初始值
                ,text: true
                ,setText: function(value) {
                    this.span.text(value);
                }
                ,choose:function (value) {
                    headscore4=value
                }
            });
            rate.render({
                elem: '#score5'
                , length: 10
                , value: 0 //初始值
                ,text: true
                ,setText: function(value) {
                    this.span.text(value);
                }
                ,choose:function (value) {
                    headscore5=value
                }
            });
            rate.render({
                elem: '#score6'
                , length: 10
                , value: 0 //初始值
                ,text: true
                ,setText: function(value) {
                    this.span.text(value);
                }
                ,choose:function (value) {
                    headscore6=value
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


