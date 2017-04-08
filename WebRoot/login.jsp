<%@page import="com.tools.jdbc.SQLParameter"%>
<%@page import="com.tools.jdbc.ConnectionJDBC"%>
<%@page import="com.tools.jdbc.JDBCTools"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <title>用户登录</title>

    <!-- Sets initial viewport load and disables zooming  -->
     <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <!-- Include the compiled Ratchet CSS -->
    <link href="/scripts/ratchet-2.0.2/dist/css/ratchet.css" rel="stylesheet">
    <!-- Include the compiled Ratchet JS -->
    <script type="text/javascript" src="/scripts/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/scripts/validform/Validform_v5.3.2.js"></script>
    <script type="text/javascript" src="/scripts/sweetalert/sweet-alert.js"></script>
    <link href="/scripts/sweetalert/sweet-alert.css" type='text/css' rel='stylesheet'  />
    <script type="text/javascript" src="/scripts/jquery.cookie.js"></script>
    <script src="/scripts/ratchet-2.0.2/dist/js/ratchet.min.js"></script>
	<style type="text/css">
		.form_middle{
			text-align: center;
			margin-top: 10px;
		}
		span{
			color: blue;
		}
	</style>
  </head>
  		
  <body>
	<header class="bar bar-nav">
      <h1 class="title">管理员登录</h1>
    </header>

    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
    <div class="content">
      <div class="card">
		<form class="form_middle" id="login-form" action="/LoginServlet">
				<div class="">
					<span>用户名</span>
					<input id="uname" type="text" placeholder="用户名" name="adminUsername" dataType="*" nullmsg="手机号/邮箱！"/>
				</div>

				<div class="">
					<span class=" ">密&nbsp;&nbsp;&nbsp;&nbsp;码</span>
					<input id="pwd" type="password" placeholder="密码" name="adminPassword" dataType="*" nullmsg="请输入密码！"/>
				</div>


		<div class="">
			<button class="btn btn-primary" onclick="submitInfo();">登录 </button>
		</div>
	</form>
		
      </div>
    </div>
	<script type="text/javascript">

	function submitInfo(){
		if(vl.check()){
			vl.submitForm();
		}else{
			noticeTipErr("信息不完整","请检查所填信息");
		}
	}
	var vl = $("#login-form").Validform({
		ajaxPost:true,
		tiptype:function(msg,o,cssctl){	
		},
		ajaxpost:{
			success:function(data){
				if(data!=null){
					$.cookie('uname',data.phone);
					$.cookie('pwd',data.password);
					window.location.href="/bg/backend.jsp";
				}else{
					noticeTipErr("用户名或密码错误！","请尝试重新输入");
				}
			},error:function(d1, d2){
				noticeTipErr("出错了！","系统错误，请刷新后尝试...",2000);
			}
		}
	});
	
	
	function noticeTipErr(title,content,timeout){
		swal({
			title: title,
			text: content,   
			timer: timeout,
			type:"error"
		});
	}
	
	</script>
  </body>
</html>
