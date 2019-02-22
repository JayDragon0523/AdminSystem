
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
                    ${sessionScope.Teacher.getTname()}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" onclick="myInfoPage();">基本资料</a></dd>
                    <dd><a href="javascript:;" onclick="mySafePage();">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退了</a></li>
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
                        <%--<dd><a href="javascript:;">列表三</a></dd>--%>
                        <%--<dd><a href="">超链接</a></dd>--%>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">后台管理</a>
                    <dl class="layui-nav-child" id="meetingroomList">
                        <dd><a href="javascript:;" onclick="queryTeachersLesson();myTeachPage();" id="reviewcompAdminSp">审核组织</a></dd>
                        <dd><a href="javascript:;" onclick="hideOthers(this);myTeachPage();" id="compAdminInfoSp">组织管理员信息</a></dd>
                        <dd><a href="javascript:;" onclick="hideOthers(this);myTeachPage();" id="deleteCompanySp">删除组织</a></dd>
                        <dd><a href="javascript:;" onclick="hideOthers(this);myTeachPage();" id="visitorInfoSp">查看游客</a></dd>
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
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.admin.getCompany_id()}">
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
                    <input type="password"  id="newPassword" style="width: 400px"  name="password" lay-verify="password" placeholder="请输入新密码" autocomplete="off" class="layui-input">

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
    <div id="faceinfoPage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">人脸信息</legend>
        </fieldset>
        <%--<form class="layui-form" action="/adminSafe" method="post">--%>
            <%--<div class="layui-form-item" align="center">--%>
                <%--<div class="layui-inline">--%>
                    <%--<label class="layui-form-label" align="left">旧密码</label>--%>
                    <%--<input type="password" style="width: 400px"  name="phone"    lay-verify="required|old" placeholder="请输入旧密码" autocomplete="off" class="layui-input">--%>

                    <%--<label class="layui-form-label" align="left">新密码</label>--%>
                    <%--<input type="password"  id="newPassword" style="width: 400px"  name="password" lay-verify="password" placeholder="请输入新密码" autocomplete="off" class="layui-input">--%>

                    <%--<label class="layui-form-label" align="left">请确认</label>--%>
                    <%--<input type="password" style="width: 400px"  name="repassword" lay-verify="repassword" placeholder="请输入新密码" autocomplete="off" class="layui-input">--%>
                <%--</div>--%>
                <%--<div class="layui-word-aux">请填写6到12位新密码</div>--%>
            <%--</div>--%>
            <%--<div class="layui-form-item" align="center">--%>
                <%--<div class="layui-inline">--%>
                    <%--<button class="layui-btn"  type="submit" lay-submit="" lay-filter="demo1">立即提交</button>--%>
                    <%--<button type="reset"  class="layui-btn layui-btn-primary">重置</button>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</form>--%>
    </div>
    <div id="teachPage" class="layui-body" style="background-color: rgb(242,242,242);display:block;">
        <!-- 已经开设的课程 -->
        <div style="display:block;" id="teachersLessonListSpan">
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>当前已经开设课程信息</legend>
            </fieldset>
            <div class="layui-row layui-col-space155" style="background-color: rgb(242,242,242);" id="teachersLessonList">
                <div id="openLesson"></div>
            </div>
        </div>
        <!--学生管理-->
        <div style="display:none;" id="lessonInformationListSpan">
            <fieldset id="homeworkLno"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>学生管理</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li class="layui-this">学生信息</li>
                    <li>新增学生</li>
                    <li>查找学生</li>

                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--学生信息--%>
                    <div class="layui-tab-item">

                        <table class="layui-table" lay-data="{url:'findStudents', id:'test3'}" lay-filter="test3">
                            <thead>
                            <tr>
                                <th lay-data="{field:'sno', width:80, sort: true}">学生编号</th>
                                <th lay-data="{field:'sname', width:100, sort: true, edit: 'text'}">学生姓名</th>
                                <th lay-data="{field:'sex', edit: 'text'width:60}">性别</th>
                                <th lay-data="{field:'cno', width:80, edit: 'text'}">班级编号</th>
                                <th lay-data="{field:'enteryear',width:100, sort: true, edit: 'text'}">入学年份</th>
                                <th lay-data="{field:'birthday', width:100,sort: true, edit: 'text'}">出生日期</th>
                                <th lay-data="{field:'phone', width:120,sort: true, edit: 'text'}">联系方式</th>
                                <th lay-data="{field:'password',width:100, sort: true, edit: 'text'}">登陆密码</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                    <%--新增学生--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm" action="/upStudent"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">学生编号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="sno" required  lay-verify="required" placeholder="请输入学生编号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">学生姓名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="sname" required  lay-verify="required" placeholder="请输入学生姓名" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">入学日期</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" id="messageTime" name="enteryear" placeholder="yyyy-MM-dd HH:mm:ss"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">班级编号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="cno" required  lay-verify="required" placeholder="请输入班级编号" autocomplete="off" class="layui-input">
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
                                <label class="layui-form-label">系编号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="dno" required  lay-verify="required" placeholder="请输入系编号" autocomplete="off" class="layui-input">
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
                                    <label class="layui-form-label">出生年月</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" id=Time1" name="birthday" placeholder="yyyy-MM-dd"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">学生登陆密码</label>
                                <div class="layui-input-block">
                                    <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit" class="layui-btn" onclick="setTimeout(upMessage,'1000');">确认添加</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset">重置</button>
                            </div>
                        </form>
                    </div>
                    <%--查找学生--%>
                    <div class="layui-tab-item">

                        <div class="layui-form-item">
                            <label class="layui-form-label">输入学生编号</label>
                            <div class="layui-input-block">
                                <input type="text" name="sno" id="snosno" autocomplete="off" placeholder="请输入学生编号" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button  class="layui-btn" lay-submit lay-filter="formDemo" onclick="findones();">立即查询</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                            </div>
                        </div>


                        <table id="ST" lay-filter="test"></table>
                        <script type="text/html" id="barDemo1">
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                        </script>


                    </div>

                </div>
            </div>
        </div>
        <!--课程情况管理-->
        <div style="display:none;" id="midInformationListSpan">
            <fieldset id="midManagement"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>开课情况管理</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li >开课管理</li>
                    <li >新增开课</li>
                    <li >课程库管理</li>
                    <li >新增课程库</li>
                </ul>

                <div class="layui-tab-content" style="height: 100px;">
                    <%--开课管理--%>
                    <div class="layui-tab-item">
                        <div class="layui-form-item">
                            <label class="layui-form-label">开课编号</label>
                            <div class="layui-input-block">
                                <input type="text" name="opno" id="opno" autocomplete="off" placeholder="请输入开课编号" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button  class="layui-btn" lay-submit  onclick="findoneopenones();">立即查询</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                            </div>
                        </div>

                        <table class="layui-table" lay-data="{url:'findopenlesson', id:'test4'}" lay-filter="test4">
                            <thead>
                            <tr>
                                <th lay-data="{field:'gno', width:80, sort: true}">课程编号</th>
                                <th lay-data="{field:'cno', width:80, sort: true, edit: 'text'}">开设班级编号</th>
                                <th lay-data="{field:'day',width:100, sort: true, edit: 'text'}">开课学时</th>
                                <th lay-data="{field:'lno', width:80, edit: 'text'}">课程码</th>
                                <th lay-data="{field:'tno',width:100, sort: true, edit: 'text'}">教师编号</th>
                            </tr>
                            </thead>
                        </table>
                        <table class="layui-table" id="findonel" lay-filter="test5"></table>
                        <script type="text/html" id="barDemo2">
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                        </script>
                    </div>
                    <%--新增开课--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm1" action="/upOpenlesson"  method="POST" >
                            <div class="layui-form-item">
                                <label class="layui-form-label">开课编号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="gno" required  lay-verify="required" placeholder="请输入开课编号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">开课班级</label>
                                <div class="layui-input-block">
                                    <input type="text" name="cno" required  lay-verify="required" placeholder="请输入开课班级" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">课程时间</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input"  name="day" placeholder="yyyy-MM-dd HH:mm:ss"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">课程编号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="lno" required  lay-verify="required" placeholder="请输入课程编号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">教师编号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="tno" required  lay-verify="required" placeholder="请输入系编号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit1" class="layui-btn" onclick="upMessage1();">确认开课</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset1">重置</button>
                            </div>
                        </form>
                    </div>

                    <%--课程库管理--%>
                    <div class="layui-tab-item">
                        <div class="layui-form-item">
                            <label class="layui-form-label">课程库里的编号</label>
                            <div class="layui-input-block">
                                <input type="text" name="lesson" id="lesson" autocomplete="off" placeholder="请输入课程编号" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button  class="layui-btn" lay-submit  onclick="findonele();">立即查询</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                            </div>
                        </div>

                        <table class="layui-table" id="findone3" lay-filter="test6"></table>
                        <script type="text/html" id="barDemo3">
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                        </script>
                    </div>

                    <%--新增课程库课程--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm2" action="/uplesson"  method="POST" >
                            <div class="layui-form-item">
                                <label class="layui-form-label">课程编号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="lno" required  lay-verify="required" placeholder="请输入课程编号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">课程学时</label>
                                <div class="layui-input-block">
                                    <input type="text" name="lhour" required  lay-verify="required" placeholder="请输入开课学时" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">课程名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" required  lay-verify="required" name="lname" autocomplete="off" class="layui-input"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit2" class="layui-btn" onclick="setTimeout(upMessage2,'1000');">确认添加</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset2">重置</button>
                            </div>
                        </form>
                    </div>


                </div>
            </div>
        </div>
        <%--教师管理--%>
        <div style="display:none;" id="finalInformationListSpan">
            <fieldset id="homeworkLno1"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>教师管理</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li class="layui-this">教师信息</li>
                    <li>新增教师</li>
                    <li>查找教师</li>

                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--教师信息--%>
                    <div class="layui-tab-item">

                        <table class="layui-table" lay-data="{url:'findTeachers', id:'test10'}" lay-filter="test10">
                            <thead>
                            <tr>
                                <th lay-data="{field:'tno', width:80, sort: true}">教师编号</th>
                                <th lay-data="{field:'tname', width:100, sort: true, edit: 'text'}">教师姓名</th>
                                <th lay-data="{field:'sex', edit: 'text'width:60}">性别</th>
                                <th lay-data="{field:'title', width:80, edit: 'text'}">教师职称</th>
                                <th lay-data="{field:'birthday', width:100,sort: true, edit: 'text'}">出生日期</th>
                                <th lay-data="{field:'phone', width:120,sort: true, edit: 'text'}">联系方式</th>
                                <th lay-data="{field:'password',width:100, sort: true, edit: 'text'}">登陆密码</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                    <%--新增教师--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm5" action="/upTeacher"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">教师编号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="tno" required  lay-verify="required" placeholder="请输入编号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">教师姓名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="tname" required  lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
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
                                <label class="layui-form-label">职称</label>
                                <div class="layui-input-block">
                                    <input type="text" name="title" required  lay-verify="required" placeholder="请输入职称" autocomplete="off" class="layui-input">
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
                                    <label class="layui-form-label">出生年月</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" id=Time" name="birthday" placeholder="yyyy-MM-dd"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">教师登陆密码</label>
                                <div class="layui-input-block">
                                    <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit5" class="layui-btn" onclick="setTimeout(upMessage8,'1000');" >确认添加</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset5">重置</button>
                            </div>
                        </form>
                    </div>
                    <%--查找教师--%>
                    <div class="layui-tab-item">

                        <div class="layui-form-item">
                            <label class="layui-form-label">输入教师编号</label>
                            <div class="layui-input-block">
                                <input type="text" name="tno" id="tno" autocomplete="off" placeholder="请输入教师编号" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button  class="layui-btn" lay-submit lay-filter="formDemo10" onclick="findTones();">立即查询</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                            </div>
                        </div>


                        <table id="TT" lay-filter="test11"></table>
                        <script type="text/html" id="barDemo10">
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                        </script>


                    </div>

                </div>
            </div>
        </div>

        <input type="hidden" id="currentlname" name=""/>
        <input type="hidden" id="currentlno" name=""/>
        <input type="hidden" id="currentcname" name=""/>
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

    //作业完成情况及下载学生作业
    function homeworkInformation(obj){
        var lno = document.getElementById('homeworkLno').name;
        var hname = obj.parentNode.parentNode.childNodes[1].id;
        var url = 'homeworkInformation?'+'lno='+lno+'&hname='+hname;
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#homeworkInformationTable'
                ,url: url
                ,toolbar: '#toolbarDemo'
                ,title: '用户数据表'
                ,totalRow: false
                ,cols: [[
                    {type: 'checkbox', fixed: 'left'}
                    ,{field:'state', width:90,title: '提交状态'}
                    ,{field:'hname', width:120,title: '作业'}
                    ,{field:'sno', title:'学号', width:150, sort: true}
                    ,{field:'sname', title:'姓名', width:120}
                    ,{field:'sex', width:80, title: '性别'}
                    ,{field:'cname', width:120, title: '班级'}
                    ,{field:'major', width:120,title: '专业'}
                    ,{field:'lno', width:120,title: '课程'}
                    ,{field:'hscore', width:120,title: '分数'}
                    ,{field:'date', width:120,title: '提交日期'}
                    ,{field:'enteryear', width:120, title: '入学年份'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
                ]]
                ,page: true
            });

            //下载选中的作业
            table.on('toolbar(homeworkInformationTable)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'getCheckData':
                        var data = checkStatus.data;
                        var aaa =JSON.stringify(data[0]);
                        var url = "downloadChosenStudentsHomework?";
                        var len=0;
                        for(var i = 0;i<data.length;i++){
                            var info = JSON.stringify(data[i]).toString();
                            var data2 = eval('(' + info + ')');
                            url=url+'s'+i+'='+data2.sno+'&'+'sn'+i+'='+data2.sname+'&';
                            len++;
                        }
                        url=url+"hname="+data2.hname+'&lno='+document.getElementById('homeworkLno').name+'&len='+len;
                        window.open(url);
                        break;
                    case 'getCheckLength':
                        var data = checkStatus.data;
                        layer.msg('选中了：'+ data.length + ' 个');
                        break;
                    case 'isAll':
                        layer.msg(checkStatus.isAll ? '全选': '未全选')
                        break;
                };
            });
            // 作业打分事件
            table.on('tool(homeworkInformationTable)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'del'){
                    layer.confirm('真的删除行么', function(index){
                        obj.del();
                        layer.close(index);
                    });
                } else if(obj.event === 'score'){
                    layer.prompt({
                        formType: 2
                        ,value: ''+data.sno+data.hname+data.lno
                    }, function(value, index){
                        obj.update({
                            hscore: value
                        });
                        layer.close(index);
                        createXMLHttpRequest();
                        xmlHttp.open("GET", 'updateHomeworkScore?sno='+data.sno+'&lno='+data.lno+'&hname='+data.hname+"&hscore="+value, true); xmlHttp.send(null);
                        layer.msg("打分成功");
                    });
                }
            });


        });

    }

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

    queryTeachersLesson();
    midInformation();
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
        layer.msg('欢迎您，系统管理员!');
    });


    var xmlHttp;
    var type;

    var tempSno;
    var tempSname;

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
        document.getElementById("teachPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("infoPage").style.display="block";
    }
    function mySafePage(){
        document.getElementById("teachPage").style.display="none";
        document.getElementById("safePage").style.display="block";
        document.getElementById("infoPage").style.display="none";
    }
    function  myTeachPage(){
        document.getElementById("infoPage").style.display="none";
        document.getElementById("safePage").style.display="none";
        document.getElementById("teachPage").style.display="block";

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



    // 初始化显示当前已经开的课程信息
    function queryTeachersLesson(){
        var url = "queryNumopenlesson";
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }

    //更新当前已开课程信息
    function updateTeachersLessonInformationList() {

        var node = document.getElementById("openLesson");
        node.parentNode.removeChild(node);

        var lessonList = document.getElementById("teachersLessonList");
        var div = createDiv("openLesson");
        var responseXML = xmlHttp.responseXML;
        for (var i = 0; i < responseXML.getElementsByTagName("lessonlist").length; i++) {
            var Gno   = responseXML.getElementsByTagName("Gno")    [i].firstChild.nodeValue;
            var Lno   = responseXML.getElementsByTagName("Lno")    [i].firstChild.nodeValue;
            var Tno = responseXML.getElementsByTagName("Tno")  [i].firstChild.nodeValue;
            var Cno = responseXML.getElementsByTagName("Cno")  [i].firstChild.nodeValue;
            div.appendChild(createCard(Gno,Lno,Tno,Cno,"lessonInformation(this);"));

            if((i+1)%3==0)
                div.appendChild(createP());

        }
        lessonList.appendChild(div);

        updateLessonListVisibility("teachersLessonList");

    }
    // 课程管理 初始化
    function lessonInformation(obj) {
        var cname = obj.parentNode.parentNode.childNodes[1].id;
        var lname = obj.parentNode.parentNode.id;
        var lno = obj.childNodes[0].nodeValue;

        document.getElementById("currentlname").name=lname;
        document.getElementById("currentcname").name=cname;
        document.getElementById("currentlno").name=lno;


        document.getElementById('homeworkLno').setAttribute("name",lno);
        document.getElementById("lno").setAttribute("value",lno);
        document.getElementById("messageLno").setAttribute("value",document.getElementById("currentlno").name);
        document.getElementById("hidemessageLno").setAttribute("value",document.getElementById("currentlno").name);
        document.getElementById("messageLname").setAttribute("value",document.getElementById("currentlname").name);
        document.getElementById("HomeworkHidenLno").setAttribute("value",document.getElementById("currentlno").name)


        homeworkList(cname,lno);

        var COUREMurl='lesson_student?lno='+lno;
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#mid2'
                ,url: COUREMurl
                ,cols: [[
                    {field:'sno', width:150, title: '学号', sort: true}
                    ,{field:'sname', width:80, title: '姓名'}
                    ,{field:'sex', width:80, title: '性别'}
                    ,{field:'cname', width:120, title: '班级'}
                    ,{field:'major', width:120,title: '专业'}
                    ,{field:'birthday', width:120, title: '出生日期'}
                    ,{field:'enteryear', width:120, title: '入学年份'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:150}
                ]]
                ,page: true
            });
            table.on('tool(mid2)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'remark'){
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    //这里设置评价对象
                    document.getElementById('student').innerHTML='评价对象：'+tempSno+','+tempSname;
                    document.getElementById('normalTeacherRemarkTable').click();
                }else if(obj.event === 'change'){
                    document.getElementById('normalTeacherRemarkTable').click();
                }
            });
        });
        //这里设置任课评价评分星星
        layui.use(['rate'], function() {
            var rate = layui.rate;
            rate.render({
                elem: '#normalscore1'
                , length: 10
                , value: 0 //初始值
                ,text: true
                ,setText: function(value) {
                    this.span.text(value);
                }
                ,choose:function (value) {
                    normalscore1 =value
                }
            });
            rate.render({
                elem: '#normalscore2'
                , length: 10
                , value: 0 //初始值
                ,text: true
                ,setText: function(value) {
                    this.span.text(value);
                }
                ,choose:function (value) {
                    normalscore2=value
                }
            });
            rate.render({
                elem: '#normalscore3'
                , length: 10
                , value: 0 //初始值
                ,text: true
                ,setText: function(value) {
                    this.span.text(value);
                }
                ,choose:function (value) {
                    normalscore3=value
                }
            });
            rate.render({
                elem: '#normalscore4'
                , length: 10
                , value: 0 //初始值
                ,text: true
                ,setText: function(value) {
                    this.span.text(value);
                }
                ,choose:function (value) {
                    normalscore4=value
                }
            });
        });

        //课程学生信息表格
        var STUurl='lesson_student?lno='+lno
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#test'
                ,url: STUurl
                ,cols: [[
                    {field:'sno', width:150, title: '学号', sort: true}
                    ,{field:'sname', width:80, title: '姓名'}
                    ,{field:'sex', width:80, title: '性别'}
                    ,{field:'cname', width:120, title: '班级'}
                    ,{field:'major', width:120,title: '专业'}
                    ,{field:'birthday', width:120, title: '出生日期'}
                    ,{field:'enteryear', width:120, title: '入学年份'}
                ]]
                ,page: true
            });
        });
        //课程通知信息表格
        var COUurl = "queryLessonMessage?lno="+lno;
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#test2'
                ,url: COUurl
                ,cols: [[
                    {field:'time', width:190, title: '发布时间' , sort: true}
                    ,{field:'lno', width:115, title: '课程'}
                    ,{field:'lname', width:200, title: '课程名称'}
                    ,{field:'title', width:335, title: '标题'}
                    ,{field:'detail', width:760, title: '详细信息'}
                    ,{fixed: 'right', title:'删除', toolbar: '#barMessage', width:70}
                ]]
                ,page: true
            });

            table.on('tool(test2)', function(obj){
                var data = obj.data;

                if(obj.event === 'deleteMessage'){
                    layer.confirm('真的删除该通知吗', function(index){
                        obj.del();
                        createXMLHttpRequest();
                        xmlHttp.open("GET", "deleteMessage?lno="+data.lno+"&title="+data.title, true); xmlHttp.send(null);
                        layer.close(index);
                        layer.msg("删除成功");
                    });
                }
                //标注选中样式
                // obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
            });
        });
    }
    function homeworkList(cname,lno) {
        var url = "homeworkList?cname="+cname+"&lno="+lno;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true);
        xmlHttp.send(null);
    }
    function updateHomeworkList() {
        var node = document.getElementById("homework");
        node.parentNode.removeChild(node);
        var lessonList = document.getElementById("homeworkList");
        var div = createDiv("homework");
        var responseXML = xmlHttp.responseXML;
        for (var i = 0; i < responseXML.getElementsByTagName("homeworklist").length; i++) {

            var Hname   = responseXML.getElementsByTagName("Hname")    [i].firstChild.nodeValue;
            var StartDate = responseXML.getElementsByTagName("StartDate")  [i].firstChild.nodeValue;
            var EndDate = responseXML.getElementsByTagName("EndDate")  [i].firstChild.nodeValue;
            var Introduction = responseXML.getElementsByTagName("Introduction")  [i].firstChild.nodeValue;
            div.appendChild(createHomeworkCard(Hname,StartDate,EndDate,Introduction,"homeworkInformation(this);"));
            if((i+1)%3==0)
                div.appendChild(createP());

        }
        lessonList.appendChild(div);
        updateLessonListVisibility("homeworkList");
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


