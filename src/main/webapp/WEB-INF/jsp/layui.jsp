<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>学员综合素质测评系统</title>
    <link rel="stylesheet" href="/layui/css/layui.css">
    <link rel="stylesheet" href="/layui/css/site.css">
    <script src="/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">教师端</div>
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

                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">教学管理</a>
                    <dl class="layui-nav-child" id="functionList">
                        <dd><a href="javascript:;" onclick="queryTeachersLesson();myTeachPage();" id="teachersLessonListSp">我的课程</a></dd>
                        <dd><a href="javascript:;" class="layui-this" onclick="hideOthers(this);myTeachPage();" id="lessonInformationListSp">课程管理</a></dd>
                        <dd><a href="javascript:;" onclick="hideOthers(this);myTeachPage();backToFirst();" id="midInformationListSp">学中评定</a></dd>
                        <dd><a href="javascript:;" onclick="hideOthers(this);myTeachPage();backToFirst();" id="finalInformationListSp">结业评定</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item"><a href="">云市场</a></li>
                <li class="layui-nav-item"><a href="">发布商品</a></li>
            </ul>
        </div>
    </div>

    <div id="infoPage" class="layui-body" style="background-color: rgb(242,242,242);display:none;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend align="center">基本资料</legend>
        </fieldset>
        <form class="layui-form" action="/updateTeacher" method="post" target="teacherInfoFrame">

            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">TID</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.Teacher.getTno()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">姓名</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.Teacher.getTname()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">出生日期</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true" value="${sessionScope.Teacher.getBirthday()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left">职位</label>
                    <input type="text" style="width: 500px"  lay-verify="required" autocomplete="off" class="layui-input" disabled="true"value="${sessionScope.Teacher.getTitle()}">
                </div>
            </div>
            <div class="layui-form-item"align="center" >
                <div class="layui-inline">
                    <label class="layui-form-label" align="left ">联系方式</label>
                    <input type="tel" style="width: 500px" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input" value="${sessionScope.Teacher.getPhone()}">
                </div>
            </div>

            <input type="hidden" name="password" value="${sessionScope.Teacher.getPassword()}"/>
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
        <form class="layui-form" action="/teacherSafe" method="post">
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

    <div id="teachPage" class="layui-body" style="background-color: rgb(242,242,242);">

        <!-- 我的课程 -->
        <div style="display:block;" id="teachersLessonListSpan">
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>我的课程</legend>
            </fieldset>
            <div class="layui-row layui-col-space155" style="background-color: rgb(242,242,242);" id="teachersLessonList">
                <div id="teachersLesson"></div>
            </div>
        </div>
        <!--课程管理-->
        <div style="display:none;" id="lessonInformationListSpan">
            <fieldset id="homeworkLno"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>课程管理</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li>学生信息</li>
                    <li>课程通知</li>
                    <li class="layui-this">作业发布</li>
                    <li>作业回收</li>
                    <li>试题管理</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <%--学生信息--%>
                    <div class="layui-tab-item"><table class="layui-hide" id="test" lay-filter="test"></table></div>
                    <%--课程通知--%>
                    <div class="layui-tab-item">
                        <form class="layui-form layui-form-pane" id="messageForm" action="/upMessage"  method="POST"  target="messageFrame">
                            <div class="layui-form-item">
                                <label class="layui-form-label">标题</label>
                                <div class="layui-input-block">
                                    <input type="text" name="title" id="messageTitle" autocomplete="off" placeholder="请输入标题" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">课程</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="hidemessageLno" name="messageLno" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input" disabled="disabled" />
                                        <input type="hidden" id="messageLno" name="gno" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input" />
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">课程名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="messageLname"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input" disabled="disabled"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">发布时间</label>
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" id="messageTime" name="time" placeholder="yyyy-MM-dd HH:mm:ss"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item layui-form-text">
                                <label class="layui-form-label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;内容</label>
                                <div class="layui-input-block">
                                    <textarea id="messageDetail" name="detail" placeholder="请输入通知内容" class="layui-textarea"></textarea>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button type="submit" id="messageFormSubmit" class="layui-btn" onclick="setTimeout(upMessage,'1000');">立即发布</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="messageFormReset">重置</button>
                            </div>
                        </form>
                        <table class="layui-hide" id="test2" lay-filter="test2"></table>
                        <script type="text/html" id="barMessage">
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="deleteMessage">删除</a>
                        </script>
                    </div>
                    <%--作业发布--%>
                    <div class="layui-tab-item">
                        <form  class="layui-form layui-form-pane" id="formId" action="/testUpload" target="frame1" method="POST" enctype="multipart/form-data">
                            <div class="layui-form-item">
                                <label class="layui-form-label">长输入框</label>
                                <div class="layui-input-block">
                                    <input type="text" name="hname" id="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">短输入框</label>
                                <div class="layui-input-inline">
                                    <input type="text"  id="lno" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input" disabled="disabled" >
                                    <input type="hidden" id="HomeworkHidenLno" name="lno" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input" />
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">起始日期</label>
                                    <div class="layui-input-block">
                                        <input type="text" id="startdate" name="publishDate" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">截止日期</label>
                                    <div class="layui-input-block">
                                        <input type="text" id="enddate" name="endDate" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>

                            <div class="layui-form-item layui-form-text">
                                <label class="layui-form-label">文本域</label>
                                <div class="layui-input-block">
                                    <textarea id="introduction" name="introduction" placeholder="请输入内容" class="layui-textarea"></textarea>
                                </div>
                            </div>

                            <div id ="updiv" class="layui-form-item">
                                <button type="button" class="layui-btn layui-btn-normal" id="test8" >选择文件</button>
                                <%--<input type="file" name="homeworkFile" class="layui-btn-normal">选择文件</input>--%>
                                <button type="button" class="layui-btn" id="uploadButton" onclick="upload();">开始上传</button><br>
                                <iframe name="frame1" frameborder="0" height="40"></iframe>
                            </div>
                        </form>
                    </div>
                    <%--作业回收--%>
                    <div class="layui-tab-item">
                        <div style="display:block;" id="homeworkListSpan">
                            <div class="layui-row layui-col-space15" style="background-color: rgb(242,242,242);" id="homeworkList">
                                <div id="homework"></div>
                            </div>
                        </div>
                        <table class="layui-hide" id="homeworkInformationTable" lay-filter="homeworkInformationTable"></table>
                        <script type="text/html" id="toolbarDemo">
                            <div class="layui-btn-container">
                                <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中学生的作业</button>
                                <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
                                <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
                            </div>
                        </script>
                        <script type="text/html" id="barDemo">
                            <a class="layui-btn layui-btn-xs" lay-event="score">打分</a>
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                        </script>

                    </div>
                    <%--试题管理--%>
                    <div class="layui-tab-item">
                            <div class="layui-collapse" lay-filter="test">
                                <%--选择题--%>
                                <div class="layui-colla-item">
                                    <h2 class="layui-colla-title">选择题<i class="layui-icon layui-colla-icon"></i></h2>
                                    <div class="layui-colla-content layui-show">
                                        <p></p>
                                        <form class="layui-form layui-form-pane" id="addSubjectForm" action="/addSelect"  method="POST"  target="addSubjectFrame">
                                            <div class="layui-form-item">
                                                <label class="layui-form-label">题目</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="stTitle" lay-verify="required" id="subjectTitle" autocomplete="off" placeholder="请输入题目" class="layui-input">
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <label class="layui-form-label">选项A</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="stOptionA" lay-verify="required" id="stOptionA" autocomplete="off" placeholder="请输入内容" class="layui-input">
                                                </div>
                                                <label class="layui-form-label">选项B</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="stOptionb" lay-verify="required" id="stOptionb" autocomplete="off" placeholder="请输入内容" class="layui-input">
                                                </div>
                                                <label class="layui-form-label">选项C</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="stOptionc" lay-verify="required" id="stOptionc" autocomplete="off" placeholder="请输入内容" class="layui-input">
                                                </div>
                                                <label class="layui-form-label">选项D</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="stoptiond" lay-verify="required" id="stoptiond" autocomplete="off" placeholder="请输入内容" class="layui-input">
                                                </div>
                                                <label class="layui-form-label">提示</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="stParse" lay-verify="required" id="stParse" autocomplete="off" placeholder="请输入内容" class="layui-input">
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <div class="layui-inline">
                                                    <label class="layui-form-label">正确选项</label>
                                                    <div class="layui-input-inline">
                                                        <select name="stAnswer" lay-verify="required" lay-search="">
                                                            <option value="">直接选择或搜索选择</option>
                                                            <option value="A">A</option>
                                                            <option value="B">B</option>
                                                            <option value="C">C</option>
                                                            <option value="D">D</option>
                                                        </select><div class="layui-form-select layui-form-selected"><div class="layui-select-title"><input type="text" placeholder="直接选择或搜索选择" value="" class="layui-input"><i class="layui-edge"></i></div><dl class="layui-anim layui-anim-upbit" style=""><dd lay-value="" class="layui-select-tips layui-this" style="">直接选择或搜索选择</dd><dd lay-value="1" class="">layer</dd><dd lay-value="2" class="">form</dd><dd lay-value="3" class="">layim</dd><dd lay-value="4" class="">element</dd><dd lay-value="5" class="">laytpl</dd><dd lay-value="6" class="">upload</dd><dd lay-value="7" class="">laydate</dd><dd lay-value="8" class="">laypage</dd><dd lay-value="9" class="">flow</dd><dd lay-value="10" class="">util</dd><dd lay-value="11" class="">code</dd><dd lay-value="12" class="">tree</dd><dd lay-value="13" class="">layedit</dd><dd lay-value="14" class="">nav</dd><dd lay-value="15" class="">tab</dd><dd lay-value="16" class="">table</dd><dd lay-value="17" class="">select</dd><dd lay-value="18" class="">checkbox</dd><dd lay-value="19" class="">switch</dd><dd lay-value="20" class="">radio</dd></dl></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <button class="layui-btn" id="subjectFormSubmit"  type="submit" lay-submit="" lay-filter="demo1" onclick="setTimeout(upMessage,'1000');">立即发布</button>
                                                <button type="reset" class="layui-btn layui-btn-primary" >重置</button>
                                            </div>
                                        </form>
                                        <table class="layui-hide" id="mid41" lay-filter="mid41"></table>
                                        <script type="text/html" id="barSelect">
                                            <%--<a class="layui-btn layui-btn-xs" lay-event="remark" id="remarkButton">评价</a>--%>
                                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="deleteSelect">删除</a>
                                        </script>
                                    </div>
                                </div>
                                <%--判断题--%>
                                <div class="layui-colla-item">
                                    <h2 class="layui-colla-title">判断题<i class="layui-icon layui-colla-icon"></i></h2>
                                    <div class="layui-colla-content">
                                        <p></p>
                                        <form class="layui-form layui-form-pane" id="addJudgeForm" action="/addJudge"  method="POST"  target="addSubjectFrame">
                                            <div class="layui-form-item">
                                                <label class="layui-form-label">题目</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="stcontent" lay-verify="required" id="judgeTitle" autocomplete="off" placeholder="请输入题目" class="layui-input">
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <label class="layui-form-label">提示</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="stparse" lay-verify="required"  autocomplete="off" placeholder="请输入内容" class="layui-input">
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <div class="layui-inline">
                                                    <label class="layui-form-label">正确选项</label>
                                                    <div class="layui-input-inline">
                                                        <select name="stanswer" lay-verify="required" lay-search="">
                                                            <option value="">直接选择或搜索选择</option>
                                                            <option value="0">√</option>
                                                            <option value="1">×</option>

                                                        </select><div class="layui-form-select layui-form-selected"><div class="layui-select-title"><input type="text" placeholder="直接选择或搜索选择" value="" class="layui-input"><i class="layui-edge"></i></div><dl class="layui-anim layui-anim-upbit" style=""><dd lay-value="" class="layui-select-tips layui-this" style="">直接选择或搜索选择</dd><dd lay-value="1" class="">layer</dd><dd lay-value="2" class="">form</dd><dd lay-value="3" class="">layim</dd><dd lay-value="4" class="">element</dd><dd lay-value="5" class="">laytpl</dd><dd lay-value="6" class="">upload</dd><dd lay-value="7" class="">laydate</dd><dd lay-value="8" class="">laypage</dd><dd lay-value="9" class="">flow</dd><dd lay-value="10" class="">util</dd><dd lay-value="11" class="">code</dd><dd lay-value="12" class="">tree</dd><dd lay-value="13" class="">layedit</dd><dd lay-value="14" class="">nav</dd><dd lay-value="15" class="">tab</dd><dd lay-value="16" class="">table</dd><dd lay-value="17" class="">select</dd><dd lay-value="18" class="">checkbox</dd><dd lay-value="19" class="">switch</dd><dd lay-value="20" class="">radio</dd></dl></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <button class="layui-btn" id="judgeFormSubmit"  type="submit" lay-submit="" lay-filter="demo1" onclick="setTimeout(upMessage,'1000');">立即发布</button>
                                                <button type="reset" class="layui-btn layui-btn-primary" >重置</button>
                                            </div>
                                        </form>
                                        <table class="layui-hide" id="mid42" lay-filter="mid42"></table>
                                        <script type="text/html" id="barJudge">
                                            <%--<a class="layui-btn layui-btn-xs" lay-event="remark" id="remarkButton">评价</a>--%>
                                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="deleteJudge">删除</a>
                                        </script>

                                    </div>
                                </div>
                                <%--简答题--%>
                                <div class="layui-colla-item">
                                    <h2 class="layui-colla-title">简答题<i class="layui-icon layui-colla-icon"></i></h2>
                                    <div class="layui-colla-content">
                                        <p></p>
                                        <form class="layui-form layui-form-pane" id="addProjectForm" action="/addProject"  method="POST"  target="addSubjectFrame">
                                            <div class="layui-form-item">
                                                <label class="layui-form-label">题目</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="stcontent" lay-verify="required" autocomplete="off" placeholder="请输入题目" class="layui-input">
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <label class="layui-form-label">提示</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="stparse" lay-verify="required"  autocomplete="off" placeholder="请输入内容" class="layui-input">
                                                </div>
                                            </div>

                                            <div class="layui-form-item">
                                                <button class="layui-btn" id="projectFormSubmit"  type="submit" lay-submit="" lay-filter="demo1" onclick="setTimeout(upMessage,'1000');">立即发布</button>
                                                <button type="reset" class="layui-btn layui-btn-primary" >重置</button>
                                            </div>
                                        </form>
                                        <table class="layui-hide" id="mid43" lay-filter="mid43"></table>
                                        <script type="text/html" id="barProject">
                                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="deleteProject">删除</a>
                                        </script>
                                    </div>
                                </div>
                            </div>

                        </div>
                </div>
            </div>
        </div>
        <!--学中评定-->
        <div style="display:none;" id="midInformationListSpan">
            <fieldset id="midManagement"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>学中评定管理</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="headTeacher">班主任评定</li>
                    <li id="normalTeacher">任课评定</li>
                    <li id="scoreRemark">学中测评打分</li>
                    <li id="headTeacherRemarkTable" style="display:none;">班主任评定表</li>
                    <li id="normalTeacherRemarkTable" style="display:none;">任课评定表</li>
                    <li id="scoreRemarkTable" style="display:none;">学中测评评分表</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <div class="layui-tab-item"><table class="layui-hide" id="mid1" lay-filter="mid1"></table></div>
                    <div class="layui-tab-item"><table class="layui-hide" id="mid2" lay-filter="mid2"></table>
                        <script type="text/html" id="barOP">
                            <a class="layui-btn layui-btn-xs" lay-event="remark" id="remarkButton">评价</a>
                            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="change" id="changeButton">修改</a>
                        </script>
                    </div>
                    <div class="layui-tab-item"><table class="layui-hide" id="mid3" lay-filter="mid3"></table>
                        <script type="text/html" id="remarkOP">
                            <a class="layui-btn layui-btn-xs" lay-event="remark" id="ScoreButton">评分</a>
                        </script>
                    </div>
                    <div class="layui-tab-item" id="headTeacherRemarkItem">
                        <%--<form class="layui-form" action="/teacherSafe" method="post">--%>
                        <table class="layui-table">
                            <colgroup>
                                <col width="350">
                                <col width="320">
                                <col>
                            </colgroup>
                            <thead>
                            <th colspan="2" id="person" style="text-align:center;"></th>
                            <th id="headteachername" style="text-align:center;"></th>
                            <tr>
                                <th style="text-align:center;">题目</th>
                                <th style="text-align:center;">评分</th>
                                <th style="text-align:center;">评论</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>有正确的是非观念,对不道德的事能够进行批判。</td>
                                <td>
                                    <div id="score1"></div>
                                </td>
                                <td>
                                    <input type="text" id="remark1" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>能够严格遵守国家的法律,能积极参与公共事务。</td>
                                <td>
                                    <div id="score2"></div>
                                </td>
                                <td>
                                    <input type="text" id="remark2" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>能够自主地学习,遇到困难肯钻研。</td>
                                <td>
                                    <div id="score3"></div>
                                </td>
                                <td>
                                    <input type="text" id="remark3" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>与他人交流能力强,并能与他人合作。</td>
                                <td>
                                    <div id="score4"></div>
                                </td>
                                <td>
                                    <input type="text" id="remark4" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>审美能力强,角度独到。</td>
                                <td>
                                    <div id="score5"></div>
                                </td>
                                <td>
                                    <input type="text" id="remark5" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>爱好广泛,有健康的生活规律。</td>
                                <td>
                                    <div id="score6"></div>
                                </td>
                                <td>
                                    <input type="text" id="remark6" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <div class="layui-form-item layui-form-text">
                                    <th colspan="2" style="text-align:center;">评语:</th>
                                    <div class="layui-input-block">
                                        <th><textarea id="holyremark" placeholder="请在此输入对该学生总体评价" class="layui-textarea"></textarea></th>
                                    </div>
                                </div>
                            </tr>
                            </tbody>
                        </table>
                        <div class="layui-form-item" align="center">
                            <button class="layui-btn"  lay-filter="demo1" onclick="submitHeadRemark();">提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary" onclick="reset();">重置</button>
                        </div>
                    </div>
                    <div class="layui-tab-item" id="normalTeacherRemarkItem">
                        <table class="layui-table">
                            <colgroup>
                                <col width="300">
                                <col width="350">
                                <col>
                            </colgroup>
                            <thead>
                            <th colspan="2" id="student" style="text-align:center;"></th>
                            <th  id="normalteachername" style="text-align:center;"></th>
                            <tr>
                                <th style="text-align:center;">项目</th>
                                <th style="text-align:center;">评分</th>
                                <th style="text-align:center;">评论</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>听课情况</td>
                                <td>
                                    <div id="normalscore1"></div>
                                </td>
                                <td>
                                    <input type="text" id="normalremark1" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>发言情况</td>
                                <td>
                                    <div id="normalscore2"></div>
                                </td>
                                <td>
                                    <input type="text" id="normalremark2" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>合作学习情况</td>
                                <td>
                                    <div id="normalscore3"></div>
                                </td>
                                <td>
                                    <input type="text" id="normalremark3" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>课堂作业情况</td>
                                <td>
                                    <div id="normalscore4"></div>
                                </td>
                                <td>
                                    <input type="text" id="normalremark4" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <div class="layui-form-item layui-form-text">
                                    <th colspan="2" style="text-align:center;">评语:</th>
                                    <div class="layui-input-block">
                                        <th><textarea id="normalremark" placeholder="请在此输入对该学生总体评价" class="layui-textarea"></textarea></th>
                                    </div>
                                </div>
                            </tr>

                            </tbody>
                        </table>
                        <div class="layui-form-item" align="center">
                            <button class="layui-btn" lay-submit="" lay-filter="demo1" onclick="submitNormalRemark();">提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary" onclick="reset();">重置</button>
                        </div>
                    </div>
                    <div class="layui-tab-item">
                        <blockquote class="layui-elem-quote" id="midstudentinfo"></blockquote>
                        <table class="layui-table" id="mid4" lay-filter="mid4"></table>
                        <button class="layui-btn"  type="submit" lay-submit="" lay-filter="demo1" onclick="submitTotalScore();">确认并返回</button>
                    </div>
                </div>
            </div>
        </div>
        <!--结业评定-->
        <div style="display:none;" id="finalInformationListSpan">
            <fieldset id="finalManagement"  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>结业评定管理</legend>
            </fieldset>
            <div class="layui-tab layui-tab-card" style="height:100% ">
                <ul class="layui-tab-title">
                    <li id="headTeacher2">班主任综合评定</li>
                    <li id="normalTeacher2">任课综合评定</li>
                    <li id="finalScoreRemark">专业知识测评打分</li>
                    <li id="headTeacherRemarkTable2" style="display:none;">班主任综合评定表</li>
                    <li id="normalTeacherRemarkTable2" style="display:none;">任课综合评定表</li>
                    <li id="finalScoreRemarkTable" style="display:none;">结业评测评分</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <div class="layui-tab-item"><table class="layui-hide" id="final1" lay-filter="final1"></table> </div>
                    <div class="layui-tab-item"><table class="layui-hide" id="final2" lay-filter="final2"></table> </div>
                    <div class="layui-tab-item"><table class="layui-hide" id="final3" lay-filter="final3"></table> </div>
                    <div class="layui-tab-item" id="headTeacherFinalRemarkItem">
                        <table class="layui-table">
                            <colgroup>
                                <col width="350">
                                <col width="320">
                                <col>
                            </colgroup>
                            <th colspan="2" id="personfinal" style="text-align:center;"></th>
                            <th colspan="2" id="headfinal" style="text-align:center;"></th>
                            <%--<thead>--%>

                            <tr>
                                <th style="text-align:center;">评价项目</th>
                                <th style="text-align:center;">评价标准</th>
                                <th style="text-align:center;">评分</th>
                                <th style="text-align:center;">评论</th>
                            </tr>
                            <%--</thead>--%>
                            <tbody>
                            <tr>
                                <td>学习技能</td>
                                <td>①会处理信息、分析信息<br>②掌握知识点、并能描述<br>③能综合思考问题</td>
                                <td>
                                    <div id="finalscore1"></div>
                                </td>
                                <td>
                                    <input type="text" id="finalremark1" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>情感态度</td>
                                <td>①积极参与活动，态度端正<br>②不怕困难和辛苦<br>③发表思想认识</td>
                                <td>
                                    <div id="finalscore2"></div>
                                </td>
                                <td>
                                    <input type="text" id="finalremark2" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>合作交流</td>
                                <td>①主动和同学配合<br>②认真倾听同学观点和意见<br>③服从小组长指挥</td>
                                <td>
                                    <div id="finalscore3"></div>
                                </td>
                                <td>
                                    <input type="text" id="finalremark3" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>实践活动</td>
                                <td>①积极动脑、动手、动口<br>②关注社会、关注生活意识<br>③会与别人交流</td>
                                <td>
                                    <div id="finalscore4"></div>
                                </td>
                                <td>
                                    <input type="text" id="finalremark4" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <div class="layui-form-item layui-form-text">
                                    <th colspan="2" style="text-align:center;">评语:</th>
                                    <div class="layui-input-block">
                                        <th><textarea id="finalholyremark" placeholder="请在此输入对该学生总体评价" class="layui-textarea"></textarea></th>
                                    </div>
                                </div>
                            </tr>

                            </tbody>
                        </table>
                        <div class="layui-form-item" align="center">
                            <button class="layui-btn" lay-submit="" lay-filter="demo1" onclick="submitHeadRemark();">提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary" onclick="reset();">重置</button>
                        </div>
                    </div>
                    <div class="layui-tab-item" id="normalTeacherFinalRemarkItem">
                        <table class="layui-table">
                            <colgroup>
                                <col width="300">
                                <col width="350">
                                <col>
                            </colgroup>
                            <thead>
                            <th colspan="2" id="studentfinal" style="text-align:center;"></th>
                            <th  id="normalfinal" style="text-align:center;"></th>
                            <tr>
                                <th style="text-align:center;">项目</th>
                                <th style="text-align:center;">评分</th>
                                <th style="text-align:center;">评论</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>听课情况</td>
                                <td>
                                    <div id="finalnormalscore1"></div>
                                </td>
                                <td>
                                    <input type="text" id="finalnormalremark1" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>发言情况</td>
                                <td>
                                    <div id="finalnormalscore2"></div>
                                </td>
                                <td>
                                    <input type="text" id="finalnormalremark2" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>合作学习情况</td>
                                <td>
                                    <div id="finalnormalscore3"></div>
                                </td>
                                <td>
                                    <input type="text" id="finalnormalremark3" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <td>课堂作业情况</td>
                                <td>
                                    <div id="finalnormalscore4"></div>
                                </td>
                                <td>
                                    <input type="text" id="finalnormalremark4" lay-verify="title" autocomplete="off" placeholder="请输入评论可为空" class="layui-input">
                                </td>
                            </tr>
                            <tr>
                                <div class="layui-form-item layui-form-text">
                                    <th colspan="2" style="text-align:center;">评语:</th>
                                    <div class="layui-input-block">
                                        <th><textarea id="finalnormalremark" placeholder="请在此输入对该学生总体评价" class="layui-textarea"></textarea></th>
                                    </div>
                                </div>
                            </tr>
                            </tbody>
                        </table>
                        <div class="layui-form-item" align="center">
                            <button class="layui-btn" lay-submit="" lay-filter="demo1" onclick="submitNormalRemark();">提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary" onclick="reset();">重置</button>
                        </div>
                    </div>
                    <div class="layui-tab-item">
                        <blockquote class="layui-elem-quote" id="finalstudentinfo"></blockquote>
                        <table class="layui-hide" id="final4" lay-filter="final4"></table>
                        <button class="layui-btn"  type="submit" lay-submit="" lay-filter="demo1" onclick="submitTotalScore();">确认并返回</button>
                    </div>
                </div>
            </div>
        </div>


        <input type="hidden" id="currentlname" name=""/>
        <input type="hidden" id="currentlno" name=""/>
        <input type="hidden" id="currentcname" name=""/>

        <iframe  id="messageFrame" name="messageFrame" style="display: none;width:0; height:0" name="submitFrame"  src="about:blank"></iframe>
        <iframe  id="addSubjectFrame" name="addSubjectFrame" style="display: none;width:0; height:0" name="submitFrame"  src="about:blank"></iframe>
        <iframe  id="teacherInfoFrame" name="teacherInfoFrame" style="display: none;width:0; height:0" name="submitFrame"  src="about:blank"></iframe>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script src="/layui/layui.js"></script>
<script ></script>

<script>

    //班主任评分
    var headscore1;
    var headscore2;
    var headscore3;
    var headscore4;
    var headscore5;
    var headscore6;
    //任课评分
    var normalscore1;
    var normalscore2;
    var normalscore3;
    var normalscore4;

    //班主任提交评价
    function submitHeadRemark(){
        if(type == 0)
            var scoresum=Number(headscore1)+Number(headscore2)+Number(headscore3)+Number(headscore4)+Number(headscore5)+Number(headscore6);
        else
            var scoresum=Number(headscore1)+Number(headscore2)+Number(headscore3)+Number(headscore4);
        var remark1=document.getElementById("remark1").value;
        var remark2=document.getElementById("remark2").value;
        var remark3=document.getElementById("remark3").value;
        var remark4=document.getElementById("remark4").value;
        var remark5=document.getElementById("remark5").value;
        var remark6=document.getElementById("remark6").value;
        var holyremark=document.getElementById("holyremark").value;
        var tno = '${sessionScope.Tno}';
        var url = "submitHeadRemark?sno="+tempSno+"&tno="+tno+"&scoresum="+scoresum+"&holyremark="+holyremark+
            "&remark1="+remark1+"&remark2="+remark2+"&remark3="+remark3+"&remark4="+remark4+"&remark5="+remark5+"&remark6="+remark6+"&type="+type;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
        //window.location.reload();
    }
    //任课教师提交评价
    function submitNormalRemark(){
        var scoresum=Number(normalscore1)+Number(normalscore2)+Number(normalscore3)+Number(normalscore4);
        var remark1=document.getElementById("normalremark1").value;
        var remark2=document.getElementById("normalremark2").value;
        var remark3=document.getElementById("normalremark3").value;
        var remark4=document.getElementById("normalremark4").value;
        var normalremark=document.getElementById("normalremark").value;
        var tno = '${sessionScope.Tno}';
        var url = "submitNormalRemark?sno="+tempSno+"&tno="+tno+"&scoresum="+scoresum+"&normalremark="+normalremark+
            "&remark1="+remark1+"&remark2="+remark2+"&remark3="+remark3+"&remark4="+remark4+"&type="+type;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }

    //班主任评价成功
    function headRemarkSuccess(){
        // document.getElementById("remarkButton").innerHTML="已评价";
        // document.getElementById("remarkButton").disabled=true;
        layui.use(['layer'], function(){
            layer = layui.layer //弹层
            layer.msg('评价成功!');
        });
        document.getElementById("headTeacher").click();
        document.getElementById("headTeacher2").click();
    }

    //任课评价成功
    function normalRemarkSuccess(){
        // document.getElementById("remarkButton").innerHTML="已评价";
        // document.getElementById("remarkButton").disabled=true;
        layui.use(['layer'], function(){
            layer = layui.layer //弹层
            layer.msg('评价成功!');
        });
        document.getElementById("normalTeacher").click();
        document.getElementById("normalTeacher2").click();
    }

    // 班主任是否已经评价过
    function headIsRemarked(){
        var url = "headIsRemarked?sno="+tempSno+"&type="+type;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    // 课任教师是否已经评价过
    function normalIsRemarked(){
        var url = "normalIsRemarked?sno="+tempSno+"&type="+type;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }

    function getHeadIsRemark(){
        isHeadRemark = xmlHttp.responseXML.getElementsByTagName("flag")[0].firstChild.nodeValue;
        if("headisremark" == isHeadRemark || "normalisremark" == isNormalRemark){
            layui.use(['layer'], function(){
                layer = layui.layer //弹层
                layer.msg('已评价，如需修改请点击修改');
                //document.getElementById("remarkButton").disabled=true;
            });
        } else{
            reset();
            //这里设置班主任评价学中对象和评价人
            document.getElementById('person').innerHTML='评价对象：'+tempSno+','+tempSname;
            document.getElementById('headteachername').innerHTML='评价人：'+'${Teacher.tname}';
            document.getElementById('headTeacherRemarkTable').click();
            //这里设置班主任评价结业对象和评价人
            document.getElementById('personfinal').innerHTML='评价对象：'+tempSno+','+tempSname;
            document.getElementById('headfinal').innerHTML='评价人：'+'${Teacher.tname}';
            document.getElementById('headTeacherRemarkTable2').click();
        }
    }

    function getNormalIsRemark(){
        isNormalRemark = xmlHttp.responseXML.getElementsByTagName("flag2")[0].firstChild.nodeValue;
        if("headisremark" == isHeadRemark || "normalisremark" == isNormalRemark){
            layui.use(['layer'], function(){
                layer = layui.layer //弹层
                layer.msg('已评价，如需修改请点击修改');
                //document.getElementById("remarkButton").disabled=true;
            });
        } else{
            reset();
            //这里设置任课学中评价对象和评价人
            document.getElementById('student').innerHTML='评价对象：'+tempSno+','+tempSname;
            document.getElementById('normalteachername').innerHTML='评价人：'+'${Teacher.tname}';
            document.getElementById('normalTeacherRemarkTable').click();
            //这里设置任课结业评价对象和评价人
            document.getElementById('studentfinal').innerHTML='评价对象：'+tempSno+','+tempSname;
            document.getElementById('normalfinal').innerHTML='评价人：'+'${Teacher.tname}';
            document.getElementById('normalTeacherRemarkTable2').click();
        }
    }

    function submitProjectScore(){
        var url = "submit_project_score?sno="+tempSno+"&gno="+lno+"&type="+type+"&pid="+pid+"&project_score="+project_score;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }

    function submitTotalScore(){
        var url = "submit_total_project_score?sno="+tempSno+"&gno="+lno+"&type="+type;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }

    function updateProjectScoreSuccess(){
        layui.use(['layer'], function(){
            layer = layui.layer //弹层
            layer.msg('分数修改成功！');
        });
    }

    function updateTotalProjectScoreSuccess(){
        layui.use(['layer'], function(){
            layer = layui.layer //弹层
            layer.msg('提交成功！');
        });
        document.getElementById('scoreRemark').click();
        document.getElementById('finalScoreRemark').click();
    }

    function backToFirst(){
        document.getElementById('headTeacher').click();
        document.getElementById('headTeacher2').click();
    }

    function reset(){
        document.getElementById('normalTeacherRemarkItem').innerHTML = "";
        document.getElementById('headTeacherRemarkItem').innerHTML = "";
        document.getElementById('headTeacherFinalRemarkItem').innerHTML = "";
        document.getElementById('normalTeacherFinalRemarkItem').innerHTML = "";
        document.getElementById('headTeacherRemarkItem').innerHTML = "<table class=\"layui-table\">\n" +
            "                            <colgroup>\n" +
            "                                <col width=\"350\">\n" +
            "                                <col width=\"320\">\n" +
            "                                <col>\n" +
            "                            </colgroup>\n" +
            "                            <thead>\n" +
            "                            <th colspan=\"2\" id=\"person\" style=\"text-align:center;\"></th>\n" +
            "                            <th  id=\"headteachername\" style=\"text-align:center;\"></th>\n" +
            "                            <tr>\n" +
            "                                <th style=\"text-align:center;\">题目</th>\n" +
            "                                <th style=\"text-align:center;\">评分</th>\n" +
            "                                <th style=\"text-align:center;\">评论</th>\n" +
            "                            </tr>\n" +
            "                            </thead>\n" +
            "                            <tbody>\n" +
            "                            <tr>\n" +
            "                                <td>有正确的是非观念,对不道德的事能够进行批判。</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"score1\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"remark1\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>能够严格遵守国家的法律,能积极参与公共事务。</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"score2\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"remark2\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>能够自主地学习,遇到困难肯钻研。</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"score3\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"remark3\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>与他人交流能力强,并能与他人合作。</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"score4\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"remark4\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>审美能力强,角度独到。</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"score5\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"remark5\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>爱好广泛,有健康的生活规律。</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"score6\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"remark6\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <div class=\"layui-form-item layui-form-text\">\n" +
            "                                    <th colspan=\"2\" style=\"text-align:center;\">评语:</th>\n" +
            "                                    <div class=\"layui-input-block\">\n" +
            "                                        <th><textarea id=\"holyremark\" placeholder=\"请在此输入对该学生总体评价\" class=\"layui-textarea\"></textarea></th>\n" +
            "                                    </div>\n" +
            "                                </div>\n" +
            "                            </tr>\n" +
            "\n" +
            "                            </tbody>\n" +
            "                        </table>\n" +
            "                        <div class=\"layui-form-item\" align=\"center\">\n" +
            "                            <button class=\"layui-btn\"  lay-filter=\"demo1\" onclick=\"submitHeadRemark();\">提交</button>\n" +
            "                            <button type=\"reset\" class=\"layui-btn layui-btn-primary\" onclick=\"reset();\">重置</button>\n" +
            "                        </div>"
        document.getElementById('normalTeacherRemarkItem').innerHTML = "<table class=\"layui-table\">\n" +
            "                            <colgroup>\n" +
            "                                <col width=\"300\">\n" +
            "                                <col width=\"350\">\n" +
            "                                <col>\n" +
            "                            </colgroup>\n" +
            "                            <thead>\n" +
            "                            <th colspan=\"2\" id=\"student\" style=\"text-align:center;\"></th>\n" +
            "                            <th  id=\"normalteachername\" style=\"text-align:center;\"></th>\n" +
            "                            <tr>\n" +
            "                                <th style=\"text-align:center;\">项目</th>\n" +
            "                                <th style=\"text-align:center;\">评分</th>\n" +
            "                                <th style=\"text-align:center;\">评论</th>\n" +
            "                            </tr>\n" +
            "                            </thead>\n" +
            "                            <tbody>\n" +
            "                            <tr>\n" +
            "                                <td>听课情况</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"normalscore1\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"normalremark1\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>发言情况</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"normalscore2\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"normalremark2\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>合作学习情况</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"normalscore3\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"normalremark3\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>课堂作业情况</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"normalscore4\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"normalremark4\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <div class=\"layui-form-item layui-form-text\">\n" +
            "                                    <th colspan=\"2\" style=\"text-align:center;\">评语:</th>\n" +
            "                                    <div class=\"layui-input-block\">\n" +
            "                                        <th><textarea id=\"normalremark\" placeholder=\"请在此输入对该学生总体评价\" class=\"layui-textarea\"></textarea></th>\n" +
            "                                    </div>\n" +
            "                                </div>\n" +
            "                            </tr>\n" +
            "\n" +
            "                            </tbody>\n" +
            "                        </table>\n" +
            "                        <div class=\"layui-form-item\" align=\"center\">\n" +
            "                            <button class=\"layui-btn\" lay-submit=\"\" lay-filter=\"demo1\" onclick=\"submitNormalRemark();\">提交</button>\n" +
            "                            <button type=\"reset\" class=\"layui-btn layui-btn-primary\" onclick=\"reset();\">重置</button>\n" +
            "                        </div>";
        document.getElementById('headTeacherFinalRemarkItem').innerHTML = "<table class=\"layui-table\">\n" +
            "                            <colgroup>\n" +
            "                                <col width=\"350\">\n" +
            "                                <col width=\"320\">\n" +
            "                                <col>\n" +
            "                            </colgroup>\n" +
            "                            <th colspan=\"2\" id=\"personfinal\" style=\"text-align:center;\"></th>\n" +
            "                            <th colspan=\"2\" id=\"headfinal\" style=\"text-align:center;\"></th>\n" +
            "                            <%--<thead>--%>\n" +
            "\n" +
            "                            <tr>\n" +
            "                                <th style=\"text-align:center;\">评价项目</th>\n" +
            "                                <th style=\"text-align:center;\">评价标准</th>\n" +
            "                                <th style=\"text-align:center;\">评分</th>\n" +
            "                                <th style=\"text-align:center;\">评论</th>\n" +
            "                            </tr>\n" +
            "                            <%--</thead>--%>\n" +
            "                            <tbody>\n" +
            "                            <tr>\n" +
            "                                <td>学习技能</td>\n" +
            "                                <td>①会处理信息、分析信息<br>②掌握知识点、并能描述<br>③能综合思考问题</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"finalscore1\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"finalremark1\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>情感态度</td>\n" +
            "                                <td>①积极参与活动，态度端正<br>②不怕困难和辛苦<br>③发表思想认识</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"finalscore2\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"finalremark2\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>合作交流</td>\n" +
            "                                <td>①主动和同学配合<br>②认真倾听同学观点和意见<br>③服从小组长指挥</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"finalscore3\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"finalremark3\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>实践活动</td>\n" +
            "                                <td>①积极动脑、动手、动口<br>②关注社会、关注生活意识<br>③会与别人交流</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"finalscore4\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"finalremark4\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <div class=\"layui-form-item layui-form-text\">\n" +
            "                                    <th colspan=\"2\" style=\"text-align:center;\">评语:</th>\n" +
            "                                    <div class=\"layui-input-block\">\n" +
            "                                        <th><textarea id=\"finalholyremark\" placeholder=\"请在此输入对该学生总体评价\" class=\"layui-textarea\"></textarea></th>\n" +
            "                                    </div>\n" +
            "                                </div>\n" +
            "                            </tr>\n" +
            "\n" +
            "                            </tbody>\n" +
            "                        </table>\n" +
            "                        <div class=\"layui-form-item\" align=\"center\">\n" +
            "                            <button class=\"layui-btn\" lay-submit=\"\" lay-filter=\"demo1\" onclick=\"submitHeadRemark();\">提交</button>\n" +
            "                            <button type=\"reset\" class=\"layui-btn layui-btn-primary\" onclick=\"reset();\">重置</button>\n" +
            "                        </div>";
        document.getElementById('normalTeacherFinalRemarkItem').innerHTML = "<table class=\"layui-table\">\n" +
            "                            <colgroup>\n" +
            "                                <col width=\"300\">\n" +
            "                                <col width=\"350\">\n" +
            "                                <col>\n" +
            "                            </colgroup>\n" +
            "                            <thead>\n" +
            "                            <th colspan=\"2\" id=\"studentfinal\" style=\"text-align:center;\"></th>\n" +
            "                            <th  id=\"normalfinal\" style=\"text-align:center;\"></th>\n" +
            "                            <tr>\n" +
            "                                <th style=\"text-align:center;\">项目</th>\n" +
            "                                <th style=\"text-align:center;\">评分</th>\n" +
            "                                <th style=\"text-align:center;\">评论</th>\n" +
            "                            </tr>\n" +
            "                            </thead>\n" +
            "                            <tbody>\n" +
            "                            <tr>\n" +
            "                                <td>听课情况</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"finalnormalscore1\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"finalnormalremark1\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>发言情况</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"finalnormalscore2\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"finalnormalremark2\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>合作学习情况</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"finalnormalscore3\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"finalnormalremark3\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td>课堂作业情况</td>\n" +
            "                                <td>\n" +
            "                                    <div id=\"finalnormalscore4\"></div>\n" +
            "                                </td>\n" +
            "                                <td>\n" +
            "                                    <input type=\"text\" id=\"finalnormalremark4\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"请输入评论可为空\" class=\"layui-input\">\n" +
            "                                </td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <div class=\"layui-form-item layui-form-text\">\n" +
            "                                    <th colspan=\"2\" style=\"text-align:center;\">评语:</th>\n" +
            "                                    <div class=\"layui-input-block\">\n" +
            "                                        <th><textarea id=\"finalnormalremark\" placeholder=\"请在此输入对该学生总体评价\" class=\"layui-textarea\"></textarea></th>\n" +
            "                                    </div>\n" +
            "                                </div>\n" +
            "                            </tr>\n" +
            "                            </tbody>\n" +
            "                        </table>\n" +
            "                        <div class=\"layui-form-item\" align=\"center\">\n" +
            "                            <button class=\"layui-btn\" lay-submit=\"\" lay-filter=\"demo1\" onclick=\"submitNormalRemark();\">提交</button>\n" +
            "                            <button type=\"reset\" class=\"layui-btn layui-btn-primary\" onclick=\"reset();\">重置</button>\n" +
            "                        </div>";
        test();
    }
    function test(){
        //这里设置学中任课评价评分星星
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
        //这里设置学中结业评价评分星星
        layui.use(['rate'], function() {
            var rate = layui.rate;
            rate.render({
                elem: '#finalnormalscore1'
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
                elem: '#finalnormalscore2'
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
                elem: '#finalnormalscore3'
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
                elem: '#finalnormalscore4'
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
        //这里设置学中班主任评分星星
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
        //这里设置结业班主任评分星星
        layui.use(['rate'], function() {
            var rate = layui.rate;
            rate.render({
                elem: '#finalscore1'
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
                elem: '#finalscore2'
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
                elem: '#finalscore3'
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
                elem: '#finalscore4'
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
        });
        //这里设置班主任评价学中对象和评价人
        document.getElementById('person').innerHTML='评价对象：'+tempSno+','+tempSname;
        document.getElementById('headteachername').innerHTML='评价人：'+'${Teacher.tname}';
        //这里设置班主任评价结业对象和评价人
        document.getElementById('personfinal').innerHTML='评价对象：'+tempSno+','+tempSname;
        document.getElementById('headfinal').innerHTML='评价人：'+'${Teacher.tname}';
        //这里设置任课学中评价对象和评价人
        document.getElementById('student').innerHTML='评价对象：'+tempSno+','+tempSname;
        document.getElementById('normalteachername').innerHTML='评价人：'+'${Teacher.tname}';
        //这里设置任课结业评价对象和评价人
        document.getElementById('studentfinal').innerHTML='评价对象：'+tempSno+','+tempSname;
        document.getElementById('normalfinal').innerHTML='评价人：'+'${Teacher.tname}';
    }
    // ----------------------------------------
    // ----------------------------------------
    // ----------------------------------------
    // ----------------------------------------
    // ----------------------------------------
    queryTeachersLesson();
    midInformation();
    document.getElementById("lessonInformationListSp").click();
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
        layer.msg('Hello World!');
    });

    var xmlHttp;
    var type;//学中还是结业
    var lno;
    var project_score;
    var pid;

    var tempSno;
    var tempSname;

    var isHeadRemark;
    var isNormalRemark;

    function upMessage() {
        document.getElementById("messageForm").reset();
        layer.msg('发布成功');
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
        if(xmlHttp.readyState == 4){
            if(xmlHttp.status == 200){
                if(xmlHttp.responseXML.getElementsByTagName("status")[0].firstChild.nodeValue
                    == "1"){
                    eval(xmlHttp.responseXML.getElementsByTagName("func")[0].firstChild.nodeValue);
                }else{
                    layui.use(['layer'], function(){
                        layer = layui.layer //弹层
                        layer.msg('操作失败');
                    });
                    eval(xmlHttp.responseXML.getElementsByTagName("func")[0].firstChild.nodeValue);
                }
            }
        }
    }

    // 初始化显示教师的课程
    function queryTeachersLesson(){
        var url = "queryTeachersLesson";
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    function updateTeachersLessonInformationList() {

        var node = document.getElementById("teachersLesson");
        node.parentNode.removeChild(node);

        var lessonList = document.getElementById("teachersLessonList");
        var div = createDiv("teachersLesson");
        var responseXML = xmlHttp.responseXML;
        for (var i = 0; i < responseXML.getElementsByTagName("lessonlist").length; i++) {

            var Lno   = responseXML.getElementsByTagName("Lno")    [i].firstChild.nodeValue;
            var Lname = responseXML.getElementsByTagName("Lname")  [i].firstChild.nodeValue;
            var Cname = responseXML.getElementsByTagName("Cname")  [i].firstChild.nodeValue;
            div.appendChild(createCard(Lno,Lname,Cname,"lessonInformation(this);"));

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
        lno = obj.childNodes[0].nodeValue;

        document.getElementById("currentlname").name=lname;
        document.getElementById("currentcname").name=cname;
        document.getElementById("currentlno").name=lno;


        document.getElementById('homeworkLno').setAttribute("name",lno);
        document.getElementById("lno").setAttribute("value",lno);
        document.getElementById("messageLno").setAttribute("value",document.getElementById("currentlno").name);
        document.getElementById("hidemessageLno").setAttribute("value",document.getElementById("currentlno").name);
        document.getElementById("messageLname").setAttribute("value",document.getElementById("currentlname").name);
        document.getElementById("HomeworkHidenLno").setAttribute("value",document.getElementById("currentlno").name)
        //document.getElementById("messageForm").setAttribute("action",'/upMessage?messageLno='+lno);

        homeworkList(cname,lno);

        var COUREMurl='lesson_student?lno='+lno;
        var studentAnswerurl;
        //学中
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
            table.render({
                elem: '#mid3'
                ,url: COUREMurl
                ,cols: [[
                    {field:'sno', width:150, title: '学号', sort: true}
                    ,{field:'sname', width:80, title: '姓名'}
                    ,{field:'sex', width:80, title: '性别'}
                    ,{field:'cname', width:120, title: '班级'}
                    ,{field:'major', width:120,title: '专业'}
                    ,{field:'birthday', width:120, title: '出生日期'}
                    ,{field:'enteryear', width:120, title: '入学年份'}
                    ,{fixed: 'right', title:'操作', toolbar: '#remarkOP', width:150}
                ]]
                ,page: true
            });
            table.on('edit(mid4)', function(obj){
                var value = obj.value //得到修改后的值
                    ,data = obj.data //得到所在行所有键值
                    ,field = obj.field; //得到字段
                project_score = value;
                pid = data.pid;
                submitProjectScore();
                layer.msg('[ID: '+ data.pid +'] ' + field + ' 字段更改为：'+ value);
            });
            table.on('tool(mid2)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'remark'){
                    type =  0;
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    normalIsRemarked();
                }else if(obj.event === 'change'){
                    type =  0;
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    document.getElementById('student').innerHTML='评价对象：'+tempSno+','+tempSname;
                    document.getElementById('normalteachername').innerHTML='评价人：'+'${Teacher.tname}';
                    document.getElementById('normalTeacherRemarkTable').click();
                }
            });
            table.on('tool(mid3)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'remark'){
                    type =  '期中';
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    studentAnswerurl='student_answer?sno='+tempSno+'&gno='+lno+'&type='+type;
                    document.getElementById('midstudentinfo').innerHTML='评价对象：'+tempSno+','+tempSname;
                    table.render({
                        elem: '#mid4'
                        ,url: studentAnswerurl
                        ,cols: [[
                            {field:'pid', width:80, title: '题号', sort: true}
                            ,{field:'content', width:150, title: '题目'}
                            ,{field:'parse', width:80, title: '提示'}
                            ,{field:'answer', width:150, title: '学生答案'}
                            ,{field:'score', width:120,title: '分数',edit: 'text'}
                        ]]
                        ,page: true
                    });
                    document.getElementById('scoreRemarkTable').click();
                }
            });

        });
        //结业
        layui.use('table', function(){
            var table = layui.table;
            type = 1;
            table.render({
                elem: '#final2'
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
        });
        layui.use('table', function(){
                var table = layui.table;
                type = 1;
                table.render({
                    elem: '#final3'
                    ,url: COUREMurl
                    ,cols: [[
                        {field:'sno', width:150, title: '学号', sort: true}
                        ,{field:'sname', width:80, title: '姓名'}
                        ,{field:'sex', width:80, title: '性别'}
                        ,{field:'cname', width:120, title: '班级'}
                        ,{field:'major', width:120,title: '专业'}
                        ,{field:'birthday', width:120, title: '出生日期'}
                        ,{field:'enteryear', width:120, title: '入学年份'}
                        ,{fixed: 'right', title:'操作', toolbar: '#remarkOP', width:150}
                    ]]
                    ,page: true
                });
            table.on('tool(final2)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'remark'){
                    type = 1;
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    normalIsRemarked();
                }else if(obj.event === 'change'){
                    type = 1;
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    document.getElementById('studentfinal').innerHTML='评价对象：'+tempSno+','+tempSname;
                    document.getElementById('normalfinal').innerHTML='评价人：'+'${Teacher.tname}';
                    document.getElementById('normalTeacherRemarkTable2').click();
                }
            });
            table.on('tool(final3)', function(obj){
                    var data = obj.data;
                    //console.log(obj)
                    if(obj.event === 'remark'){
                        type = '期末';
                        //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                        var info = JSON.parse(JSON.stringify(data));
                        tempSno = info.sno;
                        tempSname = info.sname;
                        studentAnswerurl='student_answer?sno='+tempSno+'&gno='+lno+'&type='+type;
                        table.render({
                            elem: '#final4'
                            ,url: studentAnswerurl
                            ,cols: [[
                                {field:'pid', width:80, title: '题号', sort: true}
                                ,{field:'content', width:150, title: '题目'}
                                ,{field:'parse', width:80, title: '提示'}
                                ,{field:'answer', width:150, title: '学生答案'}
                                ,{field:'score', width:120,title: '分数',edit: 'text'}
                            ]]
                            ,page: true
                        });
                        document.getElementById('finalstudentinfo').innerText='评价对象：'+tempSno+','+tempSname;
                        document.getElementById('finalScoreRemarkTable').click();
                    }
                });
            table.on('edit(final4)', function(obj){
                    var value = obj.value //得到修改后的值
                        ,data = obj.data //得到所在行所有键值
                        ,field = obj.field; //得到字段
                    project_score = value;
                    pid = data.pid;
                    submitProjectScore();
                    layer.msg('[ID: '+ data.pid +'] ' + field + ' 字段更改为：'+ value);
                });
        });

        //这里设置学中任课评价评分星星
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
        //这里设置结业任课评价评分星星
        layui.use(['rate'], function() {
            var rate = layui.rate;
            rate.render({
                elem: '#finalnormalscore1'
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
                elem: '#finalnormalscore2'
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
                elem: '#finalnormalscore3'
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
                elem: '#finalnormalscore4'
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
        //学中试题管理
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#mid41'
                ,url: "getSelect"
                ,cols: [[
                    {field:'stid', width:75, title: '编号', sort: true}
                    ,{field:'stTitle', width:700, title: '题目'}
                    ,{field:'stOptionA', width:130, title: '选项A'}
                    ,{field:'stOptionb', width:130, title: '选项B'}
                    ,{field:'stOptionc', width:130, title: '选项C'}
                    ,{field:'stoptiond', width:130,title: '选项D'}
                    ,{field:'stParse', width:130, title: '提示'}
                    ,{field:'stAnswer', width:130, title: '正确答案'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barSelect', width:80}
                ]]
                ,page: true
            });
            table.on('tool(mid41)', function(obj){
                var data = obj.data;

                if(obj.event === 'deleteSelect'){
                    layer.confirm('真的删除该通知吗', function(index){
                        obj.del();
                        createXMLHttpRequest();
                        xmlHttp.open("GET", "deleteSelect?stid="+data.stid, true); xmlHttp.send(null);
                        layer.close(index);
                        layer.msg("删除成功");
                    });
                }
            });
        });
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#mid42'
                ,url: "getJudge"
                ,cols: [[
                    {field:'stid', width:75, title: '编号', sort: true}
                    ,{field:'stcontent', width:1195, title: '题目'}

                    ,{field:'stparse', width:145, title: '提示'}
                    ,{field:'stanswer', width:145, title: '正确答案'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barJudge', width:80}
                ]]
                ,page: true
            });
            table.on('tool(mid42)', function(obj){
                var data = obj.data;

                if(obj.event === 'deleteJudge'){
                    layer.confirm('真的删除该通知吗', function(index){
                        obj.del();
                        createXMLHttpRequest();
                        xmlHttp.open("GET", "deleteJudge?stid="+data.stid, true); xmlHttp.send(null);
                        layer.close(index);
                        layer.msg("删除成功");
                    });
                }
            });
        });
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#mid43'
                ,url: "getProject"
                ,cols: [[
                    {field:'stid', width:75, title: '编号', sort: true}
                    ,{field:'stcontent', width:1195, title: '题目'}
                    ,{field:'stparse', width:290, title: '提示'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barProject', width:80}
                ]]
                ,page: true
            });
            table.on('tool(mid43)', function(obj){
                var data = obj.data;

                if(obj.event === 'deleteProject'){
                    layer.confirm('真的删除该通知吗', function(index){
                        obj.del();
                        createXMLHttpRequest();
                        xmlHttp.open("GET", "deleteProject?stid="+data.stid, true); xmlHttp.send(null);
                        layer.close(index);
                        layer.msg("删除成功");
                    });
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
        //学中
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
                    ,{field:'major', width:120,title: '专业'}
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
                    // var headtable = document.getElementById('headTeacherRemarkItem');
                    // headtable.removeChild(headtable.childNodes[0]);
                    // headtable.removeChild(headtable.childNodes[1]);
                    type =  0;
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    headIsRemarked();
                }else if(obj.event === 'change'){
                    type =  0;
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    document.getElementById('person').innerHTML='评价对象：'+tempSno+','+tempSname;
                    document.getElementById('headteachername').innerHTML='评价人：'+'${Teacher.tname}';
                    document.getElementById('headTeacherRemarkTable').click();
                }
            });
        });
        //结业
        layui.use('table', function(){
            var table = layui.table;
            table.render({
                elem: '#final1'
                ,url:HEADurl
                ,cols: [[
                    {field:'sno', width:150, title: '学号', sort: true}
                    ,{field:'sname', width:80, title: '姓名'}
                    ,{field:'sex', width:80, title: '性别'}
                    ,{field:'cno', width:120, title: '班级'}
                    ,{field:'major', width:120,title: '专业'}
                    ,{field:'birthday', width:120, title: '出生日期'}
                    ,{field:'enteryear', width:120, title: '入学年份'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barOP', width:150}
                ]]
                ,page: true
            });

            table.on('tool(final1)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'remark'){
                    type = 1;
                    //alert(type);
                    //layer.alert('编辑行：<br>'+ JSON.stringify(data));
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    headIsRemarked();
                }else if(obj.event === 'change'){
                    type = 1;
                    var info = JSON.parse(JSON.stringify(data));
                    tempSno = info.sno;
                    tempSname = info.sname;
                    document.getElementById('personfinal').innerHTML='评价对象：'+tempSno+','+tempSname;
                    document.getElementById('headfinal').innerHTML='评价人：'+'${Teacher.tname}';
                    document.getElementById('headTeacherRemarkTable2').click();
                }
            });
        });

        //这里设置学中评分星星
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
        //这里设置结业评分星星
        layui.use(['rate'], function() {
            var rate = layui.rate;
            rate.render({
                elem: '#finalscore1'
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
                elem: '#finalscore2'
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
                elem: '#finalscore3'
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
                elem: '#finalscore4'
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
        });
    }


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
                    ,{field:'hscore', width:120,title: '分数',edit:"text"}
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
                }
                else if(obj.event === 'score'){
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

            //监听单元格编辑
            table.on('edit(homeworkInformationTable)', function(obj){
                var value = obj.value //得到修改后的值
                    ,data = obj.data //得到所在行所有键值
                    ,field = obj.field; //得到字段
                layer.msg('[ID: '+ data.sno +'] ' + field + ' 字段更改为：'+ value);
                createXMLHttpRequest();
                xmlHttp.open("GET", 'updateHomeworkScore?sno='+data.sno+'&lno='+data.lno+'&hname='+data.hname+"&hscore="+value, true); xmlHttp.send(null);
                layer.msg("打分成功");

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
    function createCard(Lno,Lname,Cname,method){
        var body = document.createElement("div");
        body.setAttribute("class","layui-card-body");
        body.setAttribute("id",Cname);
        body.appendChild(document.createTextNode('课程名称：'+Lname));
        body.appendChild(createBr());
        body.appendChild(document.createTextNode('开课班级：'+Cname));
        var head = document.createElement("div");
        head.setAttribute("class","layui-card-header");
        head.appendChild(createA(Lno,method));
        var div = document.createElement("div");
        div.setAttribute("class","layui-card");div.setAttribute("id",Lname);
        var secongdiv = document.createElement("div");
        secongdiv.setAttribute("class","layui-col-md4");
        secongdiv.setAttribute("id",Lno);

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
    function updateLessonListVisibility(listname){
        var List = document.getElementById(listname);
        if (List.childNodes.length > 0){
            document.getElementById(listname + "Span").style.display = "";
        }else{
            document.getElementById(listname + "Span").style.display = "none";
        }
    }
</script>
</body>
</html>
