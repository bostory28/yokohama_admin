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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<% String cp = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理者</title>
  <link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<script src="<%=cp%>/resources/js/jquery-1.11.3.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
    <!-- ログインCSS -->
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="<%=cp%>/resources/js/jquery.validate.min.js" type="text/javascript"></script>
		<script src="<%=cp%>/resources/js/additional-methods.min.js" type="text/javascript"></script>
			<script src="<%=cp%>/resources/js/jquery.validate.js" type="text/javascript"></script>
				<script src="<%=cp%>/resources/js/additional-methods.js" type="text/javascript"></script>

<title>管理者追加</title>
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
	$("#4").css("background-color","#B0E0E6");
	$("th").css("text-align","center");
	$("tr").css("text-align","center");
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
		    inputId: {
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
			     noWhiteSpace : "分別書法はできません",
			      minlength    : $.validator.format("名前（漢字）は必須項目です。")
			},
			name2:{
				 required     : "名前（振り仮名）は必須項目です。",
			     noWhiteSpace : "分別書法はできません",
			      minlength    : $.validator.format("名前（振り仮名）は必須項目です。")
			},
		    inputId: {
		      required: "IDは必須項目です。",
		      noWhiteSpace : "分別書法はできません",
		      minlength: $.validator.format("IDは必須項目です。")
		    },
		    inputPwd: {
		      required: "パスワードは必須項目です。",
		      noWhiteSpace : "分別書法はできません",
		      minlength: $.validator.format("パスワードは8文字以上です。")
		    }
		  },
		submitHandler: function(frm){
			$("#message1").html("");
			$("#message2").html("");
			if($('input:radio[name=radio]:checked').length<1){
				var span = $("<span　id='span2'><strong>確認してください。</strong></span>");
				$("#message2").html(span);
				return false;}
			var id = $("#inputId").val();
			$.ajax({
				url: './idcheck',
				type: 'POST',
				data: { id:id},
				dataType: 'json',
				success: function(json){
					if(json.id!=null){
						var span = $("<span　id='span1'><strong>登録されてるIDです。</strong></span>");
						$("#message1").html(span);
						return false;
					}
					if (json.id==null){
						frm.submit();
					}
				}
			});	
		}	  
	});

});
//前のページに戻る
function cancle(){
	location.href="./admin";
}

</script>
</head>
<body>
<br><br><br><br>
<div class="col-xs-8 col-xs-offset-2" style="border-style: solid; border-width: 2px;">
<div class="container_tmp1">
<h2 style="font-family: HG創英角ﾎﾟｯﾌﾟ体" class="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;">受験者(管理者登録)</span></h2><br>
  <form class="form-horizontal" method="post" action="add" id="form" >
	 <div class="form-group row" id="divName1">
                <label for="inputName" class="col-xs-2 control-label" style="text-align: justify;">氏名(漢字)</label>
                <div class="col-xs-4">
                    <input type="text" class="form-control" id="name1" name="name1" placeholder="氏名(漢字)">
                </div>
            </div>
     <div class="form-group row" id="divName2">
                <label for="inputName" class="col-xs-2 control-label" style="text-align: justify;">氏名（カタカナ）</label>
                <div class="col-xs-4">
                    <input type="text" class="form-control" id="name2" name="name2" placeholder="氏名（カタカナ）">
                </div>
            </div>
            <div class="form-group" id="divId">
                <label for="inputId" class="col-xs-2 control-label" style="text-align: justify;">ID</label>
                <div class="col-xs-4">
                    <input type="text" class="form-control onlyAlphabetAndNumber" id="inputId" name="inputId" placeholder="ID" >
                    <span id="message1"></span>
                </div>
            </div>
<div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-xs-2 control-label" style="text-align: justify;">パスワード</label>
                <div class="col-xs-4">
                    <input type="password" class="form-control" id="inputPwd" name="inputPwd" placeholder="パスワード">
                </div>
            </div>
           <div class="form-group">
                <label for="inputEmailReceiveYn" class="col-xs-2 control-label" style="text-align: justify;">権限</label>
                <div class="col-xs-4">
                    <label class="radio-inline">
                        <input type="radio" id="normal" name="radio" value="N" class="radio">一般&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </label>
                    <label class="radio-inline">
                        <input type="radio" id="special" name="radio" value="Y" class="radio">特殊
                    </label>
                    <span id="message2"></span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-6"><center>
                <button type="submit" class="btn btn-default">管理者登録</button>
                <input type="button" class="btn btn-default" value="キャンセル" onclick="javascript:cancle();">
                </center><br><br>
                </div>
            </div>
            </form>
     </div>           </div>     
</body>
</html>
