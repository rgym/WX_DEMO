<%@page import="com.tools.common.CommonString"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>ACTrainer社区</title>

    <!-- Sets initial viewport load and disables zooming  -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">

    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!-- Include the compiled Ratchet CSS -->
    <link href="/scripts/ratchet-2.0.2/dist/css/ratchet.css" rel="stylesheet">

    <!-- Include the compiled Ratchet JS -->
     <script src="/scripts/ratchet-2.0.2/dist/js/ratchet.min.js"></script>
    
     <link href="/css/food/index.css" type='text/css' rel='stylesheet'  />
     <link href="/scripts/sweetalert/sweet-alert.css" type='text/css' rel='stylesheet'  />

  </head>
  <body>
	<%	
			String toUserName=CommonString.getFormatPara(request.getParameter("toUserName"));
			String fromUserName=CommonString.getFormatPara(request.getParameter("fromUserName"));
			String openId=CommonString.getFormatPara(request.getParameter("openId"));
			String nickName=CommonString.getFormatPara(request.getParameter("nickName"));
			int sex=CommonString.getFormatInt(request.getParameter("sex"));
			String area=CommonString.getFormatPara(request.getParameter("area"));
	%> 
    <!-- Make sure all your bars are the first things in your <body> -->

    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
	<header class="bar bar-nav">
 		<h1 class="title">上传图片</h1>
	</header>

    <div class="content">
  		<div class="card">
    		<div>
    		<form action="/DemoServlet" id="foodForm">
	    		<div class="foodForm">		
  	    		<input type="hidden" name="toUserName" value=" <%=toUserName%> " />
	    		<input type="hidden" name="openId" value=" <%=openId%> " />
	    		<input type="hidden" name="nickName" value=" <%=nickName%> " />
	    		<input type="hidden" name="sex" value=" <%=sex%> " />
	    		<input type="hidden" name="area" value=" <%=area%> " />
	    			<div  style="text-align: center;">
						<img alt="上传样例" src="/images/upload_pic_demo.jpg">
						<span style="color: red;">请按上图姿势，拍摄上传 3 张全身照片，要求：穿紧身衣服；自然放松站立；双脚并拢（头部也是评估内容之一）</span>
					</div>

	    			<ul>
	    				<li class="li_left">
	    					<p class="upload_li">正面图</p>
	    				<li>
	    				<li class="li_right" style="height: 112px;">
    						<div class="rightcontent">
	    						<input  type="file" accept="image/*" capture="camera" name="file1"  dataType="*" />
	    						<input type="hidden" name="picture1" value="" id="img1" dataType="*" /> 
    						</div>
	    				<li>
	    				<li class="li_left">
	    					<p class="upload_li">侧面图</p>
	    				<li>
	    				<li class="li_right" style="height: 112px;">
    						<div class="rightcontent">
	    						<input  type="file" accept="image/*" capture="camera" name="file2"  dataType="*" />
	    						<input type="hidden" name="picture2" value="" id="img2" dataType="*" /> 
    						</div>
	    				<li>
	    				
	    				<li class="li_left">
	    					<p class="upload_li">背面图</p>
	    				<li>
	    				<li class="li_right" style="height: 112px;">
    						<div class="rightcontent">
	    						<input  type="file" accept="image/*" capture="camera" name="file3"  dataType="*" /> 						
	    						<input type="hidden" name="picture3" value="" id="img3" dataType="*" /> 
    						</div>
	    				<li>			
	    			</ul>
	    			<input type="text" name="email"  placeholder="请输入您的常用邮箱" dataType="*">
	    			<br>
	    			<span style="color: red;">邮箱（重要知用，请务必准确填写） </span>
   					<button class="btn btn-primary btn-block btn-outlined"  id="submit" onclick="submitFood();">提交信息</button>
	    		</div>
    		</form>
    		</div>
    	</div>
    </div>

  </body>
  	  <script src="/scripts/jquery-1.8.3.min.js"></script>
  	  <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	  <script type="text/javascript" src="/scripts/sweetalert/sweet-alert.js"></script>
	  <script type="text/javascript" src="/scripts/validform/Validform_v5.3.2.js"></script>
      <script type="text/javascript">
	
    	function submitFood(){
	    		var form = document.forms["foodForm"];
    			if (form["file1"].files.length > 0){
	    			var file1 = form["file1"].files[0];
	    			if(file1.size>1024*1024){
	    				alert("您上传的正面图过大，您可以用截图工具处理后上传");
	    				$("#img1").val("");
	    			}else{
	    		 	var d1 = new Date().format('yyyyMMddhhmmssSS');
	        		var filePath1="/images/image/" + d1+(file1.name).substring((file1.name).lastIndexOf("."));
	        		$("#img1").val(filePath1);
	    			}
    			}
    			if(form["file2"].files.length > 0){
	        		var file2 = form["file2"].files[0];
	        		if(file2.size>1024*1024){
	        			alert("您上传的侧面图过大，您可以用截图工具处理后上传");
	        			$("#img2").val("");
	        		}else{
	    		 	var d2 = new Date().format('yyyyMMddhhmmssSS');
	        		var filePath2="/images/image/" + d2+(file2.name).substring((file2.name).lastIndexOf("."));
	        		$("#img2").val(filePath2);
	        		}
    			}
    			if (form["file3"].files.length > 0){
	        		var file3 = form["file3"].files[0];
	        		if(file3.size>1024*1024){
	        			alert("您上传的背面图过大，您可以用截图工具处理后上传");
	        			$("#img3").val("");
	        		}else{
	    		 	var d3 = new Date().format('yyyyMMddhhmmssSS');
	        		var filePath3="/images/image/" + d3+(file3.name).substring((file3.name).lastIndexOf("."));
	        		$("#img3").val(filePath3);
	        		}
    			}
    		if(vl.check()){
	    		uploadAndSubmit1();
	    		uploadAndSubmit2();
	    		uploadAndSubmit3();
    			vl.submitForm();	
    		}else{
    			noticeTipErr("信息不完整","请检查所填信息");
    		}
    	}
    	var vl = $("#foodForm").Validform({
    		ajaxPost:true,
    		tiptype:function(msg,o,cssctl){
		},
    		ajaxpost:{
    			success:function(data){
    				noticeTipSuc("保存成功","感谢您的上传，请等待我们审核。谢谢合作！",500);
    				autoReply();
    			},error:function(d1, d2){
    				noticeTipErr("出错了！","系统错误，请刷新后尝试...",2000);
    			}
    		}
    	});
    	
    	Date.prototype.format = function(format){ 
    	       var date = { 
    	              "M+": this.getMonth() + 1, 
    	              "d+": this.getDate(), 
    	              "h+": this.getHours(), 
    	              "m+": this.getMinutes(), 
    	              "s+": this.getSeconds(),
    	              "q+": Math.floor((this.getMonth() + 3) / 3), 
    	              "S+": this.getMilliseconds() 
    	       }; 
    	       if (/(y+)/i.test(format)){ 
    	              format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length)); 
    	       } 
    	       for (var k in date) { 
    	              if (new RegExp("(" + k + ")").test(format)) { 
    	                     format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? date[k] : ("00" + date[k]).substr(("" + date[k]).length)); 
    	              } 
    	       } 
    	       return format;
    	} 
    	
		function uploadAndSubmit1(){
    		var form = document.forms["foodForm"];
			if (form["file1"].files.length > 0){
    		 	// 寻找表单域中的 <input type="file" ... /> 标签
    		 	var file1 = form["file1"].files[0];
    		 /*	var d = new Date().format('yyyyMMddhhmmssSS');
        		var filePath1="/images/image/" + d+(file1.name).substring((file1.name).lastIndexOf("."));
        		$("#img1").val(filePath1); */
        		var filePath1=$("#img1").val();
    			 // try sending
    			var reader = new FileReader();
    		 	reader.onloadstart = function(){
    			 // 这个事件在读取开始时触发
    		 	console.log("onloadstart");
    		 	//document.getElementById("bytesTotal").textContent = file.size;
    			}
				reader.onprogress = function(p){
    			// 这个事件在读取进行中定时触发
    			console.log("onprogress");
    			// document.getElementById("bytesRead").textContent = p.loaded;
    		 	}
    			reader.onload = function(){
    		    // 这个事件在读取成功结束后触发
    		 	console.log("load complete");
    		 	}
    			reader.onloadend = function(){
    		    	// 这个事件在读取结束后，无论成功或者失败都会触发
    				if(reader.error){
    		 			console.log(reader.error);
    		 		}else{
		    			// 构造 XMLHttpRequest 对象，发送文件 Binary 数据
    		 			var xhr = getXmlHttp();
    		 			xhr.open(
    		 				/* method */ "POST",
    		 				/* target url */ "/uploadDemo.jsp?fileName1=" + filePath1
    		 				/*, async, default to true */
    		 			);
    					xhr.overrideMimeType("application/octet-stream");
    		 			console.log("upload ");
    		 			xhr.sendAsBinary(reader.result);
	    		 		xhr.onreadystatechange = function(){
	    					if(xhr.readyState == 4){
	    		 				if(xhr.status == 200){
	    		 					console.log("upload complete");
	    		 					console.log("response: " + xhr.responseText);
	    						}
	    					}
	    				}
    				}
    		 	}
   		 		reader.readAsBinaryString(file1);	
			}	
		}
		
		function uploadAndSubmit2(){
    		var form = document.forms["foodForm"];
			if (form["file2"].files.length > 0){
    		 	// 寻找表单域中的 <input type="file" ... /> 标签
	   		 	var file2 = form["file2"].files[0];
    	 /*	 	var d = new Date().format('yyyyMMddhhmmssSS');
        		var filePath2="/images/image/" + d+(file2.name).substring((file2.name).lastIndexOf("."));
        		$("#img2").val(filePath2); */
        		var filePath2=$("#img2").val();
    			 // try sending
    			var reader = new FileReader();
    		 	reader.onloadstart = function(){
    			 // 这个事件在读取开始时触发
    		 	console.log("onloadstart");
    		 	//document.getElementById("bytesTotal").textContent = file.size;
    			}
				reader.onprogress = function(p){
    			// 这个事件在读取进行中定时触发
    			console.log("onprogress");
    			// document.getElementById("bytesRead").textContent = p.loaded;
    		 	}
    			reader.onload = function(){
    		    // 这个事件在读取成功结束后触发
    		 	console.log("load complete");
    		 	}
    			reader.onloadend = function(){
    		    	// 这个事件在读取结束后，无论成功或者失败都会触发
    				if(reader.error){
    		 			console.log(reader.error);
    		 		}else{
		    			// 构造 XMLHttpRequest 对象，发送文件 Binary 数据
    		 			var xhr = getXmlHttp();
    		 			xhr.open(
    		 				/* method */ "POST",
    		 				/* target url */ "/uploadDemo.jsp?fileName2=" + filePath2
    		 				/*, async, default to true */
    		 			);
    					xhr.overrideMimeType("application/octet-stream");
    		 			console.log("upload ");
    		 			xhr.sendAsBinary(reader.result);
	    		 		xhr.onreadystatechange = function(){
	    					if(xhr.readyState == 4){
	    		 				if(xhr.status == 200){
	    		 					console.log("upload complete");
	    		 					console.log("response: " + xhr.responseText);
	    						}
	    					}
	    				}
    				}
    		 	}
   		 		reader.readAsBinaryString(file2);	
			}	
		}
		
		function uploadAndSubmit3(){
    		var form = document.forms["foodForm"];
			if (form["file3"].files.length > 0){
    		 	// 寻找表单域中的 <input type="file" ... /> 标签
    		 	var file3 = form["file3"].files[0];
    		 	//var d = new Date().format('yyyyMMddhhmmssSS');
        		//var filePath3="/images/image/" + d+(file3.name).substring((file3.name).lastIndexOf("."));
        		//$("#img3").val(filePath3); 
        		var filePath3=$("#img3").val();
    			 // try sending
    			var reader = new FileReader();
    		 	reader.onloadstart = function(){
    			 // 这个事件在读取开始时触发
    		 	console.log("onloadstart");
    		 	//document.getElementById("bytesTotal").textContent = file.size;
    			}
				reader.onprogress = function(p){
    			// 这个事件在读取进行中定时触发
    			console.log("onprogress");
    			// document.getElementById("bytesRead").textContent = p.loaded;
    		 	}
    			reader.onload = function(){
    		    // 这个事件在读取成功结束后触发
    		 	console.log("load complete");
    		 	}
    			reader.onloadend = function(){
    		    	// 这个事件在读取结束后，无论成功或者失败都会触发
    				if(reader.error){
    		 			console.log(reader.error);
    		 		}else{
		    			// 构造 XMLHttpRequest 对象，发送文件 Binary 数据
    		 			var xhr = getXmlHttp();
    		 			xhr.open(
    		 				/* method */ "POST",
    		 				/* target url */ "/uploadDemo.jsp?fileName3=" + filePath3
    		 				/*, async, default to true */
    		 			);
    					xhr.overrideMimeType("application/octet-stream");
    		 			console.log("upload ");
    		 			xhr.sendAsBinary(reader.result);
	    		 		xhr.onreadystatechange = function(){
	    					if(xhr.readyState == 4){
	    		 				if(xhr.status == 200){
	    		 					console.log("upload complete");
	    		 					console.log("response: " + xhr.responseText);
	    						}
	    					}
	    				}
    				}
    		 	}
   		 		reader.readAsBinaryString(file3);
			}	
		}
		
		


    	function getXmlHttp(){
    	    var xmlHttp = null;
    	    if (window.XMLHttpRequest){
    	        //针对FirFox，Mozilla，Opera，Safari，IE7，IE8
    	        xmlHttp = new XMLHttpRequest();
    	        if (xmlHttp.overrideMimeType){
    	            //针对Mozilla不同版本差别
    	            xmlHttp.overrideMimeType("text/xml");
    	        }
    	    }else if (window.ActiveXObject){
    	        var activexml = [ "MSXML2.XMLHTTP", "Microsoft.XMLHTTP" ];
    	        for ( var i = 0; i < activexml.length; i++){
    	            try{
    	                //取出一个空间进行创建，如果创建成功，则终止
    	                //如果创建失败，回抛出异常，然后继续循环，继续创建
    	                xmlHttp = new ActiveXObject(activexml[i]);
    	                break;
    	            }catch (e){

    	            }
    	        }
    	    }
    	    return xmlHttp;
    	}
    	 
    	function processRenderer(byteLoaded, byteTotal,td_file){
    	    var percent = byteLoaded / byteTotal;
    	    td_file.style.width = parseInt(percent * 100) +"%";
    	    //alert(parseInt(percent * 100) +"%");
    	}
    	//chrome浏览器下面的XMLHttpRequest没有sendAsBinary,所以就自己给XMLHttpRequest原型定义一个这样的属性，并且这个属性是一个方法  
    	if(!XMLHttpRequest.prototype.sendAsBinary){//如果XMLHttpRequest没有sendAsBinary
    	  XMLHttpRequest.prototype.sendAsBinary = function(datastr){
    	    function byteValue(x){
    	      return x.charCodeAt(0) & 0xff;
    	    }
    	    var ords = Array.prototype.map.call(datastr, byteValue);
    	    var ui8a = new Uint8Array(ords);
    	    this.send(ui8a.buffer);
    	  };
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
      	function autoReply(){
      		jQuery.ajax({
    			url:"/ajax/autoReply.jsp?toUserName=<%=toUserName%>",
    			dataType:"text",
    		  	async: false,
    			success:function(data){
    				wx.closeWindow();
    			}
    		})
      	}
    	
    </script>
</html>