<%@page import="java.sql.Types"%>
<%@page import="com.tools.jdbc.SQLParameter"%>
<%@page import="com.tools.jdbc.ConnectionJDBC"%>
<%@page import="com.tools.jdbc.JDBCTools"%>
<%@page import="com.weixin.entity.actrainer.TtAssessment"%>
<%@page import="com.tools.common.CommonString"%>
<%@page import="com.bg.Demo"%>
<%@page import="com.weixin.entity.actrainer.ActDemo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>评估结果</title>

    <!-- Sets initial viewport load and disables zooming  -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <!-- Include the compiled Ratchet CSS -->
    <link href="/css/mobie/ratchet-2.0.2/dist/css/ratchet.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/opt_mobie.css">
    <!-- Include the compiled Ratchet JS -->
    <!-- <script src="/scripts/ratchet-2.0.2/dist/js/ratchet.min.js"></script> -->
    <script src="/scripts/jquery-1.11.2.min.js"></script>
    <script src="/scripts/slidepic/js/jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="/scripts/mootools-core.js"></script>
    <script src="/scripts/mediabox.js"></script>
    <style type="text/css">
    	.tip{
    		font-size: 22px;
			font-family: 冬青黑体;
			font-weight:bold;
			color: #333333;
			line-height: 1.6;
    	}
    	p{
			padding-left: 3px;
			font-size: 15px;
			color: gray;
    	}
    	#mbOverlay { position:fixed; z-index:9998; top:0; left:0; width:100%; height:100%; background-color:#000; cursor:pointer; }
		#mbOverlay.mbOverlayFF { background:transparent url(80.png) repeat; }
		#mbOverlay.mbOverlayIE { position:absolute; }
		#mbCenter { height:400px; position:absolute; z-index:9999; left:50%; background-color:#fff; -moz-border-radius:10px; -webkit-border-radius:10px; -moz-box-shadow:0 10px 40px rgba(0, 0, 0, 0.70); -webkit-box-shadow:0 10px 40px rgba(0, 0, 0, 0.70); }
    </style>
  </head>
  <body>
<%
	int id=CommonString.getFormatInt(request.getParameter("id"));
	ActDemo demo=new ActDemo();
	Demo d=new Demo();
	demo=d.getActDemoById(id);
	if(demo==null){
		demo=new ActDemo();
	}
	List<ActDemo> list = new ArrayList<ActDemo>();
	List<TtAssessment> tlist=new ArrayList<TtAssessment>();
	String[] str=null;
	String s="";
	JDBCTools tools=null;
	tools=new JDBCTools(new ConnectionJDBC().getConnection());
	String sql="";
	sql="select * from tt_posture where id="+id+" and is_assess=1";
	list=(List<ActDemo>)tools.find(sql, null,ActDemo.class);
	if(list!=null&&list.size()!=0){
%>
<!--     <header class="bar bar-nav">
    <h1 class="title">评估结果</h1>
    </header> -->
    <div class="content">
			<div class="ttpic">
					<span class="tip">体态图片</span>
					<div  style="margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
					<div style="height: 248px;padding: 5px 0 24px 0;">
						<div class="made scrollbox" id="horizontal">
								<div class="madegame">
										<ul class="clearfix mod_gallerylist" id="ho">
											<li class="layout_default">
												<div class="image_container">
												<a href="http://wm.actrainer.com<%=demo.getPic1()%>" rel="lightbox[ostec]" ><img class="gameImg" src="http://wm.actrainer.com<%=demo.getPic1()%>" title=""></a>
												</div>
											</li>
											<li class="layout_default" style="margin-left: 20px;">
												<div class="image_container">
												<a href="http://wm.actrainer.com<%=demo.getPic2()%>" rel="lightbox[ostec]" ><img class="gameImg" src="http://wm.actrainer.com<%=demo.getPic2()%>" title=""></a>
												</div>
											</li>
											<li class="layout_default" style="margin:0 20px 0 20px;" >
												<div class="image_container">
												<a href="http://wm.actrainer.com<%=demo.getPic3()%>" rel="lightbox[ostec]" ><img class="gameImg" src="http://wm.actrainer.com<%=demo.getPic3()%>" title=""></a>
												</div>
											</li>
										</ul>
								</div>
						</div>
					</div>
			</div>
			<div style="height: 10px;background-color: #f1f1f1;"></div>
			<div class="ttbase">
					<span class="tip">体态问题基础评估</span>	
					<div  style="margin-left:5px; margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
						<div style="height: 314px;padding: 5px 0 24px 0;">
							<div class="made scrollbox" id="horizontal">
									<div class="madegame2"> 
										<ul class="clearfix" id="ho3">
										<%
										list=d.getCheckedList(1,id);
							  			str=CommonString.getFormatPara(list.get(0).getBaseScore()).split(",");
							  			s=CommonString.getFormatPara(list.get(0).getBaseScore());
							  			sql="select * from tt_assessment where id in ("+s+")";
							  	  		tlist=(List<TtAssessment>)tools.find(sql, null, TtAssessment.class);
										for(TtAssessment t:tlist){%>
											<li class="baseli">
												<img class="gameImg3" src="<%=t.getPic()%>" title=""><br>
												<div style="width:166px; margin-top: 10px;">
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
			<div style="height: 10px;background-color: #f1f1f1;"></div>
			<div style="clear: both;padding-left: 20px;">
				<span class="tip">其他体态问题：</span>
				<div  style="margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
		  		<%
		  			list=d.getCheckedList(3,id);
		  			s=CommonString.getFormatPara(list.get(0).getOtherScore());
		  			sql="select * from tt_assessment where id in ("+s+")";
		  	  		tlist=(List<TtAssessment>)tools.find(sql, null, TtAssessment.class);
		  	  		for(int i=0;i<tlist.size();i++){%>
		  	  		<p><%=tlist.get(i).getDescription() %></p>
		  	   <%} %>
			</div>
			<div style="height: 10px;background-color: #f1f1f1;"></div>
			<div style="margin-top: 10px;padding-left: 20px;">
				<span class="tip">面部问题：</span>
				<div  style="margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
		  		<%
		  			list=d.getCheckedList(2,id);
		  			s=CommonString.getFormatPara(list.get(0).getFaceScore());
		  			sql="select * from tt_assessment where id in ("+s+")";
		  			tlist=(List<TtAssessment>)tools.find(sql, null, TtAssessment.class);
		  	  		for(int i=0;i<tlist.size();i++){%>
		  	  		<p><%=tlist.get(i).getDescription() %></p>
		  	   <%} %>
			</div>
			<div style="height: 10px;background-color: #f1f1f1;"></div>
			<div style="margin-top: 10px;padding-left: 20px;">
				<span class="tip">体态综合评分：</span>
				<div  style="margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
		  		<%
		  			list=d.getCheckedList(4,id);
		  			s=CommonString.getFormatPara(list.get(0).getCoBefore());
		  			sql="select * from tt_assessment where id="+s;
		  			tlist=(List<TtAssessment>)tools.find(sql, null, TtAssessment.class);
		  		%>
		  			<p style="color:#23AEB1;"><%=tlist.get(0).getDescription() %></p>
			</div>
			<div style="height: 10px;background-color: #f1f1f1;"></div>
			<div style="margin-top: 10px;padding-left: 20px;">
				<span class="tip">基因评估：</span>
				<div  style="margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
		  		<%
		  			list=d.getCheckedList(5,id);
		  			s=CommonString.getFormatPara(list.get(0).getCoAfter());
		  			sql="select * from tt_assessment where id="+s;
		  			tlist=(List<TtAssessment>)tools.find(sql, null, TtAssessment.class);
		  		%>
		  			<p style="color:#23AEB1;"><%=tlist.get(0).getDescription() %></p>
			</div>
			<div style="height: 10px;background-color: #f1f1f1;"></div>
			<div class="suggest">
				<span class="tip">体态改善建议：</span>
				<div  style="background-color: #dfdfdf;height: 1px;"></div>
		  		<%
		  			list=d.getCheckedList(6,id);
		  			s=CommonString.getFormatPara(list.get(0).getSuggest());
		  		%>
		  			<textarea style="height:100px; width: 100%;margin-top: 10px;" readonly="readonly"><%=s%></textarea>
		  			
			</div>
			<div style="height: 10px;background-color: #f1f1f1;"></div>
			<div style="margin-top: 10px;padding-left: 20px;">
				<span class="tip">评估时间：</span>
				<div  style="margin-right: 20px;background-color: #dfdfdf;height: 1px;"></div>
		  		<%
		  			list=d.getCheckedList(7,id);
		  			s=CommonString.getFormatPara(list.get(0).getAssessTime());
		  		%>
		  			<p><%=s%></p>
			</div>
    </div>
<%}else{%>
	<div class="content">
		<h3>审核结果已不存在！请重新上传审核。</h3>
	</div>
<%} %>
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
			
			$("#ho3").mCustomScrollbar({
				axis:"x",
				advanced:{autoExpandHorizontalScroll:true}
			});
	
		});
	})(jQuery);
  </script>
</html>