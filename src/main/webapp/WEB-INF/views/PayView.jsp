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
<script src="<%=cp%>/resources/js/jquery-ui-1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="<%=cp%>/resources/js/jquery-ui-1.11.4/jquery-ui.css">
<style type="text/css">
	.tr td {
			text-align: center;
			height: 47px;
		}
</style>
<title>決済</title>
<script src="<%=cp%>/resources/js/jquery-1.11.3.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/jquery.validate.min.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/additional-methods.min.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/jquery.validate.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/additional-methods.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/jquery-ui-1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="<%=cp%>/resources/js/jquery-ui-1.11.4/jquery-ui.css">
<link rel='stylesheet' href='http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css'/> 
<style type="text/css">
	.container_tmp {
		width: 100% !important;
	}
	@media screen and (max-width:1700px){
		.container_tmp {
			width: 1100px !important;
		}
	}
	/* @media (min-width:768px){.nav-tabs.nav-justified>li{display:table-cell;width:i} */
	/* label, input { display:block; } */
</style>

<script type="text/javascript">
	var pdialog;
	$(document).ready(function(){
		//カレンダーセットアップ
		$("#startDate").attr("type","hidden");  
		$("#endDate").attr("type","hidden"); 
		$("#span").html("");
		$("#selectspan").html("");
		$(function() {
	        $("#startDate").datepicker({
	        				   inline: true, 
    			        	   dateFormat: "yy/mm/dd",    
    			               prevText: 'prev', 
    			               nextText: 'next', 
    			               showButtonPanel: true,    
    			               changeMonth: true,        
    			               changeYear: true,        
    			               showOtherMonths: true,    
    			               selectOtherMonths: true,    
    			               currentText: '今日',
    			               minDate: '-30y', 
    			               closeText: '閉じる', 
    			               showMonthAfterYear: true,        
    			               monthNames : ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'], 
    			               monthNamesShort : ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'], 
    			               dayNames : ['日', '月', '火', '水', '木', '金', '土'],
    			               dayNamesShort : ['日', '月', '火', '水', '木', '金', '土'],
    			               dayNamesMin : ['日', '月', '火', '水', '木', '金', '土'],
    			               showAnim: 'slideDown',
    			               showOptions: { direction: "up"}, 
    			              /* 日付有効性チェック */ 
    			              beforeShow: function (textbox, instance) {
						            instance.dpDiv.css({

						                    marginTop: (-textbox.offsetHeight) -287 + 'px'
						                    
						            });
						    },
    			              onClose: function( selectedDate ) { 
    			            	  $('#endDate').datepicker("option","minDate", selectedDate);
    			              } 						
	               });

	        $("#endDate").datepicker(
	        		{ inline: true, 
	        			         dateFormat: "yy/mm/dd",    
	        			               prevText: 'prev', 
	        			               nextText: 'next', 
	        			               showButtonPanel: true,  
	        			               changeMonth: true,      
	        			               changeYear: true,        
	        			            showOtherMonths: true,    
	        			              selectOtherMonths: true,    
	        			              minDate: '-30y', 
	        			              closeText: '閉じる', 
	        			              currentText: '今日', 
	        			              showMonthAfterYear: true,        	        			           
	        			              monthNames : ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'], 
	        			              monthNamesShort : ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'], 
	        			              dayNames : ['日', '月', '火', '水', '木', '金', '土'],
	        			              dayNamesShort : ['日', '月', '火', '水', '木', '金', '土'],
	        			              dayNamesMin : ['日', '月', '火', '水', '木', '金', '土'],
	        			              showAnim: 'slideDown',
	        			              beforeShow: function (textbox, instance) {
	  						            instance.dpDiv.css({
	  						                    marginTop: (-textbox.offsetHeight) -287 + 'px'
	  						                    
	  						            });
	  						    }
			});
	    });		
	

		//ナビゲーションバーに効果を付与
		$("a").removeAttr("background-color");
		 $("#6").css("background-color","#B0E0E6");
		$("th").css("text-align","center");
		$("tr").css("text-align","center");
		//検索のキーワードを有効性検査
		$("#search").validate({
		
			submitHandler: function(frm){
				var select = $("#select").val();
				var text = $("#text").val();
				if(select==""){
					alert("検索条件を選択してください。");
					return false;
				}
				if(select=="deposit_date"){//入金日付を検索する時カレンダーから日付を選択を確認
					var startdate = $("#startDate").val();
					var enddate = $("#endDate").val();
					if(startdate==""||enddate==""){
						alert("日付を選択してください。");
						return false;
						}
				}
				if(select==""){
					var startdate = $("#startDate").val();
					var enddate = $("#endDate").val();
					if(startdate==""||enddate==""){
						alert("日付を選択してください。");
						return false;
						}
				}
				if(select=="id"||select=="report_id"||select=="kanji_name"){
					var x = /^[\S]+$/;
					if(x.test(text)==false||text==null){
						alert("検索語を入力してください。");
						return x.test(text);
					}
				}
				var stateSelect = $("#stateSelect").val();
				if(select=="statePay"){
					if(stateSelect==""){
						alert("検索条件を選択してください。");
						return false;
					}
					$("#text2").val(stateSelect);
				}
				var meanSelect = $("#meanSelect").val();
				if(select=="payMeans"){
					if(meanSelect==""){
						alert("検索条件を選択してください。");
						return false;
					}
					$("#text2").val(meanSelect);
				}
				frm.submit();
				
			}	
			  
		});
		
		//個人的にメールを転送
		pdialog = $('#dialog-personal').dialog({
			autoOpen: false,
			height: 600,
			width: 400,
			modal: true,
			buttons: {
				"送信": sendPersonalMail,
				"取り消し": function() {
					$('#subject_tmp_per').val("");
					$('#body_tmp_per').val("");
					pdialog.dialog("close");
				}
			},
			close: function() {
				$('#subject_tmp_per').val("");
				$('#body_tmp_per').val("");
			}
		});
		
		//個人的なメール
		function sendPersonalMail() {
			$('#personalSubject').val($('#subject_tmp_per').val());
			$('#personalBody').val($('#body_tmp_per').val());
			$('#personalUid').val($('#recipient_per').val());
			var sendMailForm = $("form[name=sendMailForm]").serialize();
			$.ajax({
				url: 'sendPersonalMail',
				type: 'POST',
				data: sendMailForm,
				dataType: 'text',
				success: function() {
					pdialog.dialog("close");
					$('#subject_tmp_per').val("");
					$('#body_tmp_per').val("");
				}
			});
		}
		
		/* 整列 */
		$('#report_id').text("受付番号(－)");
		$('#kanji_name').text("受験者名(－)");
		$('#id').text("メール(－)");
		$('#means').text("決済手段(－)");
		$('#deposit_date').text("入金日(－)");
		var temp = $('#array').val().split(" ");
		switch (temp[0]) {
		case "report_id":
			if (temp[1] != null) {
				$('#'+temp[0]).text("受付番号(▼)");
			} else {
				$('#'+temp[0]).text("受付番号(▲)");
			}
			break;
		case "kanji_name":
			if (temp[1] != null) {
				$('#'+temp[0]).text("受験者名(▼)");
			} else {
				$('#'+temp[0]).text("受験者名(▲)");
			}
			break;
		case "id":
			if (temp[1] != null) {
				$('#'+temp[0]).text("メール(▼)");
			} else {
				$('#'+temp[0]).text("メール(▲)");
			}
			break;
		case "means":
			if (temp[1] != null) {
				$('#'+temp[0]).text("決済手段(▼)");
			} else {
				$('#'+temp[0]).text("決済手段(▲)");
			}
			break;
		case "deposit_date":
			if (temp[1] != null) {
				$('#'+temp[0]).text("入金日(▼)");
			} else {
				$('#'+temp[0]).text("入金日(▲)");
			}
			break;
		}
	});
	//ページング
	function movePage(pageNum) {
		document.pageForm.action="againpay";
		document.pageForm.currentPage.value=pageNum;
		document.pageForm.submit();
	}
	//Groupページング
	function moveGroup(pageNum) {
		document.pageForm.action="againpay";
		document.pageForm.currentPage.value=pageNum;
		document.pageForm.submit();
	}
	//決済情報を修正するページ
	function view(rid,sort){
		location.href="./checkPay?rid="+rid;
	}
	/* 整列 */
	function array(sort) {
		var str = document.getElementById(sort).innerHTML;
		var currentSort = document.getElementById(sort).innerHTML.substring(str.length-2, str.length-1);
		switch (currentSort) {
		case "▼":
			document.arrayField.array.value=sort;
			break;
		case "▲":
			document.arrayField.array.value=sort + " desc";
			break;
		case "－":
			document.arrayField.array.value=sort + " desc";
			break;
		}
		document.arrayField.action="againpay";
		document.arrayField.submit();
	}
	//メール作成form
	function goMailForm(uid) {
		document.getElementById('recipient_per').setAttribute("value", uid);
		pdialog.dialog("open");
	}
	//selectボックスをクリックする時
	function change(){
		$("#startDate").attr("type","hidden"); 
		$("#endDate").attr("type","hidden");
		$("#span").html("");
		$("#selectspan").html("");
		$(".text").attr("type","text");
		var x = $("#select").val();
		if(x=="deposit_date"){//入金日を選択するときキーワードボックスを表示しないでカレンダーを表示
			$(".text").val("");
			$(".text").attr("type","hidden");
			$("#startDate").attr("type","text");
			$("#endDate").attr("type","text");
			var span = $("<strong>~</strong>");
			$("#span").html(span);
		}
		else if(x=="statePay") {
			$(".text").val("");
			$(".text").attr("type","hidden");
			var statePay="<select id='stateSelect'><option value=''>検索条件を選択してください</option><option value='未納'>未納</option><option value='完納'>完納</option><select>";
			$("#selectspan").html(statePay);
		}
		else if(x=="payMeans"){
			$(".text").val("");
			$(".text").attr("type","hidden");
			var statePay="<select id='meanSelect'><option value=''>検索条件を選択してください</option><option value='クレジットカード'>クレジットカード</option><option value='銀行払い込み'>銀行払い込み</option><option value='コンビニ払い込み'>コンビニ払い込み</option><select>";
			$("#selectspan").html(statePay);
		}
		$(".error").text("");
	}
</script>
</head>
<body>
<br><br><br>
<div class="col-xs-8 col-xs-offset-2">
<div class="container_tmp">
<table class="table table-bordered table-hover">
	<thead class="tr" style="font-weight: bold;">
		<input type="hidden" id="array" value="${array }">
		<td><a href="javascript:array('report_id')" id="report_id" style="text-decoration: none;">受付番号(▼)</a></td>
		<td>状態</td>
		<td><a href="javascript:array('kanji_name')" id="kanji_name" style="text-decoration: none;">受験者名(－)</a></td>
		<td><a href="javascript:array('id')" id="id" style="text-decoration: none;">メール(－)</a></td>
		<td>受験タイプ</td>
		<td><a href="javascript:array('means')" id="means" style="text-decoration: none;">決済手段(－)</a></td>
		<td><a href="javascript:array('deposit_date')" id="deposit_date" style="text-decoration: none;">入金日(－)</a></td>
	</thead>
	<c:forEach items="${appList}" var="usersVo">
	<tr class="tr"><td><a href="javascript:view('${usersVo.report_id}','${usersVo.report_type}')">${usersVo.number}</a></td>
	<td><c:if test="${usersVo.ispayed==false}">未納</c:if><c:if test="${usersVo.ispayed==true}">完納</c:if></td>
	<td>${usersVo.kanji_name }</td><td><a href="javascript:goMailForm('${usersVo.id }')">${usersVo.id}</a></td><td>${usersVo.report_type}</td><td>${usersVo.means}</td>
	<td>${usersVo.deposit_date }</td>
	
	</c:forEach>
</table>
<form name="appGoForm" method="post">
			<input type="hidden" name="rid">
			<input type="hidden" name="sort">
		</form>	
		
<!-- 整列 -->
<form name="arrayField" method="get">
		<input type="hidden" name="currentPage" value="1">
		<input type="hidden" name="category" value="${category }">
		<input type="hidden" name="viewName" value="appDocView">
		<input type="hidden" name="array" value="">
</form>	
<form name="sendMailForm" method="post">
	<input type="hidden" name="uid" id="personalUid">
	<input type="hidden" name="subject" id="personalSubject">
	<input type="hidden" name="body" id="personalBody">
	<input type="hidden" name="viewName" value="appDocView">
	<input type="hidden" name="currentPage" value="1">
</form>
<!-- 個人的にメールを転送 -->
<div id="dialog-personal" title="メール作成">
	<p class="validateTips"></p>
	<fieldset>
		<label for="recipient">宛先</label>
		<input type="text" name="recipient" id="recipient_per" value="" style="width: 100%;" readonly="readonly" class="text ui-widget-content ui-corner-all">
		<span style="line-height: 50%;"><br></span>
		<label for="title">タイトル</label>
		<input type="text" name="title" id="subject_tmp_per" value="" style="width: 100%;" class="text ui-widget-content ui-corner-all">
		<span style="line-height: 50%;"><br></span>
		<label for="content">内容</label>
		<textarea style="width: 100%;" rows="14" id="body_tmp_per" class="ui-widget-content ui-corner-all"></textarea>
	</fieldset>
</div>
<!-- 페이지 이동 -->
<div align="center">
		<form name="search" id="search" action="againpay" method="get">
		<input type="hidden" name="currentPage" value="1">
			<select name="select" id="select" onchange="javascript:change();" >
			<option value="">検索条件を選択してください</option>
			<option value="report_id">受付番号</option>
			<option value="statePay">状態</option>
			<option value="kanji_name">受験者名</option>
			<option value="id">メール</option>
			<option value="payMeans">決済手段</option>
			<option value="deposit_date">入金日</option>
			</select>
			<input type="text" name="text" id="text" class="text">
    <input type="text" name="startdate" id="startDate" class="tbox03" placeholder="クリックしてください" readonly/><span id="span"></span>
	<input type="text" name="enddate" id="endDate" class="tbox03" placeholder="クリックしてください" readonly/><span id="selectspan"></span>
			<input type="submit" value="検索">
			<input type="hidden" name="stateSelect" id="text2" value="">
			</form>
			<form name="pageForm" action="againpay" method="get">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="array" value="${array }">
				<input type="hidden" name="startdate" value="${startdate }">
				<input type="hidden" name="enddate" value="${enddate }">
				<input type="hidden" name="select" value="${select }">
				<input type="hidden" name="text" value="${text }">
				<input type="hidden" name="stateSelect" value="${stateSelect }">
				<nav>
					<ul class="pagination">
						<c:choose>
							<c:when test="${currentGroup == 0 }">
								<li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="javascript:moveGroup(${startPageGroup - 1 })" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="${startPageGroup }" end="${endPageGroup }" varStatus="status">
							<c:choose>
								<c:when test="${currentPage ==  startPageGroup + status.count - 1}">
									<li class="active"><a href="#">${startPageGroup + status.count - 1}</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="javascript:movePage(${startPageGroup + status.count - 1 })">${startPageGroup + status.count - 1}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${currentGroup == totalGroup}">
								<li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&raquo;</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="javascript:moveGroup(${endPageGroup + 1 })" aria-label="Previous"><span aria-hidden="true">&raquo;</span></a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</nav>
			</form>
		</div>
</div>

</div>
<br><br><br>
</body>
</html>
