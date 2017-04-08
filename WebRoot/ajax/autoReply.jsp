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
	String toUserName=CommonString.getFormatPara(request.getParameter("toUserName"));
	// 调用接口获取access_token  
	List<Article> articles=new ArrayList<Article>();
		Article article=new Article();
		String respContent="点击查看详情";
		article.setTitle("感谢您上传图片，点击可以查看详情");
		article.setDescription(respContent);
		article.setUrl("http://wm.actrainer.com/demoDetail.jsp?toUserName="+toUserName);
		article.setPicUrl("https://mmbiz.qlogo.cn/mmbiz/0fYcooBRC1ibb8hrZjv4UfUIKgkbWXYHXe7evTZia1DiaHYdQyYTquHxpjeibJnGQgmibyjTmNIebENlyqIUMpoje9Q/0");
		articles.add(article);
		
		String jsonNewsMsg = CustomMessage.makeNewsCustomMessage(toUserName, articles);
		
		//发送客服消息
		CustomMessage.sendCustomMessage(token.getToken(), jsonNewsMsg);		

%>
