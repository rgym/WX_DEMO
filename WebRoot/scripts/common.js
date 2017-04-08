$.ajaxSetup({cache:false});
var msie = /msie/.test(navigator.userAgent.toLowerCase());
/**
 * 通用JS
 */
var ACT = {
		//遮罩层状态
		overlayState : false,
		loginState : true,
		isOnSubmit:false,
		codeMessage:{
			errorTitle:"Oops，出错了",
			errorContent:"服务器开了一点小差，请刷新后重试..."
		},
		//通用变量定义
		code:{
			success : 1
			,error : 0
			,no_login : -1
			,verify_time:60
			,verify_cd_code : -1
			,verify_cd_ip_code : -2
		}
		,memberStatus : {
			isLogin : false,
			id : 0
		}
		,message:{
			success:'操作成功'
			,error:'操作失败'
			,editTip:'抵制低俗，文明上网，登录发言'
			,editLoginHtml: function (lineheight){
				return '<div style=" '+ ( lineheight ? "line-height:"+lineheight+";" : "") +'" class="replyHold">您需要登录后才可以回帖 |  <a href="javascript:;" onclick="ACT.loginWin()" class="colorblue">登录</a> </div>';// | <a href="/index?reg=1" class="colorblue">立即注册</a>
			}
		}
		,pageSetting : {
			num_display_entries:6
			,num_edge_entries:1
			,callback : function(){return true;}
		}
		,pageCenter : function(){
			$("#Pagination").css("float","left");
	    	var w = $("#Pagination").width();
	    	$("#Pagination").css("float","none");
	    	$("#Pagination").css("width",w+10);
	    	$("#Pagination").css("margin","0 auto");
		}
		,openProgress : function(obj){
			if(ACT.overlayState != true){
				ACT.overlayState = true;
				if(!obj || ACT.isEmpty(obj)){
					obj = '正在载入，请稍候...';
				}
				jQuery.jBox.tip(obj, 'loading');
			}
		}
		,closeProgress : function(){
			try{
				jQuery.jBox.closeTip();
				ACT.overlayState = false;
			}catch (e) {
				// TODO: handle exception
			}
		}
		,tip:function(text){
			$.jBox.tip(text);
		}
		,alert : function(obj){
			swal({   
				title: obj.title,   
				text: obj.text,   
				timer: 2000 
			});
		}
		,alertfind:function(text){
			alert(text);
		}
		,confirm  : function(text){
			return window.confirm(text);
		}
		,onerror : function(obj){
			swal({   
				title: obj.title,   
				text: obj.text,  
				type: "error",  
				timer: 2000 
			});
		}
		/**
		 * 处理图片不存在问题
		 */
		,f_default_img : function (){
			jQuery("img[src=''][user_face!=1][class!=noTest],img[src='null'][user_face!=1][class!=noTest]").attr("src","/images/default/60.png");
			jQuery("img[class!=noTest]").attr("onerror","this.onerror=null;this.src='/images/default/60.png'");
			jQuery("img[src=''][user_face=1],img[src='null'][user_face=1]").attr("src","/images/default/default_face.png");
			jQuery("img[user_face=1]").attr("onerror","this.onerror=null;this.src='/images/default/default_face.png'");
		}
		,isEmpty : function ( str ){
			str = jQuery.trim(str);
			return str == null || str == '';
		}
		,openWin : function (url,data){
			var defaultData = {
	    			title:null,
	    			buttons:{},
	    			showClose:false,
	    			showIcon:false
	    		}
			jQuery.each(data,function(i,v){
				defaultData[i] = v;
			})
			jQuery.jBox(url,defaultData);
		}
		,closeWin : function (token){
			if(token){
				parent.jQuery.jBox.close(token);
			}else{
				parent.jQuery.jBox.close();
			}
		}
		,loginWin : function(allowClose){
			ACT.loginState&&"0px"!=$("#loginalert").css("top") && (
				$("#loginalert").show(),
				$(".windowmask").fadeIn(500),
				$("#loginalert").animate({top:0},400,"easeOutQuart")
			)
			if(typeof allowClose != 'undefined' && allowClose == false){
				$(".closealert ").hide();
				$(".closehref").show(); 
			}
		},
		
		closeLoginWin:function(){
			ACT.loginState&&(
					k=!1,
					$("#loginalert").animate({top:-600},400,"easeOutQuart",function(){
						$("#loginalert").hide();
						k=!0
					})
					,$(".windowmask").fadeOut(500)
				)
		}
		,exit : function(){
			jQuery.ajax({
				url:'/reg/exit',
				success:function(){
					window.location.reload();
				},error:function(){
					noticeTipErr("系统错误","请刷新后重试...",2000);
				}
			})
		}
		,snsloginWin : function(){
			ACT.openWin('iframe:/login/index_iframe',{
				width:390,
				height:365,
				top:'10%',
				border:0
			});
		}
		,snsLogin : function(type){
			ACT.closeWin();
			var widths = "430";
			var heights = "300";
			var url = "";
			if(type == 'qq'){
				url = "/snsTools/qqLogin";
			}else if(type == "weibo"){
				url = "/snsTools/wbLogin";
			}
			if(url!=""){
				ACT.openWin("iframe:"+url,{
					width:730,
					height:430,
					top:50,
					border:0,
					showClose:true,
					id:"snsWindow"
				});
			}
			
			
			//window.open(url,'snsWindow','height=400,width=730,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		}
		,qqBind : function(){
			
		}
		,filterHtml : function(str,length){
			str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
			str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
			str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
			if(length && length != '' && length != null){
				str = str.substring(0,length);
			}
			return str;
		}
		,addBeforeReload : function(text){
			if(text){
				//'未保存的内容将会丢失，确认要离开吗？'
				window.onbeforeunload  = function(){
				    return text;
				}
			}
		}
		,delBeforeReload : function (){
			window.onbeforeunload = null;
		}
		,getWindowUrl : function(){
			var s = window.location.pathname+window.location.search;
			s = encodeURIComponent(s);
			return s;
		}
		,getTimeRandom : function (){
			return new Date().getTime();
		}
		,getSmallImg : function(url){
			if(url){
				var _i = url.lastIndexOf("/");
				if(_i != 0){
					return url.substring(0,_i)+"/small"+url.substring(_i,url.length);
				}
			}
			return '';
		}
		,getFormateString : function (str){
			if(str && str != null && str != 'null'){
				return str;
			}
			return "";
		}
		,parseDate: function(date){
			return new Date(Date.parse(date.replace(/-/g,"/")));
		}
		/**
		 * 监听input的回车事件,执行事件监听节点的onclick事件
		 */
		,initEnterEvent : function(inputClass,eventClass){
			jQuery(inputClass).keydown(function(e){
				// 这个判断是为了兼容所有浏览器，使 e 能被所有浏览器所解析
			    if(!e) var e = window.event;  
			    // 这里就是要执行的方法体，其中 e 就是键盘对象
			    // 其中 e.keyCode（Code中C一定要大写） 就是按下的键的键值 
			    if(e.keyCode == 13){
			    	var eventId = jQuery(this).attr("event-id");
			    	var ec = jQuery(eventClass+"[event-id="+eventId+"]");
			    	if(ec != null){
			    		var ev = ec.attr("onclick");
			    		if(ev && ev != null){
			    			eval(ev);
			    		}
			    	}
			    }
			})
		}
		,commonSearch : function(url,keyWord,isNewWindow){
			keyWord = keyWord ? keyWord : "";
			isNewWindow = isNewWindow ? isNewWindow : false;
			if(!ACT.isEmpty(url) && !ACT.isEmpty(keyWord)){
				if(isNewWindow){
					window.open(url+keyWord);
				}else{
					window.location.href=url+keyWord;
				}
			}
		}	
		,addPlaceHolder : function(setting){
			var className = setting.className;//增加监听的input
			var focusName = setting.focusName;//input焦点增加的class
			var parentName = setting.parentName;//input焦点时第一个父节点增加的class
			var onInputParent = setting.onInputParent;//input 输入时如果不为空则改变父节点
			$("."+className).focus(function(){
				$(this).addClass(focusName);
				$(this).parent(":first").addClass(parentName);
			})
			$("."+className).focusout(function(){
				if(ACT.isEmpty($(this).val())){
					$(this).removeClass(focusName);
					$(this).parent(":first").removeClass(parentName);
				}
			})
			var listenerEvent = function(){
				if(ACT.isEmpty($(this).val())){
					$(this).parent(":first").addClass(onInputParent);
				}else{
					$(this).parent(":first").removeClass(onInputParent);
				}
			}
			$("."+className).keydown(listenerEvent);
			$("."+className).keyup(listenerEvent);
			//设置自动填充监听
			setTimeout(function(){
				$("."+className).each(function(){
					if(!ACT.isEmpty($(this).val())){
						$(this).parent(":first").removeClass(onInputParent);
					}
				})
			},1000)
		}
		,hideP : function(className){
			$(className).each(function (i) {
				var divH = $(this).height();
				var $p = $("p", $(this)).eq(0);
				while ($p.outerHeight() > divH) {
					$p.text($p.text().replace(/(\s)*([a-zA-Z0-9]+|\W)(\.\.\.)?$/, "..."));
				};
			});
		}
		,loadJS : function (url,callback,el){
			/**异步加载JS的方法*/
			var isIE6 = !!window.ActiveXObject && !window.XMLHttpRequest;
			var script = document.createElement("script"),
				head = isIE6 ? document.documentElement : document.getElementsByTagName("head")[0];
			script.type = "text/javascript";
			script.async = true;
			if(script.readyState){
				script.onreadystatechange=function(){
					if(script.readyState=="loaded"||script.readyState=="complete"){
						script.onreadystatechange = null;
						if (callback) {
							callback();
						}
					}
				}
			}else{
				script.onload=function(){
					if (callback) {
						callback();
					}
				}
			}
			script.src = url;
			if (el) {
				document.getElementById(el).appendChild(script);
			} else {
		    	head.insertBefore(script, head.firstChild);
			}
		}
}

function loginTimeout(text,isNotShowCancel){
	if(!text){
		text = "您的回复已保存在本地缓存，重新登录后请于编辑器工具栏加载草稿箱内容。";
	}
	swal({
		title: "您的登录信息已失效",   
		text: text,   
		type: "warning",   
		confirmButtonText: "马上登录",
        showCancelButton: !isNotShowCancel,
		closeOnConfirm: true
	}, function(isConfirm){
		ACT.loginWin();
	});
}

jQuery(function(){
	ACT.f_default_img();
	ACT.initEnterEvent(".event_input",".event_obj");
})

/**
 * 文字长度监听
 * @param obj
 * @param checklen
 * @param maxlen
 */

function strLenCalc(obj, checklen, maxlen) {
	var v = obj.value, charlen = 0, maxlen = !maxlen ? 200 : maxlen, curlen = maxlen, len = strlen(v);
	for(var i = 0; i < v.length; i++) {
		if(v.charCodeAt(i) < 0 || v.charCodeAt(i) > 255) {
			curlen -=  0 ;
		}
	}
	if(curlen >= len) {
		$(checklen).html(curlen - len);
	} else {
		obj.value = mb_cutstr(v, maxlen, 0);
	}
}

function mb_cutstr(str, maxlen, dot) {
	var len = 0;
	var ret = '';
	var dot = !dot ? '...' : dot;
	maxlen = maxlen - dot.length;
	for(var i = 0; i < str.length; i++) {
		len += str.charCodeAt(i) < 0 || str.charCodeAt(i) > 255 ? 3 : 1;
		if(len > maxlen) {
			ret += dot;
			break;
		}
		ret += str.substr(i, 1);
	}
	return ret;
} 

function strlen(str) {
	return (msie && str.indexOf('\n') != -1) ? str.replace(/\r?\n/g, '_').length : str.length;
}

/**
 * 关注用户
 * @param data
 * @returns {Boolean}
 */
function addAttention(data){
	var memberId = parseInt(data.memberId);
	if($.isNumeric(memberId)){
		if(ACT.memberStatus.isLogin){
			if(memberId == ACT.memberStatus.id){
				noticeTipErr("关注失败", "不能关注自己哦...", 2000);
				return false;
			}
			$.ajax({
				url:"/user/attention",
				data:{"attention.followMemberId":memberId},
				success:function(r){
					if(data.callBack){
						data.callBack(r);
					}
				},error:function(){
					noticeTipErr("出错啦", "关注失败了，请稍后再试...", 2000);
				}
			})
		}else{
			ACT.loginWin(true);
		}
		
	}
}

function addAttentionCancel(data){
	var memberId = parseInt(data.memberId);
	if($.isNumeric(memberId)){
		if(ACT.memberStatus.isLogin){
			$.ajax({
				url:"/user/attentionCancel",
				data:{"attention.followMemberId":memberId},
				success:function(r){
					if(data.callBack){
						data.callBack(r);
					}
				},error:function(){
					noticeTipErr("出错啦", "取消关注失败了，请稍后再试...", 2000);
				}
			})
		}else{
			ACT.loginWin(true);
		}
		
	}
}


/**
* 添加收藏的按钮监听
*/
function setCollectClick(obj){
	obj.click(function(){
    	var _this = $(this);
    	memberOpSave({
    		name:$(this).attr("obj-name"),
    		type:$(this).attr("obj-type"),
    		id:$(this).attr("obj-id"),
    		opType:$(this).attr("op-type"),
    		callBack:function(data){
    			if(data.resultEntity.resultId == ACT.code.success){
					noticeTipSuc("收藏成功","",2000);
					_this.removeClass("collectBtn");
	    			_this.addClass("collectCancelBtn");
	    		    _this.unbind("click");
	    			setCollectCancelClick(_this);
	    			_this.html("已收藏");
				}else if(data.resultEntity.resultId == ACT.code.no_login){
					ACT.loginWin();
				}else{

					ACT.alert({
						title:"已经收藏过了"
					})
				}
    		}
    	})
    });
}
/**
* 添加移除收藏的按钮监听
*/
function setCollectCancelClick(obj){
	obj.click(function(){
		var _this = $(this);
		memberOpCancel({
    		type:$(this).attr("obj-type"),
    		id:$(this).attr("obj-id"),
    		opType:$(this).attr("op-type"),
    		callBack:function(data){
    			if(data.resultEntity.resultId == ACT.code.success){
					noticeTipSuc("取消收藏成功","",2000);
					_this.removeClass("collectCancelBtn");
	    			_this.addClass("collectBtn");
	    		    _this.unbind("click");
	    		    setCollectClick(_this);
	    		    _this.unbind("mouseenter mouseleave");
	    			_this.html("+收藏");
				}else if(data.resultEntity.resultId == ACT.code.no_login){
					ACT.loginWin();
				}else{
					ACT.alert({
						title:"未收藏过此信息"
					})
				}
    		}
    	})
    }); 
	obj.hover(function() {
    	  $(this).html("取消");
	},function(){
    	  $(this).html("已收藏");
	});
}



/**
 * 用户收藏
 */
function memberOpSave(obj){
	if(!ACT.memberStatus.isLogin){
		ACT.loginWin();
		return false;
	}
	jQuery.ajax({
		url:'/user/collectAdd',
		data:{'collect.objId':obj.id,'collect.objName':obj.name,'collect.objType':obj.type,'collect.opType':obj.opType,'collect.opId':obj.opId},
		dataType:'JSON',
		success:function(data){
			if(data && data.resultEntity){
				obj.callBack(data);
			}else{
				noticeTipErr("系统错误，请稍后再试！","",2000);
			}
		},error:function(data){
			noticeTipErr("系统错误，请稍后再试！","",2000);
		}
	})
}


function memberOpCancel(obj){
	if(!ACT.memberStatus.isLogin){
		ACT.loginWin();
		return false;
	}
	jQuery.ajax({
		url:'/user/collectCancel',
		data:{'collect.objId':obj.id,'collect.objType':obj.type,'collect.opType':obj.opType},
		dataType:'JSON',
		success:function(data){
			if(data && data.resultEntity){
				obj.callBack(data);
			}else{
				noticeTipErr("系统错误，请稍后再试！","",2000);
			}
		},error:function(data){
			noticeTipErr("系统错误，请稍后再试！","",2000);
		}
	})
}


/**
 * 滚动跟随浮动
 */
function followScroll (mark,topPx){
	if(!topPx){
		topPx = 0;
	}
	if (!isie6()) { 
	    var rollStart = $(mark), 
	    rollSet = $(mark); 
	    var offset = rollStart.offset(), 
	    objWindow = $(window), 
	    rollBox = rollStart.prev(); 
	    if (objWindow.width() > 960) {
	        objWindow.scroll(function() { 
	            if (objWindow.scrollTop() > (offset.top-topPx)) { 
	                rollStart.css('position','fixed'); 
	                rollStart.stop().animate({ 
	                    top: topPx 
	                }, 
	                400);
	            } else { 
	                rollStart.css('position','static'); 
	                rollStart.stop().animate({ 
	                    top: 0 
	                }, 
	                400) 
	            } 
	        }) 
	    } 
	} 
}

function isie6() { 
	try {
	   if ($.browser.msie) { 
	        if ($.browser.version == "6.0") return true; 
	    } 
	} catch (e) {
		
	}
	return false; 
} 

var per_search_key = '';
/**
 * dataInfo.obj_name 增加监听的objname
 * dataInfo.url 请求路径
 * dataInfo.result_content 存放结果的UL
 * dataInfo.parent_div 父节点显示隐藏的DIV
 * dataInfo.result_name 返回list信息的name
 * dataInfo.link_to 跳转路径 __id__为替换的ID
 * @param dataInfo
 */
function addSearchEvent(dataInfo){
	$(dataInfo.obj_name).keyup(function(){
    	var keyword = $(this).val();
    	if($.trim(keyword) != '' && per_search_key != keyword){
    		per_search_key = keyword;
	    	$.ajax({
	    		url:dataInfo.url,
	    		data:{'searchEntity.keyWord':keyword},
	    		success:function(data){
	    			var resultContent = '';
	    			if(data[dataInfo.result_name].length > 0){ //foodNutritionsList.length
	    				for(var i = 0 ; i < data[dataInfo.result_name].length; i++){
	    					var _i = data[dataInfo.result_name][i];
	    					if(_i.id && _i.name){
	    						resultContent += '<li><a href="'+dataInfo.link_to.replace("__id__",_i.id)+'"  target="_blank" title="'+_i.name+'">'+_i.name+'</a></li>';
	    					}
	    				}
	    				if( ( dataInfo.moreLink && data.pageEntity.totalCount > data[dataInfo.result_name].length )){
	    					var ml =  dataInfo.moreLink;
	    					if(ml.indexOf("?")!=-1){
	    						ml += "&";
	    					}else{
	    						ml += "?";
	    					}
	    					ml += "searchEntity.keyWord=" +  keyword;
	    					resultContent += '<li style="text-align:center;background: #eee;"><a  href="'+ml+'"  target="_blank" title="点击查看更多">点击查看更多</a></li>';
	    				}
	    			}
	    			if(resultContent == ''){
	    				resultContent = '<li><a>暂无搜索结果</a></li>';
	    			}
	    			$(dataInfo.result_content).html(resultContent);
	    			$(dataInfo.parent_div).show();
	    		}
	    	})
    	}else{
    		per_search_key = keyword;
    		$(dataInfo.parent_div).hide();
    	}
    });
}

var uploadFileExts = {
	image:"*.gif;*.jpg;*.jpeg;*.png;*.bmp",
	file:"*.doc;*.docx;*.xls;*.xlsx;*.ppt;*.txt;*.zip;*.rar"
}

/**
 * data / id / multi / fileType / fun / jsessionid
 * @param data
 */
function getUploadElement(data){
	var dataSize =  data.size ? data.size : 2*1024;
	var id = "";
	if(data.id.indexOf("#") == -1 && data.id.indexOf(".") == -1){
		id = "#"+data.id;
	}else{
		id = data.id;
	}
	$(id).uploadify({
        'uploader':'/upload/uploadAction'+(data.jsessionid ? ';jsessionid='+data.jsessionid : ''),
        'swf': '/js/jQuery/uploadify/uploadify.swf',
        'cancelImage': '/js/jQuery/uploadify/cancel.png',
        'queueID':  data.queueId ? data.queueId : 'fileQueue',
        'successTimeout':60*1000,
        'multi': data.multi ? data.multi : false,
        'buttonImage': data.buttonImage ? data.buttonImage : null,
        'width':data.width ? data.width : 120,
        'height':data.height ? data.height : 30,
		//在浏览窗口底部的文件类型下拉菜单中显示的文本
        'fileTypeDesc':'支持的格式：',
        //允许上传的文件后缀
        'fileTypeExts': uploadFileExts[data.fileType] ? uploadFileExts[data.fileType] : uploadFileExts['image'],
        'buttonText': data.buttonText ? data.buttonText : '文件上传',
        'formData': data.data ? data.data : { 'itFileType': data.fileType ? data.fileType : "image"},
        'auto':true,
        'queueSizeLimit':data.count ? data.count : 1,
        'fileSizeLimit' : data.size ? data.size : 2*1024,
        'onComplete': function (file, data, response) {
        	noticeTipSuc("上传成功","文件上传已完成",2000);
        },
        //选择上传文件后调用
        'onSelect' : function(file) {
        	if(data.select){
        		data.select(file) 
        	}
        },
        'onDialogOpen' : function() {//当选择文件对话框打开时触发
    	　if(data.onDialogOpen){
        		data.onDialogOpen() 
        	}　
        },
        'onDialogClose' : function(swfuploadifyQueue){
        	if(data.onDialogClose){
        		data.onDialogClose(swfuploadifyQueue) 
        	}　
        },
        //返回一个错误，选择文件的时候触发
        'onSelectError':function(file, errorCode, errorMsg){
            switch(errorCode) {
                case -100:
                    noticeTipErr("上传失败","只能上传单个文件",0);
                    break;
                case -110:
                	 noticeTipErr("上传失败","文件大小超出"+dataSize/1024+"MB！",0);
                    break;
                case -120:
               	 noticeTipErr("上传失败","文件大小异常！",0);
                    break;
                case -130:
                  	 noticeTipErr("上传失败","文件类型不正确！",0);
                    break;
            }
        },
        //检测FLASH失败调用
        'onFallback':function(){
            var isGO = confirm("您未安装FLASH控件，无法上传图片！是否现在去下载？");
            if(isGo){
            	window.open("http://get.adobe.com/cn/flashplayer/");
            }
        	noticeTipErr("上传失败","缺少必需的FLASH控件",0);
        },
        //上传到服务器，服务器返回相应信息到data里
        'onUploadSuccess':function(file, res_data, response){
        	data.fun(res_data)
        }
    });
}

String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) { 
	　 if (!RegExp.prototype.isPrototypeOf(reallyDo)) { 
	return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith); 
	} else { 
	return this.replace(reallyDo, replaceWith); 
	} 
	} 

/**
 * 提示框
 */
function noticeTipSuc(title,content,timeout){
	swal({
		title: title,   
		text: content,   
		timer: timeout,
		type:"success"
	});
}

function noticeTipErr(title,content,timeout){
	swal({
		title: title,   
		text: content,   
		timer: timeout,
		type:"error"
	});
}

function noticeTipInfo(title,content,timeout){
	swal({
		title: title,   
		text: content,   
		timer: timeout,
		type:"info"
	});
}
function noticeTipLoading(title,time){
	if(!time){
		time = 0;
	}
	swal({title: title,showConfirmButton: false,timer:time});
}