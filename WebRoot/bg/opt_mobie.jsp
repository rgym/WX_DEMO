<%@page import="java.sql.Types"%>
<%@page import="com.tools.jdbc.SQLParameter"%>
<%@page import="com.tools.jdbc.ConnectionJDBC"%>
<%@page import="com.tools.jdbc.JDBCTools"%>
<%@page import="com.tools.common.DesUtils"%>
<%@page import="com.weixin.entity.actrainer.Admin"%>
<%@page import="com.weixin.entity.actrainer.TtAssessment"%>
<%@page import="com.bg.Demo"%>
<%@page import="com.weixin.entity.actrainer.ActDemo"%>
<%@page import="com.tools.common.CommonString"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>体态评估</title>
    <!-- <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui"> -->
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link href="/css/mobie/ratchet-2.0.2/dist/css/ratchet.css" rel="stylesheet">
    <!-- <link href="/css/opt_mobie.css" rel="stylesheet"> -->
    <link rel="stylesheet" media="all and (orientation:portrait)" href="/css/opt_mobie.css">
    <link rel="stylesheet" media="all and (orientation:landscape)" href="/css/opt_mobie.css">
    <link href="/css/mobie/jqueryscore/css/examples.css" rel="stylesheet">
	<link href="/css/mobie/jqueryscore/css/main.css" rel="stylesheet">
	<link href="/scripts/sweetalert/sweet-alert.css" type='text/css' rel='stylesheet'  />
    <script src="/scripts/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="/scripts/jquery.cookie.js"></script>
    <script type="text/javascript" src="/scripts/sweetalert/sweet-alert.js"></script>
   <!--<script src="/scripts/ratchet-2.0.2/dist/js/ratchet.js"></script> -->
    <script src="/scripts/slidepic/js/jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="/css/mobie/jqueryscore/js/jquery.barrating.js"></script>
    <script src="/css/mobie/jqueryscore/js/examples.js"></script>
    <script src="/scripts/mootools-core.js"></script>
    <script src="/scripts/mediabox.js"></script>
    <script type="text/javascript" src="/scripts/validform/Validform_v5.3.2.js"></script>
    <style type="text/css">
		#mbOverlay { position:fixed; z-index:9998; top:0; left:0; width:100%; height:100%; background-color:#000; cursor:pointer; }
		#mbOverlay.mbOverlayFF { background:transparent url(80.png) repeat; }
		#mbOverlay.mbOverlayIE { position:absolute; }
		#mbCenter { height:400px; position:absolute; z-index:9999; left:50%; background-color:#fff; -moz-border-radius:10px; -webkit-border-radius:10px; -moz-box-shadow:0 10px 40px rgba(0, 0, 0, 0.70); -webkit-box-shadow:0 10px 40px rgba(0, 0, 0, 0.70); }
    </style>
  </head>
  <body>
  	<%
  	JDBCTools tools=null;
    Date date1=new Date();
	String date=date1.toString();
	String id=CommonString.getFormatPara(request.getParameter("id"));
	ActDemo act=new ActDemo();
	List<Admin> ulist =new ArrayList<Admin>();
	Demo action=new Demo();
	DesUtils u = null;
	String sql="";
	String uname="";
	String pwd="";
		tools=new JDBCTools(new ConnectionJDBC().getConnection());
		SQLParameter[] param=new SQLParameter[2];
		Cookie[] cookies = request.getCookies();
		if(cookies!=null&&cookies.length>1){
		for(int i = 0; i < cookies.length; i++){
			Cookie cook = cookies[i];
			if(cook.getName().equalsIgnoreCase("uname")){
					uname=cook.getValue().toString();
			}else if(cook.getName().equalsIgnoreCase("pwd")){
					pwd=cook.getValue().toString();
			}
		}
		u=new DesUtils();
		param[0]=new SQLParameter(1,u.decrypt(uname), Types.VARCHAR);
		param[1]=new SQLParameter(2,u.decrypt(pwd), Types.VARCHAR);
		sql="select * from admin_member where phone=?  and password=?";
		ulist= (List<Admin>) tools.find(sql, param, Admin.class);
		}
		if(ulist!=null&&ulist.size()!=0){
			if(!id.equals("")){
				act=action.getActDemoById(CommonString.getFormatInt(id));
				if(act==null){
					act=new ActDemo();
				}
			}
		List<TtAssessment> tlist=new ArrayList<TtAssessment>();
	
%>
    <header class="bar bar-nav">
      <h1 class="title">体态评估</h1>
    </header>
    <div class="content">
      			<form action="/rigist.jsp" id="rigistForm">
					<input type="hidden" name="userId" value="<%=id%>" />
					<div class="baseinfo">
							<span>昵称:</span><span><%=act.getNickname() %></span>	<br>	
							<span>邮箱:</span><span><%=act.getEmail()%></span><br>
							<span>上传时间:</span><span><%=act.getSubmitTime()%></span>
					</div>
					
					<div style="height: 10px;background-color: #f1f1f1;"></div>
					
					<div class="ttpic">
						<span>体态图片</span>
						<div  style="margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
						<div style="height: 248px;padding: 5px 0 24px 0;">
							<div class="made scrollbox" id="horizontal">
								<div class="madegame">
									<ul class="clearfix mod_gallerylist" id="ho">
										<li class="layout_default">
											<div class="image_container">
											<a href="http://wm.actrainer.com<%=act.getPic1()%>" rel="lightbox[ostec]" ><img class="gameImg" src="http://wm.actrainer.com<%=act.getPic1()%>" title=""></a>
											</div>
										</li>
										<li class="layout_default" style="margin-left: 20px;">
											<div class="image_container">
											<a href="http://wm.actrainer.com<%=act.getPic2()%>" rel="lightbox[ostec]" ><img class="gameImg" src="http://wm.actrainer.com<%=act.getPic2()%>" title=""></a>
											</div>
										</li>
										<li class="layout_default" style="margin:0 20px 0 20px;" >
											<div class="image_container">
											<a href="http://wm.actrainer.com<%=act.getPic3()%>" rel="lightbox[ostec]" ><img class="gameImg" src="http://wm.actrainer.com<%=act.getPic3()%>" title=""></a>
											</div>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					
					<div style="height: 10px;background-color: #f1f1f1;"></div>
					
					<div class="ttbase">
						<span id="tbtitle">体态问题基础评估</span>	
						<div  style="margin-left:5px; margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
						<div style="height: 374px;padding: 5px 0 24px 0;">
							<div class="made scrollbox" id="horizontal">
								<div class="madegame2"> 
									<ul class="clearfix" id="ho2">
									<%tlist=action.getList(1); 
									for(TtAssessment t:tlist){%>
										<li class="baseli">
											<img class="gameImg2" src="<%=t.getPic()%>" title=""><br>
											<div style="width:166px; margin-top: 10px;">
												<input id="<%=t.getId()%>" style="width: 18px;height:18px;vertical-align: middle;" type="checkbox" value="<%=t.getId()%>" name="bid" dataType="*" >
												<label for="<%=t.getId()%>"><span style="color: black;font-weight: bold;font-family:冬青黑体;font-size: 18px;"><%=t.getTitle() %></span>
												<p style="font-size: 16px;font-family: 冬青黑体;color: #888888;line-height: 22px;"><%=t.getDescription()%></p></label>
											</div>
										</li>
						  	   <%}%>
									</ul>
								</div>
							</div>
						</div>
					</div>
					
					<div style="height: 10px;background-color: #f1f1f1;clear: both;"></div>
					
					<div class="oproblem">
					<span id="otitle">其他体态问题</span>
					<div  style="margin-left: 20px;margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
					<div style="margin-left:20px;">
					<%tlist=new ArrayList<TtAssessment>();
						 tlist=action.getList(3);
							for(TtAssessment t:tlist){
							%>
								<div style="width:206px; float: left;margin-bottom: 10px;">
									<input id="<%=t.getId()%>" style="width: 16px;height:16px;vertical-align: middle;" type="checkbox" value="<%=t.getId()%>" name="oid" dataType="*">
									<label for="<%=t.getId()%>"><span style="font-size: 13px;font-family: 冬青黑体;color: #000000;"><%=t.getDescription() %></span></label>
								</div>
					   <%}%>
					</div>
					</div>
					
					<div style="height: 10px;background-color: #f1f1f1;clear: both;margin-top: 10px;"></div>
					
					<div class="fproblem"> 
					<span id="ftitle">面部问题</span>
					<div  style="margin-left: 20px;margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
					<div style="margin-left:20px;margin-top:10px;">
					<%tlist=new ArrayList<TtAssessment>();
						 tlist=action.getList(2);
							for(TtAssessment t:tlist){
							%>
							<div style="width:300px; float: left;margin-bottom: 10px;">
							<input id="<%=t.getId()%>" style="width: 16px;height:16px;vertical-align: middle;" type="checkbox" value="<%=t.getId()%>" name="fid" dataType="*">
							<label for="<%=t.getId()%>"><span style="font-size: 13px;font-family: 冬青黑体;color: #000000;"><%=t.getDescription() %></span></label>
							</div>
					   <%}%>
					</div>
					</div>
					
					<div style="height: 10px;background-color: #f1f1f1;clear: both;"></div>
					
					<div class="bscore">
						<span id="btitle">体态综合评分</span>
						<div  style="margin-left: 20px;margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
						<section class="section section-examples">
								<div class="box-body" style="width: 100%">
										<select id="example-a" name="rating" dataType="*">
										<%tlist=new ArrayList<TtAssessment>();
												tlist=action.getList(4);
												for(TtAssessment t:tlist){%>
													 <option value="<%=t.getId()%>"><%=t.getDescription() %></option>
										  <% }%> 
										</select>
					   			</div>
					   	</section>
					</div>
					
					<div style="height: 10px;background-color: #f1f1f1;"></div>
					
					<div class="ascore">
						<span id="atitle">基因评估</span>
						<div  style="margin-left: 20px;margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
						<section  class="section section-examples" >
								<div class="box-body">
										<select id="example-b" name="rating" dataType="*">
										<%tlist=new ArrayList<TtAssessment>();
											 tlist=action.getList(5);
												for(TtAssessment t:tlist){
												%>
									   			<option value="<%=t.getId()%>"><%=t.getDescription() %></option>
										   <%}%>
					   					</select>
					   			</div>
					   	</section>
					</div>
					
					<div style="height: 10px;background-color: #f1f1f1;"></div>
					
					<div class="suggest">
					<span id="tsuggest">体态改善建议</span><br>
					<div  style="background-color: #dfdfdf;height: 1px;"></div>
						<textarea style="height:100px; width: 100%;margin-top: 10px;" name="suggest" dataType="*"></textarea>
					</div>
			</form>

			<div style="height: 10px;background-color:#f1f1f1;"></div>
			
			<div class="bt" style="text-align: center;margin: 0 auto;padding: 20px;">
				<button class="btn  b1" onclick="rigist()">完成审核</button>
				<button class="btn  b2" onclick="cancel()">取消操作</button>
			</div>
    </div>
    <%}else{%>
			<div style="text-align: center;">
				<h3>您没有权限访问页面内容，请返回登录页面登录！</h3>
				<button class="btn btn-primary" onclick="goLogin();">前往登录</button>
			</div>
			<%}%>		

  </body>
  <script type="text/javascript">
	Mediabox.scanPage = function() {
		  var links = $$("a").filter(function(el) {
		    return el.rel && el.rel.test(/^lightbox/i);
		  });
		  $$(links).mediabox({/* Put custom options here */}, null, function(el) {
		    var rel0 = this.rel.replace(/[[]|]/gi," ");
		    var relsize = rel0.split(" ");
		    return (this == el) || ((this.rel.length > 8) && el.rel.match(relsize[1]));
		  });
		};
		window.addEvent("domready", Mediabox.scanPage);
  
	(function($){
		$(window).load(function(){
			
			$.mCustomScrollbar.defaults.theme="light-2"; //set "light-2" as the default theme
			
			$("#ho").mCustomScrollbar({
				axis:"x",
				advanced:{autoExpandHorizontalScroll:true}
			});
			
			$("#ho2").mCustomScrollbar({
				axis:"x",
				advanced:{autoExpandHorizontalScroll:true}
			});
	
		});
	})(jQuery);
	
	function rigist(){
		if(vl.check()){
			vl.submitForm();
		}else{
			alert("您还有项目没有评估！");
		}
	}
	var vl = $("#rigistForm").Validform({
		ajaxPost:true,
		tiptype:function(msg,o,cssctl){	
		},
	
		ajaxpost:{
			success:function(data){
				noticeTipSuc("审核成功","",500);
				window.location.href="/bg/backend.jsp";
			},error:function(d1, d2){
				noticeTipErr("出错了！","系统错误，请刷新后尝试...",2000);
			}
		}
	});
	function cancel(){
			confirm_ = confirm('确定取消操作?');
			if(confirm_){
				window.location.href="/bg/backend.jsp";
			}
	}
	function noticeTipErr(title,content,timeout){
		swal({
			title: title,
			text: content,   
			timer: timeout,
			type:"error"
		});
	}
	function noticeTipSuc(title,content,timeout){
		swal({
			title: title,
			text: content,
			timer: timeout,
			type:"success"
		});
	}
	function goLogin(){
		window.location.href="/";
	}
	
  </script>
</html>