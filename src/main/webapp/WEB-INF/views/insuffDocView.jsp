 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
	<c:when test="${isUser == 1 }">
		<%@include file="include/navigation.jsp"  %>
	</c:when>
	<c:otherwise>
		<%@include file="include/specialnavigation.jsp"  %>
	</c:otherwise>
</c:choose>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% String cp = request.getContextPath(); %>
<script src="<%=cp%>/resources/js/jquery-ui-1.11.4/jquery-ui.js"></script>

<link rel="stylesheet" href="<%=cp%>/resources/js/jquery-ui-1.11.4/jquery-ui.css">
<link rel='stylesheet' href='http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css'/> 
<title>不備</title>
<style type="text/css">
	.tr td {
		text-align: center;
		height: 47px;
	}
	.tr_title td {
		text-align: center;
		height: 20px;
	}
	.container_tmp {
		width: 100% !important;
	}
	@media screen and (max-width:1700px){
		.container_tmp {
			width: 1100px !important;
		}
	}
</style>
<script type="text/javascript">
	var pdialog;
	$(document).ready(function() {
		$("#startDate").attr("type","hidden");  
		$("#endDate").attr("type","hidden"); 
		$("#span").html(""); 
		
		//日付検索
		$(function() {
	        $("#startDate").datepicker({
	        	showOptions: { direction: "up" } ,
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

	              beforeShow: function (textbox, instance) {
		            instance.dpDiv.css({
		                    marginTop: (-textbox.offsetHeight) -287 + 'px'
		                    
		            });
		            },
				onClose: function( selectedDate ) { 
				$('#endDate').datepicker("option","minDate", selectedDate);
				} 							
			});

	        $("#endDate").datepicker({ 
	        	showOptions: { direction: "up" } ,
	        	inline: true, 
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
		
		//navigationに色入れる
		$("a").removeAttr("background-color");
		 $("#1").css("background-color","#B0E0E6");
		var getCategory = $('#category').val();
		if (getCategory != "") {
			var category = $('.category');
			category.attr('class', 'category');
			$('.a_category').each(function(index, item) {
				if ($(item).text() == getCategory){
					$(item).parent().attr('class', 'category active');
				}
			});
			
		}
		
		//個人的にメールを転送
		pdialog = $('#dialog-personal').dialog({
			autoOpen: false,
			height: 600,
			width: 450,
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
		
		//整列
		$('#rid').text("受付番号(－)");
		$('#kanji_name').text("受験者名(－)");
		$('#uid').text("メール(－)");
		$('#rcreated_at').text("登録日付(－)");
		$('#modified_at').text("確認日付(－)");
		$('#akanji_name').text("担当者(－)");
		var temp = $('#array').val().split(" ");
		switch (temp[0]) {
		case "rid":
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
		case "uid":
			if (temp[1] != null) {
				$('#'+temp[0]).text("メール(▼)");
			} else {
				$('#'+temp[0]).text("メール(▲)");
			}
			break;
		case "rcreated_at":
			if (temp[1] != null) {
				$('#'+temp[0]).text("登録日付(▼)");
			} else {
				$('#'+temp[0]).text("登録日付(▲)");
			}
			break;
		case "modified_at":
			if (temp[1] != null) {
				$('#'+temp[0]).text("確認日付(▼)");
			} else {
				$('#'+temp[0]).text("確認日付(▲)");
			}
			break;
		case "akanji_name":
			if (temp[1] != null) {
				$('#'+temp[0]).text("担当者(▼)");
			} else {
				$('#'+temp[0]).text("担当者(▲)");
			}
			break;
		}
		
		//search form validate
		$("#search").validate({
			
			submitHandler: function(frm){
				var select = $("#select").val();
				var text = $("#text").val();
				if(select==""){
					alert("検索条件を選択してください。");
					return false;
				}
				if(select=="enroll_date"||select=="submit_date"){
					var startdate = $("#startDate").val();
					var enddate = $("#endDate").val();
					if(startdate==""||enddate==""){
						alert("日付を選択してください。");
						return false;
						}
				}
				   if(select=="id"||select=="report_id"||select=="kanji_name"||select=="resposible"){
      					var x = /^[\S]+$/;
      					if(x.test(text)==false||text==null){
      						alert("検索語を入力してください。");
      						return x.test(text);
      					}
      				}
				frm.submit();
				
			}	
			  
		});
	});
	
	//ページ移動のとき
	function movePage(pageNum) {
		document.pageForm.action="appDoc";
		document.pageForm.currentPage.value=pageNum;
		document.pageForm.submit();
	}
	
	//ページのグロープ移動のとき
	function moveGroup(pageNum) {
		document.pageForm.action="appDoc";
		document.pageForm.currentPage.value=pageNum;
		document.pageForm.submit();
	}
	
	//TAPでCATEGORY移動のとき
	function moveCategory(category) {
		document.categoryForm.action="appDoc";
		document.categoryForm.category.value=category;
		document.categoryForm.viewName.value="insuffDocView";
		document.categoryForm.submit();
	}
	
	//学生の願書OZ-FORM
	function goAppForm(rid, sort, number, modifiedozd) {
		switch(sort) {
			case "AO入学": sort = "AO"; break;
			case "一般入学": sort = "common"; break;
			case "特待生入学": sort = "special"; break;
			case "社会人入学": sort = "society"; break;
			case "公募推薦入学": sort = "recommend"; break;
			case "センター利用入学": sort = "center"; break;
		}
		var width = screen.width;
		var height = screen.height;
		window.open("http://192.168.1.51:9999/kissco/oz/samplehubi.html?sort="+ sort + "&rid="+rid + "&number=" + number+ "&modifiedozd=" + modifiedozd, "願書", "width="+width*2/3+", height="+height+", toolbar=no, menubar=no, scrollbars=no, resizable=yes");
		
		/* document.appGoForm.action="appForm";
		document.appGoForm.rid.value=rid;
		document.appGoForm.sort.value=sort;
		document.appGoForm.submit(); */
	}
	
	//整列
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
		document.arrayField.action="appDoc";
		document.arrayField.submit();
	}
	//メール作成form
	function goMailForm(uid) {
		document.getElementById('recipient_per').setAttribute("value", uid);
		pdialog.dialog("open");
	}
	
	//検索のselect box変更のとき
	function change(){

		$(".text").attr("type","text");
		var x = $("#select").val();
		if(x=="enroll_date"||x=="submit_date"){
			$(".text").val("");
			$(".text").attr("type","hidden");
			$("#startDate").attr("type","text");
			$("#endDate").attr("type","text");
			var span = $("<strong>~</strong>");
			$("#span").html(span);
		}
		else{
			$("#startDate").attr("type","hidden"); 
			$("#endDate").attr("type","hidden");
			$("#span").html("");   

		}
		$(".error").text("");
	}
</script>
</head>
<body><br><br><br>
	<div class="col-xs-8 col-xs-offset-2">
		<ul class="nav nav-tabs nav-justified" style="margin-left: 0px">
			<li role="presentation" class="category active"><a class="a_category" href="javascript:moveCategory('すべて')">すべて</a></li>
			<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('一般入学')">一般入学</a></li>
			<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('センター利用入学')">センター利用入学</a></li>
			<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('公募推薦入学')">公募推薦入学</a></li>
			<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('社会人入学')">社会人入学</a></li>
			<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('特待生入学')">特待生入学</a></li>
			<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('AO入学')">AO入学</a></li>
		</ul>
		<form name="categoryForm" method="post">
			<input type="hidden" name="category" id="category" value="${category }">
			<input type="hidden" name="viewName" value="">
			<input type="hidden" name="currentPage" value="1">
		</form>
		<div class="container_tmp">
			<span style="line-height: 1%;"><br></span>
			<div>
				<table class="table table-hover table-bordered">
					<thead class="tr_title"  style="font-weight: bold;">
						<input type="hidden" id="array" value="${array }">
						<td><a href="javascript:array('rid')" id="rid" style="text-decoration: none;">受付番号(▼)</a>
						<td>状態
						<td>受験タイプ
						<td><a href="javascript:array('kanji_name')" id="kanji_name" style="text-decoration: none;">受験者名(－)</a>
						<td><a href="javascript:array('uid')" id="uid" style="text-decoration: none;">メール(－)</a>
						<td><a href="javascript:array('rcreated_at')" id="rcreated_at" style="text-decoration: none;">登録日付(－)</a>
						<td><a href="javascript:array('modified_at')" id="modified_at" style="text-decoration: none;">確認日付(－)</a>
						<td><a href="javascript:array('akanji_name')" id="akanji_name" style="text-decoration: none;">担当者(－)</a>
					</thead>
					<c:if test="${appList != null}">
						<c:forEach var="appList" items="${appList}" varStatus="status">
							<tr class="tr">
								<td><a href="javascript:goAppForm('${appList.rid }', '${appList.name }', '${appList.number }', '${appList.modifiedozd }')">${appList.number }</a>
								<td>不備
								<td>${appList.name }
								<td>${appList.kanji_name }
								<td><a href="javascript:goMailForm('${appList.uid }')">${appList.uid }</a>
								<td>${appList.rcreated_at }
								<td>${appList.modified_at }
								<td>${appList.akanji_name }
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>		
			<form name="appGoForm" method="post">
				<input type="hidden" name="rid">
				<input type="hidden" name="sort">
			</form>	
			<form name="arrayField" method="post">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="category" value="${category }">
				<input type="hidden" name="viewName" value="insuffDocView">
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
			
			<div align="center">
					<form name="search" id="search" action="appDoc" method="post">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="viewName" value="insuffDocView">
					<input type="hidden" name="category" value="${category }">
				<select name="select" id="select" onchange="javascript:change();">
				<option value="">検索条件を選択してください</option>
				<option value="report_id">受付番号</option>
				<option value="kanji_name">受験者名</option>
				<option value="id">メール</option>
				<option value="enroll_date">登録日付</option>
				<option value="submit_date">確認日付</option>
				<option value="resposible">担当者</option>
				</select>
				<input type="text" name="text" id="text" class="text">
				<input type="text" name="startdate" id="startDate" class="tbox03" placeholder="クリックしてください" readonly/> <span id="span"></span>
		<input type="text" name="enddate" id="endDate" class="tbox03" placeholder="クリックしてください" readonly/>
<input type="submit" value="検索">
				</form>
				<form name="pageForm" action="../appDoc" method="POST">
					<input type="hidden" name="currentPage" value="">
					<input type="hidden" name="category" value="${category }">
					<input type="hidden" name="viewName" value="insuffDocView">
					<input type="hidden" name="array" value="${array }">
					<input type="hidden" name="startdate" value="${startdate }">
					<input type="hidden" name="enddate" value="${enddate }">
					<input type="hidden" name="select" value="${select }">
					<input type="hidden" name="text" value="${text }">
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
</body>
</html>