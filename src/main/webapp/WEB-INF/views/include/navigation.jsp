<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style type="text/css">
		.container_test{
			width: 100%;
			height: 13%;
			position: relative;
			text-align: center;
		}
		@media (min-width: 50px) {
			.nav-tabs.nav-justified>li {
				display: table-cell;
				width: 1%;
			}
		}
		@media screen and (max-width:1700px){
			.container_test {
				width: 1200px !important;
				margin-left: 16.66666667%;
			}
		}
		.nav{
			width: 100% !important;
		}
		.navibtn {
			width: 98%;
			float: left; 
		}
		@media screen and (max-width:1700px){
			.nav {
				width: 1100px !important;
				margin-left: 50px;
			}
			.navibtn {
				width: 145px;
				float: left; 
				margin-left: -50px;
				
			}
		}
		.container_test > header{
			padding: 20px 30px 10px 30px;
			margin: 0px 20px 10px 20px;
			position: relative;
			display: block;
			text-shadow: 1px 1px 1px rgba(0,0,0,0.2);
		    text-align: center;
		}
		.container_test > header h1{
			font-family: 'BebasNeueRegular', 'Arial Narrow', Arial, sans-serif;
			font-size: 35px;
			line-height: 35px;
			position: relative;
			font-weight: 400;
			color: rgba(26,89,120,0.9);
			text-shadow: 1px 1px 1px rgba(0,0,0,0.1);
		    padding: 0px 0px 5px 0px;
		}
		.container_test > header h1 span{
			color: #7cbcd6;
			text-shadow: 0px 1px 1px rgba(255,255,255,0.8);
		}
	</style>
<script src="<%=cp%>/resources/js/jquery-1.11.3.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/jquery-ui-1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="<%=cp%>/resources/js/jquery-ui-1.11.4/jquery-ui.css">
<script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=cp%>/resources/js/jquery.validate.min.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/additional-methods.min.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/jquery.validate.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/additional-methods.js" type="text/javascript"></script>
<script type="text/javascript">
	function goController(state, viewName) {
		document.form.state.value=state;
		document.form.viewName.value=viewName;
		document.form.method="post";
		document.form.submit();
	}
	$(window).on('scroll', function() {
	    var _currentScroll = $(window).scrollTop();
	    if (_currentScroll > 100) {
	        if (!$('.nav').hasClass('on')) {
	            $('.nav').addClass('on');
	        }
	    } else {
	        if ($('.nav').hasClass('on')) {
	            $('.nav').removeClass('on');}
	        }
	    }
	);
</script>
</head>
<body>
	<div class="container_test">
		<header>
			<h1 style="font-family: HG創英角ﾎﾟｯﾌﾟ体">入学申請管理ページ <span>管理者用</span></h1>
		</header>
	</div>
	
	<div class="col-xs-8 col-xs-offset-2">
		<ul class="nav nav-tabs nav-justified">
			<li><a class="navibtn btn btn-default navbar-btn" style="border:1px solid" href="javascript:goController(1, 'appDocView')" id="0">申請済</a></li>
			<li><a class="navibtn btn btn-default navbar-btn" style="border:1px solid" href="javascript:goController(2, 'insuffDocView')" id="1">不備 </a></li>
			<li><a class="navibtn btn btn-default navbar-btn" style="border:1px solid" href="javascript:goController(3, 'suffDocView')" id="2">完了</a></li>
			<li><a class="navibtn btn btn-default navbar-btn" style="border:1px solid" href="./payment" id="6">決済</a></li>
			<li><a class="navibtn btn btn-default navbar-btn" style="border:1px solid" href="./testee" id="3">受験者</a></li>
			<li></li>
			<li><a class="navibtn btn btn-default navbar-btn" style="border:1px solid" href="./mypage" id="5">マイページ</a></li>
			<li><a class="navibtn btn btn-default navbar-btn" style="border:1px solid" href="./logout"> ログアウト</a></li>
		</ul>
	</div>
	<form action="appDoc" name="form">
		<input type="hidden" name="isUser" value="${isUser }">
		<input type="hidden" name="currentPage" value="1">
		<input type="hidden" name="category" value="すべて">
		<input type="hidden" name="state" value="">
		<input type="hidden" name="viewName" value="">
	</form>
</body>
</html>