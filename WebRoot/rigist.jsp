<%@page import="com.weixin.entity.actrainer.ActMember"%>
<%@page import="com.weixin.entity.pojo.AccessToken"%>
<%@page import="com.weixin.entity.pojo.Article"%>
<%@page import="java.sql.Types"%>
<%@page import="com.tools.jdbc.SQLParameter"%>
<%@page import="com.tools.jdbc.ConnectionJDBC"%>
<%@page import="com.tools.jdbc.JDBCTools"%>
<%@page import="com.weixin.util.CommonUtil"%>
<%@page import="com.tools.common.CommonString"%>
<%@page import="com.weixin.message.custom.CustomMessage"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.weixin.message.resp.TextMessage"%>
<%@page import="com.weixin.message.resp.NewsMessage"%>
<%@page import="com.weixin.util.MessageUtil"%>
<%
	//第三方用户唯一凭证  
	//体态大师订阅号
	String appId = "wx49b9ae4e9c6288fc";
	//体态大师订阅号
	String appSecret = "831ba42e721949d4b60fe7d5325b7cb7";
	AccessToken token=CommonUtil.getToken(appId, appSecret);
	int userId=CommonString.getFormatInt(request.getParameter("userId"));
	String baseScore[]=request.getParameterValues("bid");
	String bscore=CommonString.getString(baseScore);
	String otherScore[]=request.getParameterValues("oid");
	String oscore=CommonString.getString(otherScore);
	String faceScore[]=request.getParameterValues("fid");
	String fscore=CommonString.getString(faceScore);
	String ratings[]=request.getParameterValues("rating");
	
/* 	String beforeScore=CommonString.getFormatPara(request.getParameter("bscore"));
	String afterScore=CommonString.getFormatPara(request.getParameter("ascore")); */
	String suggest=CommonString.getFormatPara(request.getParameter("suggest"));
	
	JDBCTools tools=null;
	tools=new JDBCTools(new ConnectionJDBC().getConnection());
	SQLParameter[] param=new SQLParameter[7];
	param[0]=new SQLParameter(1,userId,Types.INTEGER);
	param[1]=new SQLParameter(2,bscore,Types.VARCHAR);
	param[2]=new SQLParameter(3,oscore,Types.VARCHAR);
	param[3]=new SQLParameter(4,fscore,Types.VARCHAR);
	param[4]=new SQLParameter(5,ratings[0],Types.VARCHAR);
	param[5]=new SQLParameter(6,ratings[1],Types.VARCHAR);
	param[6]=new SQLParameter(7,suggest,Types.VARCHAR);
	tools.execPrepareCall("{call tt_assess_info("+CommonUtil.createQuestionMark(7)+")}", param);
	
	List<ActMember> mlist=new ArrayList<ActMember>();
	SQLParameter[] param2=new SQLParameter[1];
	param2[0]=new SQLParameter(1,userId,Types.VARCHAR);
	mlist=(List<ActMember>)tools.findByPrepareCall("{call tt_getToUserName("+CommonUtil.createQuestionMark(1)+")}", param2, ActMember.class);
	if(mlist==null){
		mlist=new ArrayList<ActMember>();
	}

	String toUserName=mlist.get(0).getWeixinId();
	// 调用接口获取access_token  
	List<Article> articles=new ArrayList<Article>();
	Article article=new Article();
	String respContent="";
	article.setTitle("已对您上传的图片进行体态评估,请您点击查看详情！");
	article.setDescription(respContent);
	article.setUrl("http://wm.actrainer.com/assessment.jsp?toUserName="+toUserName+"&id="+userId);
	article.setPicUrl("https://mmbiz.qlogo.cn/mmbiz/0fYcooBRC1ibb8hrZjv4UfUIKgkbWXYHXyPPTCUvnughRTrsRibp1B0QP2sC7iciajkk0XUjfFMxwMboddCghPvyWQ/0");
	articles.add(article);	
	String jsonNewsMsg = CustomMessage.makeNewsCustomMessage(toUserName, articles);	
	//发送客服消息
	CustomMessage.sendCustomMessage(token.getToken(), jsonNewsMsg);		
	response.getWriter().print(1);
%>

