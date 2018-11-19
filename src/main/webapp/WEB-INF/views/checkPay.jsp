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
    <link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- ログインCSS -->
	<script src="<%=cp%>/resources/js/jquery-1.11.3.js" type="text/javascript"></script>
    <script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
<title>個人決済の情報</title>
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
<script>
$(document).ready(function(){
	//ナビゲーションバーに効果を付与
	$("a").removeAttr("background-color");
	 $("#6").css("background-color","#B0E0E6");
	$("th").css("text-align","center");
	$("tr").css("text-align","center");
   var x = $("#ispayed").val();
   var deposit_date = $("#date").val();
   if(x=="false"){//支払するかどうか確認し、チェックボックスにチェック
	   $('#unpay').attr("checked","checked");
   }
   else{
	   $('#pay').attr("checked","checked");
	   $("#inputId").attr("value",deposit_date);
   }

});
//前のページに戻る
function cancle(){
	location.href="./payment";
}
			
</script>
</head>
<body>
<br><br><br><br>
 <div class="col-xs-8 col-xs-offset-2"  style="border-style: solid; border-width: 2px;">
 <div class="container_tmp1">
 <h2 style="font-family: HG創英角ﾎﾟｯﾌﾟ体" class="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;">決済(個人決済情報)</span></h2><br>
  <form class="form-horizontal" role="form" id="form"  method="post" name="checkForm" action="editpay"> 
	 <div class="form-group row" id="divName1">
                <label for="inputName" class="col-xs-2 control-label" style="text-align: justify;">ID</label>
                <div class="col-xs-4">
               <input type="text" class="form-control" id="input" name="input" value="${vo.number }" readonly="readonly">
                </div>
            </div>
     <div class="form-group row" id="divName2">
                <label for="inputName" class="col-xs-2 control-label" style="text-align: justify;">状態</label>
                <div class="col-xs-4">
                   	<label class="radio-inline">
                        <input type="radio" name="radio1" value="N" class="radio" id="unpay">未納&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="radio1" value="Y" class="radio" id="pay">完納
                    </label>
                </div>
            </div>
            <input type="hidden" name="hidden" value="${vo.report_id }">
           <div class="form-group row">
                <label for="inputEmailReceiveYn" class="col-xs-2 control-label" style="text-align: justify;">手段</label>
                <div class="col-xs-4">
                    <select name="radio" class="selectpicker">
					<option value="クレジットカード">クレジットカード</option>
					<option value="銀行払い込み">銀行払い込み</option>                
                	<option value="コンビニ払い込み">コンビニ払い込み</option>
                
                </select>
                </div>
            </div>
                 <div class="form-group" id="divId">
                <label for="inputId" class="col-xs-2 control-label" style="text-align: justify;">日付</label>
                <div class="col-xs-4">
                    <input type="text" class="form-control" id="inputId" name="inputId" value="" readonly="readonly">
                </div>
            </div>
            <div class="form-group">
                    <div class="col-xs-offset-2 col-xs-6">
                <button type="submit" class="btn btn-default">登録</button>
                <input type="button" class="btn btn-default" value="キャンセル" onclick="javascript:cancle();">
                <br><br>
                </div>
                </div>
            </div>
            </form>
            <input type="hidden" value="${vo.ispayed }" id="ispayed">
            <input type="hidden" value="${vo.means }" id="means">
            <input type="hidden" value="${vo.deposit_date }" id="date">
     </div>  
</body>
</html>