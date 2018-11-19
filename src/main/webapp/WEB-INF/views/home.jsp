<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<% String cp = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
	
	<link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- bootstrap -->
	<script src="<%=cp%>/resources/js/jquery-1.11.3.js" type="text/javascript"></script>
    <script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
    
    <!-- ログインCSS -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
	<meta name="description" content="Login and Registration Form with HTML5 and CSS3" />
	<meta name="keywords" content="html5, css3, form, switch, animation, :target, pseudo-class" />
	<meta name="author" content="Codrops" />
	<link rel="shortcut icon" href="../favicon.ico"> 
	<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/logincss/demo.css"/>
	<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/logincss/style.css" />
	<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/logincss/animate-custom.css" />
    <!-- cookie -->
    <script src="<%=cp%>/resources/js/cookie/src/js.cookie.js"></script>
<title>管理者ログイン</title>
<style type="text/css">
	.container {
		width: 100% !important;
	}
	@media screen and (max-width:1024px){
		.container {
			width: 1024px !important;
		}
	}
</style>
<!--　ジャバスクリプト -->
<script type="text/javascript">
	$(document).ready(function() {
		var userInputId = $.cookie("userInputId");
		$('#id').val(userInputId);
		if ($('#id').val() != "") {
			$('#loginkeeping').attr("checked", true);
		}
		
		$('#loginkeeping').change(function() {
			if ($('#loginkeeping').is(":checked")) {
				var userInputId = $('#id').val();
				$.cookie("userInputId", userInputId, {expires : 7});
			} else {
				$.removeCookie("userInputId");
			}
		});
		$('#id').keyup(function() {
			if ($('#loginkeeping').is(":checked")) {
				var userInputId = $('#id').val();
				$.cookie("userInputId", userInputId, {expires : 7});
			}
		});
		
		
		$('#loginButton').click(function() {
			var id = $('#id');
			var password = $('#password');
			/* 有効性検査 */
			if (id.val() != '' && password.val() != '') {
				if (id.val().length < 8) {
					alert('IDが短いです。\nIDを8文字以上入力してください。');
					id.select();
					id.focus();
					return;
				} else {
					if (password.val().length < 8) {
						alert('パスワードが短いです。\nPASSWORDを8文字以上入力してください。');
						password.focus();
						password.select();
						return;
					} 
				}
			} else {
				if (id.val() == '') {
					alert('「未入力フィールドの名前」を入力してください。\n  IDを入力してください。');
					id.focus();
					return;
				}
				if (password.val() == '') {
					alert('「未入力フィールドの名前」を入力してください。\n  PASSWORDを入力してください。');
					password.focus();
					return;
				}
			}
			form.action="loginSucc";
			form.submit();
		});
		$('body').keypress(function(e){
		    if(e.keyCode!=13) return;
		    var id = $('#id');
			var password = $('#password');
			/* 有効性検査 */
			if (id.val() != '' && password.val() != '') {
				if (id.val().length < 8) {
					alert('IDが短いです。\nIDを8文字以上入力してください。');
					id.select();
					id.focus();
					return;
				} else {
					if (password.val().length < 8) {
						alert('パスワードが短いです。\nPASSWORDを8文字以上入力してください。');
						password.focus();
						password.select();
						return;
					} 
				}
			} else {
				if (id.val() == '') {
					alert('「未入力フィールドの名前」を入力してください。\n  IDを入力してください。');
					id.focus();
					return;
				}
				if (password.val() == '') {
					alert('「未入力フィールドの名前」を入力してください。\n  PASSWORDを入力してください。');
					password.focus();
					return;
				}
			}
			form.action="loginSucc";
			form.submit();
		    });
		
	
	});
	function load(fail) {
		if (fail == "fail") {
			alert('登録されないIDまたはパスワードが正しくありません。');
		}
	}
</script>
</head>
<body onload="javascript:load('${loginResult }')">
	 <div class="container">
            <!-- Codrops top bar -->
            <div class="codrops-top">
                <span class="right">
                        <strong>Welecome To Our Website</strong>
                </span>
                <div class="clr"></div>
            </div><!--/ Codrops top bar -->
            <header>
                <h1 style="font-family: HG創英角ﾎﾟｯﾌﾟ体">入学申請管理ページ <span>管理者用</span></h1>
            </header>
            <br>
            <section>				
                <div id="container_demo" >
                    <!-- hidden anchor to stop jump http://www.css3create.com/Astuce-Empecher-le-scroll-avec-l-utilisation-de-target#wrap4  -->
                    <a class="hiddenanchor" id="toregister"></a>
                    <a class="hiddenanchor" id="tologin"></a>
                    <div id="wrapper">
                        <div id="login" class="animate form">
                            <form  name="form" method="post" autocomplete="on"> 
                                <h1>Log in</h1> 
                                <p> 
                                    <label for="username" class="uname" data-icon="u"> Your email or username </label>
                                    <input id="id" name="id" required="required" type="text" placeholder="myusername or mymail@mail.com"/>
                                </p>
                                <p> 
                                    <label for="password" class="youpasswd" data-icon="p"> Your password </label>
                                    <input id="password" name="pass" required="required" type="password" placeholder="eg. X8df!90EO" /> 
                                </p>
                                <p class="keeplogin"> 
									<input type="checkbox" name="loginkeeping" id="loginkeeping" value="loginkeeping"/> 
									<label for="loginkeeping">Keep ID</label>
								</p>
                                <p class="login button"> 
                                    <input type="button" value="Login" id="loginButton"/> 
								</p>
                                <p class="change_link">
								</p>
                            </form>
                        </div>
	                </div>
	            </div>
	    </section>
	</div>
</body>
</html>