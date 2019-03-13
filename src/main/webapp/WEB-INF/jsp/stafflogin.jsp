<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html class="loginHtml">
<head>
    <meta charset="utf-8">
    <title>登录</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="/logincss/staff.ico">
    <link rel="stylesheet" href="/logincss/css/layui.css" media="all" />
    <link rel="stylesheet" href="/logincss/css/staffpublic.css" media="all" />
</head>
<body class="loginBody">
<form class="layui-form" action="<c:url value="http://localhost:8080/staff/loginCheck"/>" method="post">
    <div class="login_face"><img src="/images/staff.jpg" class="userAvatar"></div>
    <c:if test="${!empty error}">
        <font color="red"><c:out value="${error}" /></font>
    </c:if>
    <div class="layui-form-item input-item" align="center">
        <label>职员登录</label>
    </div>
    <div class="layui-form-item input-item">
        <label for="jobnum">公司名</label>
        <input type="text" placeholder="请输入公司名" autocomplete="off" id="company" name="company" class="layui-input" lay-verify="required">
    </div>
    <div class="layui-form-item input-item">
        <label for="jobnum">工号</label>
        <input type="text" placeholder="请输入工号" autocomplete="off" id="jobnum" name="jobnum" class="layui-input" lay-verify="required">
    </div>
    <div class="layui-form-item input-item">
        <label for="pswd">密码</label>
        <input type="password" placeholder="请输入密码" autocomplete="off" id="pswd" name="pswd" class="layui-input" lay-verify="required">
    </div>
    <%--<div class="layui-form-item input-item" id="imgCode">--%>
        <%--<label for="code">验证码</label>--%>
        <%--<input type="text" placeholder="请输入验证码" autocomplete="off" id="code" class="layui-input">--%>
        <%--<img src="/images/code.jpg">--%>
    <%--</div>--%>
    <div class="layui-form-item">
        <button type="submit" class="layui-btn layui-block" lay-filter="login" >登录</button>
    </div>
    <div class="layui-form-item layui-row">
        <a href="javascript:;" class="seraph icon-qq layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>
        <a href="javascript:;" class="seraph icon-wechat layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>
        <a href="javascript:;" class="seraph icon-sina layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>
    </div>
</form>
<script type="text/javascript" src="../../logincss/layui.js"></script>
<script type="text/javascript" src="../../logincss/login.js"></script>
</body>
</html>