 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
	<c:when test="${isUser == '1' }">
		<%@include file="include/navigation.jsp"  %>
	</c:when>
	<c:otherwise>
		<%@include file="include/specialnavigation.jsp"  %>
	</c:otherwise>
</c:choose>
<%@ page pageEncoding="UTF-8"%>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script src="<%=cp%>/resources/js/jquery-1.11.3.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
    <!-- ログインCSS -->
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="<%=cp%>/resources/js/jquery.validate.min.js" type="text/javascript"></script>
		<script src="<%=cp%>/resources/js/additional-methods.min.js" type="text/javascript"></script>
			<script src="<%=cp%>/resources/js/jquery.validate.js" type="text/javascript"></script>
				<script src="<%=cp%>/resources/js/additional-methods.js" type="text/javascript"></script>
<title>パスワードの修正</title>
<style type="text/css">
.tr td {
		text-align: center;
	}
	.container_tmp1 {
		width: 100% !important;
		margin-left: 340px;
	
	}
	@media screen and (max-width:1700px){
		.container_tmp1 {
			width: 1100px !important;
			
		}
	}
	</style>
<script type="text/javascript">
$(document).ready(function(){
	//ナビゲーションバーに効果を付与
	$("a").removeAttr("background-color");
	 $("#5").css("background-color","#B0E0E6");
	//暗証番号・アイディ有効性検査
	$("#form").validate({
		  rules: {
		    inputPwd1: {
		    	   required     : true,
				      noWhiteSpace : true,
				      minlength    : 8,
				      hasUpper : true,
				      hasLower : true,
				      hasDigit : true,
				      aski : true
		    },
		    inputPwd2: {
		      required     : true,
		      noWhiteSpace : true,
		      minlength    : 8,
		      hasUpper : true,
		      hasLower : true,
		      hasDigit : true,
		      aski : true
		    },
		    inputPwd3: {
		    	   required     : true,
				      noWhiteSpace : true,
				      minlength    : 8,
				      hasUpper : true,
				      hasLower : true,
				      hasDigit : true,
				      aski : true
		    },
		  },
		  messages: {
			
			  inputPwd1: {
			      required: "パスワードは必須項目です。",
			      noWhiteSpace : "分別書法はできません",
			      minlength: $.validator.format("")
			    },
		    inputPwd2: {
		      required: "パスワードは必須項目です。",
		      noWhiteSpace :"分別書法はできません",
		      minlength: $.validator.format("")
		    },
		    inputPwd3: {
			      required: "パスワードは必須項目です。",
			      noWhiteSpace : "分別書法はできません",
			      minlength: $.validator.format("")
			    }
		  },
		submitHandler: function(frm){
			$("#message1").html("");
			$("#message2").html("");
			var pw = $("#inputPwd1").val();
			var pw2 = $("#inputPwd2").val();
			var pw3 = $("#inputPwd3").val();
			if(pw2!=pw3){//パスワードの入力を間違い場合
				alert("入力したパスワードとは違います！");
				return false;
			}
			$.ajax({
				url: './pwcheck',
				type: 'POST',
				data: { pw:pw},
				dataType: 'json',
				success: function(json){
					if(json.user==null){//既存のパスワードが間違い場合
						alert("既存のパスワードがありません。");
						return false;
					}
					if (json.user!=null){//既存のパスワードが正しい場合
						frm.submit();
						aclose();
					}
				}
			});	
		}	  
	});

});
//前のページに戻る
function cancle(){
	location.href="./mypage";
}
</script>
</head>
<body><br><br><br><br>
<div class="col-xs-8 col-xs-offset-2" style="border-style: solid;border-width: 2px;">
<div class="container_tmp1">
<h2 style="font-family: HG創英角ﾎﾟｯﾌﾟ体" class="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;">マイページ（パスワード変更）</span></h2><br>
  <form class="form-horizontal" method="post" action="newPw" id="form" >
	 
            <div class="form-group" id="divId">
                <label for="inputId" class="col-xs-2 control-label" style="text-align: justify;">ID</label>
                <div class="col-xs-4">
                    <input type="text" class="form-control" id="inputId" name="inputId" readonly="readonly" value="${userId}" >
                </div>
            </div>
<div class="form-group" id="divPassword1">
                <label for="inputPassword" class="col-xs-2 control-label" style="text-align: justify;">既存パスワード</label>
                <div class="col-xs-4">
                    <input type="password" class="form-control" id="inputPwd1" name="inputPwd1" placeholder="パスワード(既存)">
                	<span id="message1"></span>
                </div>
            </div>
<div class="form-group" id="divPassword2">
                <label for="inputPassword2" class="col-xs-2 control-label" style="text-align: justify;">新しいパスワード</label>
                <div class="col-xs-4">
                    <input type="password" class="form-control" id="inputPwd2" name="inputPwd2" placeholder="新しいパスワード">
                </div>
            </div>
            <div class="form-group" id="divPassword3">
                <label for="inputPassword3" class="col-xs-2 control-label" style="text-align: justify;">新しいパスワード</label>
                <div class="col-xs-4">
                    <input type="password" class="form-control" id="inputPwd3" name="inputPwd3" placeholder="もう一度新しいパスワードを入力してください。">
                    <span id="message2"></span>
                </div>
            </div>
            <br>
            <div class="form-group">
                <div class="col-xs-6"><center>
                <button type="submit" class="btn btn-default">修正</button>
                <input type="button" class="btn btn-default" value="キャンセル" onclick="javascript:cancle();">
                </center><br><br>
                </div>
            </div>
            </form>
     </div>   </div>             
</body>
</html>