<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>注册</title>
    <link href="/register/css/bootstrap.min.css" rel="stylesheet">
    <link href="/register/css/gloab.css" rel="stylesheet">
    <link href="/register/css/index.css" rel="stylesheet">
    <script src="/register/jquery-1.11.1.min.js"></script>
    <script src="/register/register.js"></script>
</head>
<body class="bgf4">
<div class="login-box f-mt10 f-pb50">
    <div class="main bgf">
        <div class="reg-box-pan display-inline">
            <div class="step">
                <ul>
                    <li class="col-xs-4 on">
                        <span class="num"><em class="f-r5"></em><i>1</i></span>
                        <span class="line_bg lbg-r"></span>
                        <p class="lbg-txt">填写管理员信息</p>
                    </li>
                    <li class="col-xs-4">
                        <span class="num"><em class="f-r5"></em><i>2</i></span>
                        <span class="line_bg lbg-l"></span>
                        <span class="line_bg lbg-r"></span>
                        <p class="lbg-txt">验证账户信息</p>
                    </li>
                    <li class="col-xs-4">
                        <span class="num"><em class="f-r5"></em><i>3</i></span>
                        <span class="line_bg lbg-l"></span>
                        <p class="lbg-txt">注册成功</p>
                    </li>
                </ul>
            </div>
            <div class="reg-box" id="verifyCheck" style="margin-top:20px;">
                <div class="part1">
                    <form action="/admin/SAddCompany" method="POST" id="formId">
                        <div class="item col-xs-12">
                            <span class="intelligent-label f-fl"><b class="ftx04">*</b>用户名：</span>
                            <div class="f-fl item-ifo">
                                <input type="text" maxlength="20" class="txt03 f-r3 required" tabindex="1" data-valid="isNonEmpty||between:3-20||isUname" data-error="用户名不能为空||用户名长度3-20位||只能输入中文、字母、数字、下划线，且以中文或字母开头" id="account" />                            <span class="ie8 icon-close close hide"></span>
                                <label class="icon-sucessfill blank hide"></label>
                                <label class="focus"><span>3-20位，中文、字母、数字、下划线的组合，以中文或字母开头</span></label>
                                <label class="focus valid"></label>
                            </div>
                        </div>
                        <div class="item col-xs-12">
                            <span class="intelligent-label f-fl"><b class="ftx04">*</b>身份证号：</span>
                            <div class="f-fl item-ifo">
                                <input type="text" maxlength="20" class="txt03 f-r3 required" tabindex="1" data-valid="isNonEmpty||between:18-18||isInt" data-error="身份证号不能为空||身份证号长度18位||只能输入数字" id="id_num" />                            <span class="ie8 icon-close close hide"></span>
                                <label class="icon-sucessfill blank hide"></label>
                                <label class="focus"><span>18位数字</span></label>
                                <label class="focus valid"></label>
                            </div>
                        </div>
                        <div class="item col-xs-12">
                            <span class="intelligent-label f-fl"><b class="ftx04">*</b>公司id：</span>
                            <div class="f-fl item-ifo">
                                <input type="text" maxlength="20" class="txt03 f-r3 required" tabindex="1" data-valid="isNonEmpty||isInt" data-error="所属公司id不能为空||只能输入数字" id="companyId" />                            <span class="ie8 icon-close close hide"></span>
                                <label class="icon-sucessfill blank hide"></label>
                                <label class="focus"><span>请输入所属公司id</span></label>
                                <label class="focus valid"></label>
                            </div>
                        </div>
                        <div class="item col-xs-12">
                            <span class="intelligent-label f-fl"><b class="ftx04">*</b>手机号：</span>
                            <div class="f-fl item-ifo">
                                <input type="text" class="txt03 f-r3 required" keycodes="tel" tabindex="2" data-valid="isNonEmpty||isPhone" data-error="手机号码不能为空||手机号码格式不正确" maxlength="11" id="phone" />
                                <span class="ie8 icon-close close hide"></span>
                                <label class="icon-sucessfill blank hide"></label>
                                <label class="focus">请填写11位有效的手机号码</label>
                                <label class="focus valid"></label>
                            </div>
                        </div>
                        <div class="item col-xs-12">
                            <span class="intelligent-label f-fl"><b class="ftx04">*</b>密码：</span>
                            <div class="f-fl item-ifo">
                                <input type="password" id="password" maxlength="20" class="txt03 f-r3 required" tabindex="3" style="ime-mode:disabled;" onpaste="return  false" autocomplete="off" data-valid="isNonEmpty||between:6-20||level:2" data-error="密码不能为空||密码长度6-20位||该密码太简单，有被盗风险，建议字母+数字的组合" />
                                <span class="ie8 icon-close close hide" style="right:55px"></span>
                                <span class="showpwd" data-eye="password"></span>
                                <label class="icon-sucessfill blank hide"></label>
                                <label class="focus">6-20位英文（区分大小写）、数字、字符的组合</label>
                                <label class="focus valid"></label>
                                <span class="clearfix"></span>
                                <label class="strength">
                                    <span class="f-fl f-size12">安全程度：</span>
                                    <b><i>弱</i><i>中</i><i>强</i></b>
                                </label>
                            </div>
                        </div>
                        <div class="item col-xs-12">
                            <span class="intelligent-label f-fl"><b class="ftx04">*</b>确认密码：</span>
                            <div class="f-fl item-ifo">
                                <input type="password" maxlength="20" class="txt03 f-r3 required" tabindex="4" style="ime-mode:disabled;" onpaste="return  false" autocomplete="off" data-valid="isNonEmpty||between:6-16||isRepeat:password" data-error="密码不能为空||密码长度6-16位||两次密码输入不一致" id="rePassword" />
                                <span class="ie8 icon-close close hide" style="right:55px"></span>
                                <span class="showpwd" data-eye="rePassword"></span>
                                <label class="icon-sucessfill blank hide"></label>
                                <label class="focus">请再输入一遍上面的密码</label>
                                <label class="focus valid"></label>
                            </div>
                        </div>
                        <div class="item col-xs-12">
                            <span class="intelligent-label f-fl"><b class="ftx04">*</b>验证码：</span>
                            <div class="f-fl item-ifo">
                                <input type="text" maxlength="4" class="txt03 f-r3 f-fl required" tabindex="4" style="width:167px" id="randCode" data-valid="isNonEmpty" data-error="验证码不能为空" />
                                <span class="ie8 icon-close close hide"></span>
                                <label class="f-size12 c-999 f-fl f-pl10">
                                    <img src="/register/images/yzm.jpg" />
                                </label>
                                <label class="icon-sucessfill blank hide" style="left:380px"></label>
                                <label class="focusa">看不清？<a href="javascript:;" class="c-blue">换一张</a></label>
                                <label class="focus valid" style="left:370px"></label>
                            </div>
                        </div>
                        <div class="item col-xs-12" style="height:auto">
                            <span class="intelligent-label f-fl">&nbsp;</span>
                            <p class="f-size14 required"  data-valid="isChecked" data-error="请先同意条款">
                                <input type="checkbox" checked /><a href="javascript:showoutc();" class="f-ml5">我已阅读并同意条款</a>
                            </p>
                            <label class="focus valid"></label>
                        </div>
                        <div class="item col-xs-12">
                            <span class="intelligent-label f-fl">&nbsp;</span>
                            <div class="f-fl item-ifo">
                                <a href="javascript:;" class="btn btn-blue f-r3" id="btn_part1">下一步</a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="part2" style="display:none">
                    <div class="alert alert-info" style="width:700px">短信已发送至您手机，请输入短信中的验证码，确保您的手机号真实有效。</div>
                    <div class="item col-xs-12 f-mb10" style="height:auto">
                        <span class="intelligent-label f-fl">手机号：</span>
                        <div class="f-fl item-ifo c-blue" id="phoneValue">
                            <%--<script>document.getElementById("phone").value;</script>--%>
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>验证码：</span>
                        <div class="f-fl item-ifo">
                            <input type="text" maxlength="6" id="verifyNo" class="txt03 f-r3 f-fl required" tabindex="4" style="width:167px" data-valid="isNonEmpty||isInt" data-error="验证码不能为空||请输入6位数字验证码" />
                            <span class="btn btn-gray f-r3 f-ml5 f-size13" id="time_box" disabled style="width:97px;display:none;">发送验证码</span>
                            <span class="btn btn-gray f-r3 f-ml5 f-size13" id="verifyYz" style="width:97px;">发送验证码</span>
                            <span class="ie8 icon-close close hide" style="right:130px"></span>
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus"><span>请查收手机短信，并填写短信中的验证码（此验证码3分钟内有效）</span></label>
                            <label class="focus valid"></label>
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl">&nbsp;</span>
                        <div class="f-fl item-ifo">
                            <a href="javascript:;" class="btn btn-blue f-r3" id="btn_part2">注册</a>
                        </div>
                    </div>
                </div>
                <div class="part3 text-center" style="display:none">
                    <h3>您已提交注册成功，请等待管理员审核！</h3>
                    <p class="c-666 f-mt30 f-mb50">页面将在 <strong id="times" class="f-size18">10</strong> 秒钟后，跳转到 <a href="http://localhost:8080/loginCheck.html" class="c-blue">后台登录</a></p>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="m-sPopBg" style="z-index:998;"></div>
<div class="m-sPopCon regcon">
    <div class="m-sPopTitle"><strong>服务协议条款</strong><b id="sPopClose" class="m-sPopClose" onClick="closeClause()">×</b></div>
    <div class="apply_up_content">
    	<pre class="f-r0">
		<strong>同意以下服务条款，提交注册信息</strong>
        </pre>
    </div>
    <center><a class="btn btn-blue btn-lg f-size12 b-b0 b-l0 b-t0 b-r0 f-pl50 f-pr50 f-r3" href="javascript:closeClause();">已阅读并同意此条款</a></center>
</div>
<script>
    var account;
    var id_num;
    var pswd;
    var companyId;
    var phone;
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
    // 保存公司信息
    function submitOAdminApply(){
        var url = "/admin/OAdminApply?account="+account+"&pswd="+pswd+"&id_num="+id_num+"&companyId="
            +companyId+"&phone="+phone;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", url, true); xmlHttp.send(null);
    }
    $(function(){
        //第一页的确定按钮
        $("#btn_part1").click(function(){
            if(!verifyCheck._click()) return;
            $(".part1").hide();
            $(".part2").show();
            $(".step li").eq(1).addClass("on");
            phone = document.getElementById("phone").value;
            document.getElementById("phoneValue").innerText=phone;
            account = document.getElementById("account").value;
            pswd = document.getElementById("password").value;
            id_num = document.getElementById("id_num").value;
            companyId = document.getElementById("companyId").value;
            phone = document.getElementById("phone").value;
        });
        //第二页的确定按钮
        $("#btn_part2").click(function(){
            if(!verifyCheck._click()) return;
            $(".part2").hide();
            $(".part3").show();
            $(".step li").eq(2).addClass("on");
            countdown({
                maxTime:10,
                ing:function(c){
                    $("#times").text(c);
                },
                after:function(){
                    window.location.href="http://localhost:8080/loginCheck.html";
                }
            });
            submitOAdminApply();
        });
    });
    function showoutc(){$(".m-sPopBg,.m-sPopCon").show();}
    function closeClause(){
        $(".m-sPopBg,.m-sPopCon").hide();
    }

    //公司信息提交
    function upload() {
        $("#formId").submit();
    }
</script>
</body>
</html>
