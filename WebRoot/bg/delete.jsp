<%@page import="com.tools.jdbc.SQLParameter"%>
<%@page import="com.tools.jdbc.ConnectionJDBC"%>
<%@page import="com.tools.common.CommonString"%>
<%@page import="com.tools.jdbc.JDBCTools"%>
<%@page import="java.sql.SQLException"%>

<%@page import="java.sql.Types"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	JDBCTools tools = null;
	String sql = "";
	String table = CommonString.getFormatPara(request.getParameter("table"));
	int id = CommonString.getFormatInt(request.getParameter("id"));

	int ret = 0;
	System.out.println("table="+table+",id="+id);
	if(!"".equals(table)&&id>=0){
		try {
			tools = new JDBCTools(new ConnectionJDBC().getConnection());
		
			SQLParameter[] param = new SQLParameter[1];
			param[0] = new SQLParameter(1, id, Types.INTEGER);
			
			sql = "delete from "+table+" where id=?";
			
			System.out.println(sql);
			ret = tools.executeUpdate(sql, param);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (tools != null){
				tools.closeRs();
				tools.closeConn();
			}
		}
		out.print(1);
	}
%>