<%@page import="java.awt.image.RenderedImage"%>
<%@page import="com.tools.common.CommonString"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedInputStream"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>生成上传图片</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <%
		BufferedInputStream fileIn = new 
		BufferedInputStream(request.getInputStream()); 
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmss");
		String fn1 = request.getParameter("fileName1");
		String fn2 = request.getParameter("fileName2"); 
		String fn3 = request.getParameter("fileName3");
		String filePath1="";
		String filePath2="";
		String filePath3="";
		byte[] buf = new byte[1024];
		int len=0;
		if(fn1!=null){
			/* String time=sdf.format(new Date());
			int ran=(int)(Math.random()*9000+1000); */
			String picPath1="E:\\Workspace\\wm_wx\\WebRoot\\"+fn1;
			File file1 = new File(picPath1);
			//filePath1="/images/upload/" + time+ran+fn1.substring(fn1.lastIndexOf(".")); 
			BufferedOutputStream fileOut = new BufferedOutputStream(new FileOutputStream(file1)); 
 			while(true){
			       // 读取数据
			      int bytesIn = fileIn.read(buf, 0, 1024);
			      if (bytesIn == -1){
			         break;
			      }else{
			         fileOut.write(buf, 0, bytesIn); 
			      } 
			}
			fileOut.flush();
			fileOut.close();
		}
		
		if(fn2!=null){
/* 		String time=sdf.format(new Date());
			int ran=(int)(Math.random()*9000+1000); */
			String picPath2="E:\\Workspace\\wm_wx\\WebRoot\\" +fn2;
			File file2 = new File(picPath2);
			//filePath2="/images/upload/" + time+ran+fn2.substring(fn2.lastIndexOf(".")); 
			BufferedOutputStream fileOut = new BufferedOutputStream(new 	FileOutputStream(file2));
				while(true){
			       // 读取数据
			      int bytesIn = fileIn.read(buf, 0,1024);
				      if (bytesIn == -1){
				         break;
				      }else{
				         fileOut.write(buf, 0, bytesIn);
				      }
				}
				fileOut.flush();
				fileOut.close();
			}
		
		if(fn3!=null){
			/* String time=sdf.format(new Date());
			int ran=(int)(Math.random()*9000+1000); */
			String picPath3="E:\\Workspace\\wm_wx\\WebRoot\\"+fn3;
			File file3 = new File(picPath3);
			//filePath1="/images/upload/" + time+ran+fn1.substring(fn1.lastIndexOf(".")); 
			BufferedOutputStream fileOut = new BufferedOutputStream(new FileOutputStream(file3)); 
			while(true){
			       // 读取数据
			      int bytesIn = fileIn.read(buf, 0, 1024);
			      if (bytesIn == -1){
			         break;
			      }else{
			         fileOut.write(buf, 0, bytesIn); 
			      } 
			}   
			fileOut.flush();
			fileOut.close();
		}
%>
  </body>
  <script type="text/javascript">
  
  
  </script>
</html>
