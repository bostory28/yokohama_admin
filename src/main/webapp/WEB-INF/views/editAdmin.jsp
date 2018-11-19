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
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- ログインCSS -->
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
	<script src="<%=cp%>/resources/js/jquery.validate.min.js" type="text/javascript"></script>
		<script src="<%=cp%>/resources/js/additional-methods.min.js" type="text/javascript"></script>
			<script src="<%=cp%>/resources/js/jquery.validate.js" type="text/javascript"></script>
				<script src="<%=cp%>/resources/js/additional-methods.js" type="text/javascript"></script>
<title>管理者権限の修正</title>
<script type="text/javascript">
$(document).ready(function(){
	var x = $("#hidden").val();
	if(x=='1'){//管理者の種類を確認
		$("#normal").attr("checked","checked");
	}
	else{
		$("#special").attr("checked","checked");
	}
	
});
//編集ボタンを押すと該当ポップアップを閉める
function aclose(){
	opener.location.reload(true);  
	self.close();
	/*$("#form").validate({
		  rules: {
		
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
			
		    inputPwd: {
		      required: "暗証番号は必須項目です。",
		      noWhiteSpace : "分別書法はできません",
		      minlength: $.validator.format("暗証番号は8文字以上です。")
		    }
		  },
		submitHandler: function(frm){
			$("#message2").html("");
			if($('input:radio[name=radio]:checked').length<1){
				var span = $("<span　id='span2'><strong>確認してください。</strong></span>");
				$("#message2").html(span);
				return false;}
			frm.submit();
			asclose();
			
		}
	  
	});*/
}
function asclose(){
	opener.location.reload(true);  
	self.close();
}
</script>
</head>
<body>
<div class="col-lg-8 col-lg-offset-4">
  <form class="form-horizontal" role="form" id="form" action="edit" onsubmit="javascript:aclose();"> 
	 <div class="form-group row" id="divName1">
                <label for="inputName" class="col-lg-2 control-label" style="text-align: justify;">氏名(漢字)</label>
                <div class="col-lg-4">
                    <input type="text" class="form-control" id="name1" name="name1" data-rule-required="true" readonly="readonly" value="${user.kanji_name}">
                </div>
            </div>
     <div class="form-group row" id="divName2">
                <label for="inputName" class="col-lg-2 control-label" style="text-align: justify;">氏名（カタカナ）</label>
                <div class="col-lg-4">
                    <input type="text" class="form-control" id="name2" name="name2" data-rule-required="true" readonly="readonly" value="${user.kana_name}">
                </div>
            </div>
            <div class="form-group" id="divId">
                <label for="inputId" class="col-lg-2 control-label" style="text-align: justify;">ID</label>
                <div class="col-lg-4">
                    <input type="text" class="form-control onlyAlphabetAndNumber" id="inputId" name="inputId" data-rule-required="true" readonly="readonly" value="${user.id}" >
                </div>
            </div>
<div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label" style="text-align: justify;">パスワード</label>
                <div class="col-lg-4">
                    <input type="text" class="form-control" id="inputPwd" name="inputPwd" value="${user.pass}" readonly="readonly">
                </div>
            </div>
           <div class="form-group">
                <label for="inputEmailReceiveYn" class="col-lg-2 control-label">権限</label>
                <div class="col-lg-4">
                    <label class="radio-inline">
                        <input type="radio" id="normal" name="radio" value="Y" class="radio">一般
                    </label>
                    <label class="radio-inline">
                        <input type="radio" id="special" name="radio" value="N" class="radio">特殊
                    </label>
                     <span id="message2"></span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2  col-lg-4">
                    <button type="submit" class="btn btn-default btn-block" >情報修正</button>
                </div>
            </div>
                 <input type="hidden" id="hidden" value="${user.admin }" name="pk">
            </form>
     </div>                

</body>
</html>