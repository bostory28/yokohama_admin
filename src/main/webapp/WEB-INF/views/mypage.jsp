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
	<!-- ログインCSS -->
	<script src="<%=cp%>/resources/js/jquery-1.11.3.js" type="text/javascript"></script>
    <script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
  
	<link rel="shortcut icon" href="../favicon.ico"> 
	<%-- <link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/logincss/demo.css"/> --%>
	<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/logincss/style.css" />
	<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/logincss/animate-custom.css" />
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="<%=cp%>/resources/js/jquery.validate.min.js" type="text/javascript"></script>
		<script src="<%=cp%>/resources/js/additional-methods.min.js" type="text/javascript"></script>
			<script src="<%=cp%>/resources/js/jquery.validate.js" type="text/javascript"></script>
				<script src="<%=cp%>/resources/js/additional-methods.js" type="text/javascript"></script>
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
<title>マイページ</title>
<script type="text/javascript">
$(document).ready(function(){
	var x = $("#hidden").val();
	if(x=='1'){//管理者の種類表示
		$("#inputAdmin").attr("value","一般");
	}
	else{
		$("#inputAdmin").attr("value","特殊");
	}
	//ナビゲーションバーに効果を付与
	 $("#5").css("background-color","#B0E0E6");
	//暗証番号・アイディ有効性検査
	$("#form").validate({
		  rules: {
			name1:{
				 required     : true,
			      noWhiteSpace : true,
			      minlength    : 1
			},
			name2:{
				 required     : true,
			      noWhiteSpace : true,
			      minlength    : 1
			},
		    inputPwd: {
		      required     : true,
		      noWhiteSpace : true,
		      minlength    : 8,
		      hasUpper : true,
		      hasLower : true,
		      hasDigit : true,
		      aski : true
		    }
		  },
		  messages: {
			name1:{
				 required     : "名前（漢字）は必須項目です。",
			     noWhiteSpace :  "分別書法はできません。",
			      minlength    : $.validator.format("")
			},
			name2:{
				 required     : "名前（振り仮名）は必須項目です。",
			     noWhiteSpace : "分別書法はできません。",
			      minlength    : $.validator.format("")
			},
		    inputPwd: {
		      required: "パスワードは必須項目です。",
		      noWhiteSpace :"分別書法はできません。",
		      minlength: $.validator.format("")
		    }
		  }, 
		  submitHandler: function(frm){
				$("#message1").html("");
				var pw = $("#inputPwd").val();
				$.ajax({
					url: './pwcheck',
					type: 'POST',
					data: { pw:pw},
					dataType: 'json',
					success: function(json){
						if(json.user==null){
							alert("パスワードをテェックしてもう一度入力してください。");
							return false;
						}
						if (json.user!=null){//パスワードが正しい場合
							frm.submit();
							return true;
						}
					}
					});
				}
});
});
//パスワード変更ボタンをクリックするとき
function edit(){
	location.href="./editPw";
}
</script>
</head>
<body>
<input type="hidden" id="hidden" value="${user.admin}">
<br><br><br><br>
<div class="col-xs-8 col-xs-offset-2" style="border-style: solid;border-width: 2px;">
<div class="container_tmp1 ">
<h2 style="font-family: HG創英角ﾎﾟｯﾌﾟ体;" class="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=" text-decoration: underline;">マイページ（個人情報変更）</span></h2>
  <br>
  <form class="form-horizontal col-xs-push-2 " id="form" action="editmypage" method="post" > 
	 <div class="form-group row" id="divName1">
                <label for="inputName" class="col-xs-2 control-label" style="text-align: justify;">氏名(漢字)</label>
                <div class="col-xs-4">
                    <input type="text" class="form-control" id="name1" name="name1"value="${user.kanji_name}">
                </div>
            </div>
     <div class="form-group row" id="divName2">
                <label for="inputName" class="col-xs-2 control-label" style="text-align: justify;">氏名（カタカナ）</label>
                <div class="col-xs-4">
                    <input type="text" class="form-control" id="name2" name="name2" value="${user.kana_name}">
                </div>
            </div>
            <div class="form-group" id="divId">
                <label for="inputId" class="col-xs-2 control-label" style="text-align: justify;">ID</label>
                <div class="col-xs-4">
                    <input type="text" class="form-control" id="inputId" name="inputId" value="${user.id}" readonly="readonly" >
                </div>
            </div>
            <div class="form-group" id="divadmin">
                <label for="inputAdmin" class="col-xs-2 control-label" style="text-align: justify;">権限</label>
                <div class="col-xs-4">
                    <input type="text" class="form-control" id="inputAdmin" name="inputAdmin" readonly="readonly" >
                </div>
            </div>
<div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-xs-2 control-label" style="text-align: justify;">パスワード</label>
                <div class="col-xs-4">
                    <input type="password" class="form-control" id="inputPwd" name="inputPwd">
                    <span id="message1"></span>
                </div>
            </div>
            
           
            <div class="form-group">
                <div class="col-xs-offset-2  col-xs-4">
                    <button type="submit" class="btn btn-default btn-block" >修正</button>
                </div>
            </div>
            </form>
<button class="btn btn-default" onclick="javascript:edit();">パスワード変更</button><br><br><br><br></div>
     </div>               
<input type="hidden" value="${state }" id="state">
</body>
</html>