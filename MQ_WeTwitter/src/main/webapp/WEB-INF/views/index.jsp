<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>叽叽喳喳</title>
    <meta name="keywords" content="叽叽喳喳聊天平台">
    <meta name="description" content="叽叽喳喳聊天平台">
    <link rel="shortcut icon" href="../statics/img/favicon.ico"> <link href="../statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="../statics/css/font-awesome.min.css" rel="stylesheet">
    <link href="../statics/css/plugins/jsTree/style.min.css" rel="stylesheet">
    <link href="../statics/css/animate.min.css" rel="stylesheet">
    <link href="../statics/css/style.min.css" rel="stylesheet">
    <link href="../statics/css/index.css" rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">

        <div class="row">
            <div class="col-sm-12">

                <div class="ibox chat-view">

                    <div class="ibox-title">
                        <!-- <small class="pull-right text-muted">最新消息：2015-02-02 18:39:23</small> 聊天窗口 -->
	                    	<button type="button" class="indexSearchBtn btn btn-default btn-sm" id="friendSearchBtn" onclick="javascript:;">
	                                        	搜索 <i class="fa fa-search"></i> </button>
	                    	<input type="text" class="indexSearchContent form-control" name="userName" placeholder="请输入账号">
	                    	<a class="indexAdd btn btn-primary pull-right btn-sm" href="#"  role="button" onclick="showAddFrindBox()"><i class="fa fa-plus"></i>好友</a>
	                     	<a class="indexAdd btn btn-primary pull-right btn-sm" href="#"  role="button" onclick="showAddGroupBox()"><i class="fa fa-plus"></i>群组</a>                        
	                                             聊天窗口
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-md-9 ">
                                <div class="chat-discussion" id="chat-dis">
                                	<p>未选择聊天</p>
                                    <!-- 
                                    <div class="chat-message">
                                        <img class="message-avatar" src="../statics/img/a4.jpg" alt="">
                                        <div class="message">
                                            <a class="message-author" href="#"> 林依晨Ariel </a>
                                            <span class="message-date">  2015-02-02 11:12:36 </span>
                                            <span class="message-content">
											jQuery表单验证插件 - 让表单验证变得更容易
                                            </span>
                                        </div>
                                    </div>
                                     -->
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="chat-users">
                                    <div class="users-list">
                                    	<c:forEach items="${userList}" var="ulist" varStatus="userCount">
                                    		<div class="chat-user">
                                    			<span class="pull-right label label-primary">
                                    				<c:if test="${ulist.userState == 0}">离线</c:if>
                                    				<c:if test="${ulist.userState == 1}">在线</c:if>
                                    				<c:if test="${ulist.userState == 2}">忙碌</c:if>
                                    			</span>
	                                            <img class="chat-avatar" src="../statics/img/a1.jpg" alt="">
	                                            <div class="chat-user-name">
	                                                <a href="#" onclick="showChatBox('${ulist.userName}')">${ulist.userName}</a>
                                            	</div>
                                        	</div>
                                    	</c:forEach>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="chat-message-form">

                                    <div class="form-group">
                                        <textarea class="form-control message-input" name="message" id="message" placeholder="输入消息内容，按回车键发送"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 隐藏添加好友div -->
    <div class="search-box-msg" id="addFriend" style="display:none">
	   <form class="form-inline">
		  <div class="form-group">
			    <input type="text" class="form-control" name="fname" placeholder="请输入用户名">
		  </div>
			  <button type="button" class="btn btn-default btn-sm" id="searchBtn" onclick="javascript:;">
             	搜索 <i class="fa fa-search"></i>
         	  </button>
         	  <button type="button" class="btn btn-default btn-sm" id="clearBtn" onclick="javascript:;">
             	清空 
         	  </button>
         	  <button type="button" class="close"><span>x</span></button>
	    </form>
	    <div class="new-table-responsive">
	    	<div class="box-body table-responsive no-padding ">
	    		<table class="table table-hover" id="addFriendTable">
	    			<tr>
                       <th><input type="checkbox" name="" id="all"/></th>
                       <th>序号</th>
                       <th>用户名</th>
                       <th>手机</th>
                       <th>状态</th>
                       <th style="width: 100px;">操作</th>
                    </tr>
	    		</table>
	    	</div>
	    </div>
    </div>
    <!-- 隐藏添加好友提示div -->
    <div class="addFriendremind-box-msg" style="display:none">
    	<div class="title">
    		好友申请
    		<button type="button" class="close"><span>x</span></button>
    	</div>
    	<div class="content">
	    	<p>你将添加【<span id="friendName"></span><span id="friendId" style="display:none"></span>】为好友,附加信息：</p>
	    	<textarea id="friendNote"></textarea>
	    	<button type="button" class="btn btn-default btn-xs" onclick="sendFriendApply()">确定 </button>
	    	<button type="button" class="cancelbtn btn btn-default btn-xs" href="#">取消 </button>
    	</div>
    </div>
    
    <!-- 隐藏创建群聊div -->
    <div class="search-box-msg" id="addGroupChat" style="display:none">
	   <form class="form-inline">
		  <div class="form-group">
			    <input type="text" class="form-control" name="fname" placeholder="请输入用户名">
		  </div>
			  <button type="button" class="btn btn-default btn-sm" id="searchBtn" onclick="javascript:;">
             	搜索 <i class="fa fa-search"></i>
         	  </button>
         	  <button type="button" class="btn btn-default btn-sm" id="clearBtn" onclick="javascript:;">
             	清空 
         	  </button>
         	  <button type="button" class="close"><span>x</span></button>
	    </form>
	    <div class="new-table-responsive">
	    	<div class="box-body table-responsive no-padding ">
	    		<table class="table table-hover">
	    			<tr>
                       <th><input type="checkbox" name="" id="all"/></th>
                       <th>序号</th>
                       <th>用户名</th>
                       <th>手机</th>
                       <th>状态</th>
                       <th style="width: 100px;">操作</th>
                    </tr>
	    		</table>
	    	</div>
	    </div>
    </div>
    <div class="nav" style="display:none">
         <ul>
             <li><a class="animated bounceInUp" href="${pageContext.request.contextPath}/newsManageService/toConfirmList.do" title="消息管理"><i class="glyphicon glyphicon-envelope glyphicon-lg"></i></a></li>
             <!-- <li><a class="animated bounceInUp" href="#"><i class="fa fa-book fa-lg"></i></a></li>
             <li><a class="animated bounceInUp" href="#"><i class="fa fa-book fa-lg"></i></a></li> -->
         </ul>
     </div>
    <script src="../statics/jquery/jquery-2.2.3.min.js"></script>
    <script src="../statics/bootstrap/js/bootstrap.min.js"></script>
    <script src="../statics/bootstrap/js/bootstrap.js"></script>
    <script src="../statics/js/content.min.js"></script>
    <script src="../statics/dialog/jquery-confirm.min.js"></script>
    <script src="../statics/layer/layer.js"></script>
    <script>
	    function showAddFrindBox() {
	    	$("#addFriend").show();
		};
		function showAddGroupBox() {
	    	$("#addGroupChat").show();
		};
		function showAddGroupBox() {
	    	$("#addGroupChat").show();
		};
		function showFriendApply(dataId,dataName) {
			$(".addFriendremind-box-msg").show();
			$("#friendName").html(dataName);
			$("#friendId").html(dataId);
		};
		function showChatBox(receicerName){
			$(".chat-discussion p").text(receicerName);
			$(".chat-discussion .chat-message").text("");
		};
		function sendFriendApply(){
			var receiverName=$("#friendName").text();
			var senderName='<%= session.getAttribute("loginName")%>';
			var receiverId=$("#friendId").text();
			var senderNote=$("#friendNote").val();
			$.ajax({
	            type : 'post',
	            url : '${pageContext.request.contextPath}/userManageService/sendFriendApplication.do',
	            contentType : 'application/json',
	            data : JSON.stringify({
	                "receiver_name":receiverName,
	                "receiver_id":receiverId,
	                "sender_name":senderName,
	                "sender_note":senderNote
	            }),
	            cache : false,
	            sync : true,
	            success : function(data) {
	                warmMessage(data.resultMsg);
	                $(".addFriendremind-box-msg").hide();
	    	        $("#friendName").html("");
	    			$("#friendId").html("");
	    			$("#friendNote").val("");
	            },
	            error : function() {
	            	warmMessage("请求失败!");
	            	$(".addFriendremind-box-msg").hide();
	    	        $("#friendName").html("");
	    			$("#friendId").html("");
	    			$("#friendNote").val("");
	            }

	        });
		};
		$("#clearBtn").click(function(){
			$("#addFriend input[type='text']").val("");
		});
		$(".search-box-msg .close").click(function(){
	        $(".search-box-msg").hide();
	        $("#addFriend input[type='text']").val("");
	        $("#addFriendTable  tr:not(:first)").html("");
	    });
	    $(".addFriendremind-box-msg .close").click(function(){
	        $(".addFriendremind-box-msg").hide();
	        $("#friendName").html("");
			$("#friendId").html("");
			$("#friendNote").val("");
	    });
	    $(".addFriendremind-box-msg .cancelbtn").click(function(){
	        $(".addFriendremind-box-msg").hide();
	        $("#friendName").html("");
			$("#friendId").html("");
			$("#friendNote").val("");
	    });
		$("#friendSearchBtn").click(function(){
	        var userName=$("input[name='userName']").val();
	        $.ajax({
	            type : 'post',
	            url : '${pageContext.request.contextPath}/userManageService/searchFriend.do',
	            contentType : 'application/json',
	            data : JSON.stringify({
	                "userName":userName
	            }),
	            cache : false,
	            sync : true,
	            success : function(data) {
	                if (200 == data.resultCode) {
	                	var userLsit = data.extend.friendsList
	                	var tempHtml = "";
	                	for(var i = 0; i< userLsit.length; i++)
	                	{
	                		tempHtml += "<div class='chat-user'>";
	                		tempHtml += "<span class='pull-right label label-primary'>";
	                		if(userLsit[i]["userState"] == 0)
	                		{
	                			tempHtml += "离线</span>";
	                		}
	                		else if(userLsit[i]["userState"] == 1)
	                		{
	                			tempHtml += "在线</span>";
	                		}
	                		else if(userLsit[i]["userState"] == 2)
	                		{
	                			tempHtml += "忙碌</span>";
	                		}
	                		tempHtml += "<img class='chat-avatar' src='../statics/img/a1.jpg' alt=''>";
	                		tempHtml += "<div class='chat-user-name'><a href='#'>" + userLsit[i]["userName"] + "</a></div></div>";
	                	}
	                	$(".users-list").html(tempHtml);
	                	
	                } else {
	                	$(".users-list").html("");
	                	warmMessage(data.resultMsg);
	                }
	            },
	            error : function() {
	            	warmMessage("请求失败!");
	            }

	        });
	    });
		$("#searchBtn").click(function(){
	        var userName=$("input[name='fname']").val();
	        $.ajax({
	            type : 'post',
	            url : '${pageContext.request.contextPath}/userManageService/searchUser.do',
	            contentType : 'application/json',
	            data : JSON.stringify({
	                "userName":userName
	            }),
	            cache : false,
	            sync : true,
	            success : function(data) {
	                if (200 == data.resultCode) {
	                	var userLsit = data.extend.allUser;
	                	var tempHtml = "";
	                	for(var i = 0; i< userLsit.length; i++)
	                	{
	                		tempHtml += "<tr><td><input type='checkbox' name='checkValues' value='" + userLsit[i]["user_id"] +"' /></td>";
	                		tempHtml += "<td>" + i + "</td>";
	                		tempHtml += "<td>" + userLsit[i]["user_name"] + "</td>";
	                		tempHtml += "<td>" + userLsit[i]["user_phone"] + "</td>";
	                		if(userLsit[i]["status"] == 0)
	                		{
	                			tempHtml += "<td><span class='pull-left label label-primary'>离线</span></td>";
	                		}
	                		else if(userLsit[i]["status"] == 1)
	                		{
	                			tempHtml += "<td><span class='pull-left label label-primary'>在线</span></td>";
	                		}
	                		else if(userLsit[i]["status"] == 2)
	                		{
	                			tempHtml += "<td><span class='pull-left label label-primary'>忙碌</span></td>";
	                		}
	                		/* if(userLsit[i]["status"] == 0)
	                		{ */
	                			tempHtml += "<td><a class='btn btn-primary pull-left btn-xs' href='javascript:void(0);' onclick='showFriendApply(&quot;" +  userLsit[i]["user_id"] + "&quot;,&quot;" + userLsit[i]["user_name"] +  "&quot;);'  role='button'><i class='fa fa-plus'></i></a></td></tr>";
	                		/* } */
	                		$("#addFriendTable  tr:not(:first)").html("");
	                		$("#addFriendTable").append(tempHtml);
	                	}
	                	
	                } else {
	                		$("#addFriendTable  tr:not(:first)").html("");
	                		warmMessage(data.resultMsg);
	                }
	            },
	            error : function() {
	            	warmMessage("请求失败!");
	            }

	        });
	    });
		//横向菜单显示
		$(".menubook").click(function(){
			if($(".nav").css("display")=="none"){
				$(".nav").show(100);
			}else{
				$(".nav").hide(100);
			}
		});
		//按回车发送消息
		document.getElementById("message").onkeydown=function(e){
			if(e.keyCode == 13 && e.ctrlKey){
				document.getElementById("message").value += "\n";
		    }else if(e.keyCode == 13){
		        // 避免回车键换行
		        e.preventDefault();
		        // 下面写你的发送消息的代码
		        var message = $("#message").val();
		        var receiverName = $(".chat-discussion p").text();
		        //发送mq给接收人
		        sendMsg(message,receiverName);
		    }
			
		};
		function sendMsg(message,receiverName){
			$.ajax({
	            type : 'post',
	            url : '${pageContext.request.contextPath}/newsManageService/personalNewsSend.do',
	            contentType : 'application/json',
	            data : JSON.stringify({
	                "receiver_name":receiverName,
	                "message":message
	            }),
	            cache : false,
	            sync : true,
	            success : function(data) {
	                if (200 == data.resultCode) {
	                	setMyMessageInnerHTML(message);
	    				$("#message").val("");
	                } else {
	                	warmMessage("发送失败,请重新发送");
	                }
	            },
	            error : function() {
	            	warmMessage("请求失败!");
	            }

	        });
		};
				
		function warmMessage(msg){
			layer.open({
				  type: 1,
				  title:'提示信息',
				  area: ['300px', '100px'],
				  shadeClose: true, //点击遮罩关闭
				  time: 5000,   //5s后自动关闭
				  content: '<div class="warn-box">'+msg+'</div>',
				  });
		}
    </script>
    <script>
	    var websocket = null;
	    
	    //判断当前浏览器是否支持WebSocket
	    if ('WebSocket' in window) {
	    	var sendUserName = '<%= session.getAttribute("loginName")%>';
	        //创建一个WebSocket连接，URL：127.0.0.1:8080/realTimeWebSocket/webSocket
	        //注：后端Server在模块realTimeWebSocket下，所以路径下多了一层realTimeWebSocket
	        websocket = new WebSocket("ws://127.0.0.1:8088" + '${pageContext.request.contextPath}' +"/ws/" + sendUserName);
	    }
	    else {
	        alert('当前浏览器 不支持WebSocket')
	    }
	 
	    //连接发生错误的回调方法
	    websocket.onerror = function () {
	        //setMessageInnerHTML("连接发生错误");
	    };
	 
	    //连接成功建立的回调方法
	    websocket.onopen = function () {
	        //setMessageInnerHTML("连接成功");
	    }
	 
	    //接收到消息的回调方法，此处添加处理接收消息方法，当前是将接收到的信息显示在网页上
	    websocket.onmessage = function (event) {
	    	var json = jQuery.parseJSON(event.data); 
	    	var receiverName = $(".chat-discussion p").text();
	    	if(receiverName == json.sender_name){
	    		//如果打开了和发送者的聊天框
	    		setOtherMessageInnerHTML(json);
	    	} else{
	    		//如果没有打开和发送者的聊天框
	    		showChatBox(json.sender_name);
	    		setOtherMessageInnerHTML(json);
	    	}
	    }
	 
	    //连接关闭的回调方法
	    websocket.onclose = function () {
	       // setMessageInnerHTML("连接关闭,如需登录请刷新页面。");
	    }
	 
	    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
	    window.onbeforeunload = function () {
	        closeWebSocket();
	    }
	    //关闭WebSocket连接
	    function closeWebSocket() {
	        websocket.close();
	     }
	    
	    function setConnectMsgInnerHTML(innerHTML){
	    	
	    }
	 
	    //将他人发送的消息显示在网页上，如果不需要显示在网页上，则不调用该方法
	    function setOtherMessageInnerHTML(innerHTML) {
	    	var tempHTML = "";
	    	tempHTML += "<div class='chat-message-other'>";
	    	tempHTML += "<img class='message-avatar' src='../statics/img/qq.jpg' alt=''>";
	    	tempHTML += "<div class='message'><a class='message-author' href='#'>" + innerHTML.sender_name +"</a>";
	    	tempHTML += "<span class='message-date'>" + new Date().Format("yyyy-MM-dd HH:mm:ss"); + "</span>";
	    	tempHTML += "<span class='message-content'>" + innerHTML.message + "</span></div></div>";
	    	$(".chat-discussion").append(tempHTML);
	    }
	    
	  //将自己发送的消息显示在网页上，如果不需要显示在网页上，则不调用该方法
	    function setMyMessageInnerHTML(innerHTML) {
	    	var tempHTML = "";
	    	tempHTML += "<div class='chat-message-my'>";
	    	tempHTML += "<img class='message-avatar' src='../statics/img/qq.jpg' alt=''>";
	    	tempHTML += "<div class='message'><a class='message-author' href='#'>" + '<%= session.getAttribute("loginName")%>' +"</a>";
	    	tempHTML += "<span class='message-date'>" + new Date().Format("yyyy-MM-dd HH:mm:ss"); + "</span>";
	    	tempHTML += "<span class='message-content'>" + innerHTML + "</span></div></div>";
	    	$(".chat-discussion").append(tempHTML);
	    }
	    

	    Date.prototype.Format = function (fmt) { 
	        var o = {
	            "M+": this.getMonth() + 1, //月份 
	            "d+": this.getDate(), //日 
	            "H+": this.getHours(), //小时 
	            "m+": this.getMinutes(), //分 
	            "s+": this.getSeconds(), //秒 
	            "q+": Math.floor((this.getMonth() + 3) / 3),
	            "S": this.getMilliseconds() //毫秒 
	        };
	        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	        for (var k in o)
	        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	        return fmt;
	    }
    </script>
</body>

</html>
