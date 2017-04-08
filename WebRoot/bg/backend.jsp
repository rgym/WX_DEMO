<%@page import="com.weixin.util.CommonUtil"%>
<%@page import="com.tools.common.DesUtils"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.weixin.entity.actrainer.Admin"%>
<%@page import="java.sql.Types"%>
<%@page import="com.tools.jdbc.SQLParameter"%>
<%@page import="com.tools.jdbc.ConnectionJDBC"%>
<%@page import="com.tools.jdbc.JDBCTools"%>
<%@page import="com.bg.Demo"%>
<%@page import="com.tools.common.CommonString"%>
<%@page import="com.weixin.entity.actrainer.ActDemo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>待审核评分列表</title>

    <!-- Sets initial viewport load and disables zooming  -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">

    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <!-- Include the compiled Ratchet CSS -->
    <link href="/scripts/ratchet-2.0.2/dist/css/ratchet.css" rel="stylesheet">
    <!-- Include the compiled Ratchet JS -->
    <script src="/scripts/ratchet-2.0.2/dist/js/ratchet.min.js"></script>
    <style type="text/css">
    	.disabled>a{
    		color: #999;
    	}
    </style>
  </head>	
  <body>
  
  	<%
  		JDBCTools tools=null;
		List<Admin> ulist =new ArrayList<Admin>();
		int pageIndex=CommonString.getFormatInt(request.getParameter("pageIndex"));
		List<ActDemo> list=new ArrayList<ActDemo>();
		List<ActDemo> list2=new ArrayList<ActDemo>();
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
			  	Demo demo=new Demo();
			  	list2=demo.getDemoList();
				if(CommonString.getFormatPara(pageIndex)!=""){
				list=demo.getPageActDemoList(pageIndex+1,10);
				}else{
					list=demo.getPageActDemoList(1, 10);
				}
				if(list==null){
					list=new ArrayList<ActDemo>();
				}
		  %>
		
								<%
									if(list!=null&&list.size()>0){%>
		   							 <table style="text-align:center;margin:0 auto;font-size:15px;line-height: normal;">
										<thead>
											<tr>
												<th>昵称</th>
												<th>上传日期</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
										<%for(ActDemo a:list){%>
												<tr>
												<td><%=a.getNickname() %></td>
												<td><%=a.getSubmitTime() %></td>
												<td><a href="javascript:update(<%=a.getId()%>)">审核评分</a></td>
												<td><a href="javascript:deletes(<%=a.getId() %>,'tt_posture');">删除</a></td>
												</tr>
										<%}%>
										</tbody>
									</table>
											<div style="text-align:center;margin:0 auto;">
											    <button id="up"><a onclick="goUp()" id="up1">上一页</a></button>
											    <span>第<%=pageIndex+1 %>页</span>
											    <button id="down"><a onclick="goDown()"id="down1">下一页</a></button>
											 </div>
								<%}else{%>
											<h3 style="text-align: center;">并没有需要审核评分的图片哦</h3>
								<%}%>
			<%}else{%>
			<div style="text-align: center;">
				<h3>您没有权限访问页面内容，请返回登录页面登录！</h3>
				<button class="btn btn-primary" onclick="goLogin();">前往登录</button>
			</div>
			<%}%>		
						
  </body>
  <script type="text/javascript" src="/scripts/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="/scripts/jquery.cookie.js"></script>
  <script type="text/javascript">
  
		jQuery(document).ready(function(){
		   if(<%=pageIndex%>==0){
			   $("#up1").removeAttr("onclick")
			   $("#up").addClass("disabled");
		   }
		   if(<%=Math.ceil(list2.size()/10) %>==<%=pageIndex%>){
			   $("#down1").removeAttr("onclick")
			   $("#down").addClass("disabled");
		   }
		});
		
		function goUp(){
			window.location.href="/bg/backend.jsp?pageIndex=<%=pageIndex-1%>";
		}
		
		function goDown(){
			window.location.href="/bg/backend.jsp?pageIndex=<%=pageIndex+1%>";
		}
		
		function deletes(id,table){
			confirm_ = confirm('确定删除?');
			if(confirm_){
			//alert("id="+id+",table="+table);
				$.ajax({
					url:"/bg/delete.jsp?table="+table+"&id="+id,
					type:"POST",
					async : false,
					success:function(msg){
							alert("删除成功!");
							window.location.reload();
					}
			   	});
     		}
		}
  
		function update(id){
			<%
			Boolean b=CommonUtil.JudgeIsMoblie(request);
			if(b==false){%>
			window.location.href="/bg/opt.jsp?id="+id;
	   <%}else{%>
	   		window.location.href="/bg/opt_mobie.jsp?id="+id;
	   <%}%>
	   }
		
		function goLogin(){
			window.location.href="/";
		}
  </script>
</html>
