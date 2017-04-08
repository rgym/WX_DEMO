<%@page import="java.sql.Types"%>
<%@page import="com.tools.jdbc.SQLParameter"%>
<%@page import="com.tools.jdbc.ConnectionJDBC"%>
<%@page import="com.tools.common.DesUtils"%>
<%@page import="com.weixin.entity.actrainer.Admin"%>
<%@page import="com.tools.jdbc.JDBCTools"%>
<%@page import="com.weixin.entity.actrainer.TtAssessment"%>
<%@page import="com.bg.Demo"%>
<%@page import="com.weixin.entity.actrainer.ActDemo"%>
<%@page import="com.tools.common.CommonString"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>体态评估</title>
    <!-- Sets initial viewport load and disables zooming  -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">

    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!-- Include the compiled Ratchet CSS -->
    <link href="/scripts/ratchet-2.0.2/dist/css/ratchet.css" rel="stylesheet">
	<link href="/css/opt.css" rel="stylesheet">
	<link href="/scripts/jqueryscore/css/examples.css" rel="stylesheet">
	<link href="/scripts/jqueryscore/css/main.css" rel="stylesheet">
    <script src="/scripts/jquery-1.11.2.min.js"></script>
    <script src="/scripts/ratchet-2.0.2/dist/js/ratchet.min.js"></script>
    <script src="/scripts/jqueryscore/js/jquery.barrating.js"></script>
    <script src="/scripts/jqueryscore/js/examples.js"></script>
	<script type="text/javascript" src="/scripts/jquery.cookie.js"></script>
<%
	JDBCTools tools=null;
	List<Admin> ulist =new ArrayList<Admin>();
    Date date1=new Date();
	String date=date1.toString();
	String id=CommonString.getFormatPara(request.getParameter("id"));
	ActDemo act=new ActDemo();
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
	<style type="text/css">
		body {
			font-size: 14px;
		}	
	</style>
  </head>
  
<body>
		<header class="bar bar-nav head">
  			<span class="htitle">体态评估</span>
		</header>

		<div class="content" style="background-color: #e9e9e9; margin-top: 50px;">
			<form action="/rigist.jsp" id="rigistForm">
				<input type="hidden" name="userId" value="<%=id%>" />
				<div class="baseinfo">
						<span>昵称:</span><span><%=act.getNickname() %></span>	<br>	
						<span>邮箱:</span><span><%=act.getEmail()%></span><br>
						<span>上传时间:</span><span><%=act.getSubmitTime()%></span>
				</div>
				
				<div class="ttpic">
					<span>体态图片</span>
					<div style="height: 700px;padding: 20px;margin-top: 10px;">
						<div class="besh-resim">
							<ul class="resim-isimler">
								<img src="/images/up.png">
								<li class="resim-isim"><img class="isim" src="http://wm.actrainer.com<%=act.getPic1()%>" title=""></li>
								<li class="resim-isim"><img class="isim" src="http://wm.actrainer.com<%=act.getPic2()%>" title=""></li>
								<li class="resim-isim"><img class="isim" src="http://wm.actrainer.com<%=act.getPic3()%>" title=""></li>
								<img src="/images/down.png">
							</ul>
							<div class="resimler">
								<a class="resim-ulinish" href="http://wm.actrainer.com<%=act.getPic1()%>" ><img class="resim" src="http://wm.actrainer.com<%=act.getPic1()%>" title=""></a>
								<a class="resim-ulinish" href="http://wm.actrainer.com<%=act.getPic2()%>" ><img class="resim" src="http://wm.actrainer.com<%=act.getPic2()%>" title=""></a>
								<a class="resim-ulinish" href="http://wm.actrainer.com<%=act.getPic3()%>" ><img class="resim" src="http://wm.actrainer.com<%=act.getPic3()%>" title=""></a>
							</div>
						</div>
					</div>
				</div>
				
				<div class="ttbase">
					<div style="clear: both;">
						<span id="tbtitle">体态问题基础评估（请选择最少1项）</span>	
					</div>
					<%tlist=action.getList(1); 
							for(TtAssessment t:tlist){%>
						<div style="width: 185px;height:265px; padding: 10px; float: left;display: block; background-color:#e9e9e9;margin-top:15px;margin-left: 13px; ">
							<div>
								<img width="165px;" height="140px;" alt="" src="<%=t.getPic()%>"><br>
								<div style="width:165px; margin-top: 12px;">
								<input  id="<%=t.getId()%>" style="width: 16px;height:16px;" type="checkbox" value="<%=t.getId()%>" name="bid" dataType="*" >
								<label for="<%=t.getId()%>"><span style="color: black;font-weight: bold;"><%=t.getTitle() %></span>
								<p style="line-height: 14px;"><%=t.getDescription()%></p></label>
								</div>
							</div>
						</div>
					   <%}%>
				</div>
				
				<div class="oproblem" style="clear: both;">
				<span id="otitle">其他体态问题</span>
				<div style="margin-left:25px;margin-top:10px;">
				<%tlist=new ArrayList<TtAssessment>();
					 tlist=action.getList(3);
						for(TtAssessment t:tlist){
						%>
							<div style="width:188px; float: left;margin-top: 10px;">
								<input  id="<%=t.getId()%>" style="width: 16px;height:16px;" type="checkbox" value="<%=t.getId()%>" name="oid" dataType="*">
								<label for="<%=t.getId()%>"><span style="color: black;font-weight: bold;"><%=t.getDescription() %></span></label>
							</div>					
				   <%}%>
				</div>   
				</div>
				
				<div class="fproblem"> 
				<span id="ftitle">面部问题</span>
				<div style="margin-left:25px;margin-top:10px;">
				<%tlist=new ArrayList<TtAssessment>();
					 tlist=action.getList(2);
						for(TtAssessment t:tlist){
						%>
						<div style="width:342px; float: left;margin-top: 10px;">
						<input  id="<%=t.getId()%>" style="width: 16px;height:16px;" type="checkbox" value="<%=t.getId()%>" name="fid" dataType="*">
						<label for="<%=t.getId()%>"><span style="color: black;font-weight: bold;"><%=t.getDescription() %></span></label>
						</div>
				   <%}%>
				</div>
				</div>
				
				<div class="bscore">
					<span id="btitle">体态综合评分</span>
					<section class="section section-examples">
							<div class="box-body">
									<select id="example-a" name="rating" dataType="*">
									<%tlist=new ArrayList<TtAssessment>();
											tlist=action.getList(4);
											for(TtAssessment t:tlist){%>
												 <option value="<%=t.getId()%>"><%=t.getDescription() %></option>
									  <%}%>
									</select>
				   			</div>
				   	</section>
				</div>

				<div class="ascore">
					<span id="atitle">基因评估（矫正后可达到的体态分值）</span>
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
				
				<div class="suggest">
				<span id="tsuggest">体态改善建议 </span><br>
					<textarea style="height:100px; width: 800px;margin:10px 0 0 35px;" name="suggest" dataType="*"></textarea>
				</div>
			</form>
				
			<div class="bt" style="text-align: center;margin: 0 auto;">
				<button class="btn  b1" onclick="rigist()">完成审核</button>
				<button class="btn  b2" onclick="cancel()">取消操作</button>
			</div>
				
				<div style="height: 20px;"></div>
		</div>
		<%}else{%>
				<div style="text-align: center;">
					<h3>您没有权限访问页面内容，请返回登录页面登录！</h3>
					<button class="btn btn-primary" onclick="goLogin();">前往登录</button>
				</div>
				<%}%>			
		
	<script type="text/javascript" src="/scripts/validform/Validform_v5.3.2.js"></script>
	<script>
	$(function(){
		$(".resim-isim").mouseover(function(){
			var i=$(".resim-isim").index(this);
			$(".resim-ulinish").eq(i).stop(false,true).fadeIn(300)
			$(".resim-ulinish").eq(i).siblings().stop(false,true).fadeOut(300)
		})
	}) 

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
				alert("审核成功");
				window.location.href="/bg/backend.jsp";
			},error:function(d1, d2){
				alert("系统错误，请稍后重试!");
			}
		}
	});
	function cancel(){
			confirm_ = confirm('确定取消操作?');
			if(confirm_){
				window.location.href="/bg/backend.jsp";
			}
	}
	function goLogin(){
		window.location.href="/";
	}
	 
	</script>	
  </body>
</html>
