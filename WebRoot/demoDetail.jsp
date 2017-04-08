<%@page import="com.weixin.entity.actrainer.ActMember"%>
<%@page import="com.bg.Demo"%>
<%@page import="java.sql.Types"%>
<%@page import="com.tools.jdbc.SQLParameter"%>
<%@page import="com.weixin.util.CommonUtil"%>
<%@page import="com.weixin.entity.actrainer.ActDemo"%>
<%@page import="com.tools.jdbc.ConnectionJDBC"%>
<%@page import="com.tools.jdbc.JDBCTools"%>
<%@page import="com.tools.common.CommonString"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>图片详情</title>

    <!-- Sets initial viewport load and disables zooming  -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">

    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!-- Include the compiled Ratchet CSS -->
    <link href="/scripts/ratchet-2.0.2/dist/css/ratchet.css" rel="stylesheet">

    <!-- Include the compiled Ratchet JS -->
    <!-- <script src="/scripts/ratchet-2.0.2/dist/js/ratchet.min.js"></script> -->
	<script src="/scripts/mootools-core.js"></script>
    <script src="/scripts/mediabox.js"></script>
    <style type="text/css">
    	.gameImg{height: 240px;}
    	/* .image_container{border:1px solid #CCC; padding:2px} */
		#mbOverlay { position:fixed; z-index:9998; top:0; left:0; width:100%; height:100%; background-color:#000; cursor:pointer; }
		#mbOverlay.mbOverlayFF { background:transparent url(80.png) repeat; }
		#mbOverlay.mbOverlayIE { position:absolute; }
		#mbCenter { height:400px; position:absolute; z-index:9999; left:50%; background-color:#fff; -moz-border-radius:10px; -webkit-border-radius:10px; -moz-box-shadow:0 10px 40px rgba(0, 0, 0, 0.70); -webkit-box-shadow:0 10px 40px rgba(0, 0, 0, 0.70); }
    </style>
  </head>
  <body>

	<% 
		String toUserName=CommonString.getFormatPara(request.getParameter("toUserName"));
		if(toUserName!=""){
		JDBCTools tools=null;
		Demo d=new Demo();
		ActDemo ad=new ActDemo();
		List<ActDemo> list=new ArrayList<ActDemo>();
		List<ActMember> memberList=new ArrayList<ActMember>();
		String sql="";
		tools=new JDBCTools(new ConnectionJDBC().getConnection());
		SQLParameter[] param=new SQLParameter[1];
		sql="select * from act_member where weixin_id=?";
		param[0]=new SQLParameter(1,toUserName,Types.VARCHAR);
		memberList=(List<ActMember>)tools.find(sql,param,ActMember.class);
		sql="select * from tt_posture where submit_user="+memberList.get(0).getId()+" order by submit_time desc";
		list=(List<ActDemo>)tools.find(sql, null, ActDemo.class);
		ad=d.getActDemoById(list.get(0).getId());
		if(ad!=null){
	%>
		<header class="bar bar-nav">
      		<h1 class="title" style="text-align: center;">上传图片预览</h1>
    	</header>
	    <div class="content" style="text-align: center;padding-top: 54px;">
	       <div class="card">
	       <div class="mod_gallerylist" style="padding: 10px;">
					<div class="layout_default">
						<div class="image_container">
							<a href="http://wm.actrainer.com<%=CommonString.getFormatPara(ad.getPic1()) %>" rel="lightbox[ostec]" >
							<img class="gameImg" src= "http://wm.actrainer.com/<%=CommonString.getFormatPara(ad.getPic1()) %>">
							</a>
						</div>
					</div>
		    		
					<div class="layout_default"style="margin-top: 10px;">
						<div class="image_container">
							<a href="http://wm.actrainer.com<%=CommonString.getFormatPara(ad.getPic2()) %>" rel="lightbox[ostec]" >
							<img class="gameImg" src= "http://wm.actrainer.com/<%=CommonString.getFormatPara(ad.getPic2()) %>">
							</a>
						</div>
					</div>
					
					<div class="layout_default"style="margin-top: 10px;">
						<div class="image_container">
							<a href="http://wm.actrainer.com<%=CommonString.getFormatPara(ad.getPic3()) %>" rel="lightbox[ostec]" >
							<img class="gameImg" src= "http://wm.actrainer.com/<%=CommonString.getFormatPara(ad.getPic3()) %>">
							</a>
						</div>
					</div>
		  </div>			
	      </div>
	    </div> 
	<%}else{%>
		<div class="content">
				<h3>图片已不存在！请重新上传。</h3>
		</div>
	<%}
		 }else{%>
		<div class="content">
				<h3>系统错误！请尝试通过微信图文消息访问！</h3>
		</div> 
	<%}%>	
	

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
</script>
  </body>
</html>
