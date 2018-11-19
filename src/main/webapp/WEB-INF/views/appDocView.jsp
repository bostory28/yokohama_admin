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
<title>申請済</title>
<style type="text/css">
	.tr td {
		text-align: center;
	}
	.container_tmp {
		width: 100% !important;
	}
	@media screen and (max-width:1700px){
		.container_tmp {
			width: 1100px !important;
		}
	}
	/* label, input { display:block; } */
</style>
<script type="text/javascript">
	var pdialog;
	$(document).ready(function() {
		$("#startDate").attr("type","hidden");  
		$("#endDate").attr("type","hidden"); 
		$("#span").html("");
		$("#div").hide();
		//日付検索
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
				
	              beforeShow: function (textbox, instance) {
		            instance.dpDiv.css({
		                    marginTop: (-textbox.offsetHeight) -287 + 'px'
		                    
		            });
		            },
		            showOptions: { direction: "up" } ,
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
			                    marginTop: (-textbox.offsetHeight) - 287 + 'px'
			                    
			            });
			            }
			});
	    });		
		
		//修正のdialog
	   var mdialog = $('.dialog-modify').dialog({
			autoOpen: false,
			height: 600,
			width: 450,
			modal: true,
			buttons: {
				"送信": sendModifyMail,
				"取り消し": function() {
					mdialog.dialog("close");
				},
			}
		});

		//完了のdialog
		var cdialog = $(".dialog-complete").dialog({
			autoOpen: false,
			resizable: false,
			height:180,
			width: 296,
			modal: true,
			buttons: {
				"送信": sendCompleteMail,
				"取り消し": function() {
					$( this ).dialog( "close" );
				}
			}
		});
		
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
				   if(select=="id"||select=="report_id"||select=="kanji_name"){
      					var x = /^[\S]+$/;
      					if(x.test(text)==false||text==null){
      						alert("検索語を入力してください。");
      						return x.test(text);
      					}
      				}
				frm.submit();
				
			}	
			  
		});

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
		

		//修正ボタンクリック時dialog開ける
	    $(".insuffDoc").button().on("click", function() {
	    	$('#recipient').val($(this).attr('uid'));
	    	document.inSuffForm.rid.value=$(this).val();
	    	document.inSuffForm.number.value=$(this).val('number');
			document.inSuffForm.uid.value=$(this).attr('uid');
			$('#body_tmp').val(
				$(this).attr('uname')+"様\n\n"
				+"ご提出頂いた願書のご記入案内に不備がございます。\n\n"
				+"願書提出Appから「不備」と表示されている願書の\n"
				+"チェックされている項目をご修正いただき再度提出する\n"
				+"ようお願い申し上げます。\n\n"
				+"何かご不明な点等がございましたら、ご遠慮なくお問い合わせください。\n\n"
				+"<本件に関するお問合わせ先>\n"
				+"受付担当　Tel:000-000-000"
			);
			mdialog.dialog("open");
		});
		
	    //完了ボタンクリック時dialog開ける
	    $(".suffDoc").button().on("click", function() {
	    	$('#complete-content').html(
	    		'<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>'+"「" + $(this).attr('uname') +"様」に受験票をメールで発送しますか。"	
	    	);
	    	document.suffForm.rid.value=$(this).val();
			document.suffForm.uid.value=$(this).attr('uid');
			document.suffForm.number.value=$(this).attr('number');
			document.suffForm.uname.value=$(this).attr('uname');
			cdialog.dialog("open");
		});
		
		//修正メールを送る
		function sendModifyMail() {
			document.inSuffForm.action="appIssuffDoc";
			document.inSuffForm.subject.value=$('#subject_tmp').val();
			document.inSuffForm.body.value=$('#body_tmp').val();
			
			document.inSuffForm.submit();
		}
		
		//完了メールを送る
		function sendCompleteMail() {
			document.suffForm.action="appIssuffDoc";
			document.suffForm.submit();
		}
		
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
				dataType: 'json',
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
		}
		
		//navigationに色入れる
		$("a").removeAttr("background-color");
		$("#0").css("background-color","#B0E0E6");
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
		document.categoryForm.viewName.value="appDocView";
		document.categoryForm.submit();
	}
	
	//学生の願書OZ-FORM
	function goAppForm(rid, sort, number, kanji_name ,uid, session) {
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
		window.open("http://192.168.1.51:9999/kissco/oz/sample.html?sort=" + sort + "&rid=" + rid + "&number=" + number + "&kanji_name=" + kanji_name + "&uid=" + uid+ "&session=" + session, "願書", "width="+width*2/3+", height="+height+", location=no, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
		
		//現在のブラウザでOZ-FORM出力
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
		if(x=="enroll_date"){
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
		<div class="container_tmp">
			<ul class="nav nav-tabs nav-justified" style="margin-left: 0px">
				<li role="presentation" class="category active"><a class="a_category" href="javascript:moveCategory('すべて')">すべて</a></li>
				<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('一般入学')">一般入学</a></li>
				<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('センター利用入学')">センター利用入学</a></li>
				<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('公募推薦入学')">公募推薦入学</a></li>
				<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('社会人入学')">社会人入学</a></li>
				<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('特待生入学')">特待生入学</a></li>
				<li role="presentation" class="category"><a class="a_category" href="javascript:moveCategory('AO入学')">AO入学</a></li>
			</ul>
		</div>
		<div class="container_tmp">
			<span style="line-height: 1%;"><br></span>
			<table class="table table-hover table-bordered">
				<thead class="tr" style="font-weight: bold;">
					<input type="hidden" id="array" value="${array }">
					<td><a href="javascript:array('rid')" id="rid" style="text-decoration: none;">受付番号(▼)</a>
					<td>状態
					<td>受験タイプ
					<td><a href="javascript:array('kanji_name')" id="kanji_name" style="text-decoration: none;">受験者名(－)</a>
					<td><a href="javascript:array('uid')" id="uid" style="text-decoration: none;">メール(－)</a>
					<td><a href="javascript:array('rcreated_at')" id="rcreated_at" style="text-decoration: none;">登録日付(－)</a>
					<td>確認日付
					<td>担当者
					<td>不備
					<td>完了
				</thead>
				<c:if test="${appList != null}">
					<c:forEach var="appList" items="${appList}" varStatus="status">
						<tr class="tr">
							<td><a href="javascript:goAppForm('${appList.rid }', '${appList.name }', '${appList.number }', '${appList.kanji_name }','${appList.uid }', '${session }')">${appList.number }</a>
							<td>申請済
							<td>${appList.name }
							<td>${appList.kanji_name }
							<td><a href="javascript:goMailForm('${appList.uid }')">${appList.uid }</a>
							<td>${appList.rcreated_at }
							<td>
							<td>
							<td><button class="insuffDoc btn btn-default btn-xs btn-danger" style="width: 60px; height: 30px;" value="${appList.rid }" uid="${appList.uid }" number="${appList.number }" uname=${appList.kanji_name }>不備</button>
							<td><button class="suffDoc btn btn-default btn-xs btn-info" style="width: 60px; height: 30px;" value="${appList.rid }" uid="${appList.uid }" number="${appList.number }" uname=${appList.kanji_name }>完了</button>
						</tr>
					</c:forEach>
				</c:if>
			</table>
		
		<div align="center">
			<form name="search" id="search" action="appDoc" method="post">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="viewName" value="appDocView">
				<input type="hidden" name="category" value="${category }">
				
				<select name="select" id="select" onchange="javascript:change();">
					<option value="">検索条件を選択してください</option>
					<option value="report_id">受付番号</option>
					<option value="kanji_name">受験者名</option>
					<option value="id">メール</option>
					<option value="enroll_date">登録日付</option>
				</select>
				<input type="text" name="text" id="text" class="text">
				    <input type="text" name="startdate" id="startDate" class="tbox03" placeholder="クリックしてください" readonly/> <span id="span"></span>
					<input type="text" name="enddate" id="endDate" class="tbox03" placeholder="クリックしてください" readonly/>
			    <input type="submit" value="検索">
			</form>
			
			
			
			<form name="pageForm" action="../appDoc" method="POST">
				<input type="hidden" name="currentPage" value="">
				<input type="hidden" name="category" value="${category }">
				<input type="hidden" name="viewName" value="appDocView">
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
	
	<!-- form -->
	<form name="categoryForm" method="post">
		<input type="hidden" name="category" id="category" value="${category }">
		<input type="hidden" name="viewName" value="">
		<input type="hidden" name="currentPage" value="1">
	</form>
	<form name="appGoForm" method="post">
		<input type="hidden" name="rid">
		<input type="hidden" name="sort">
	</form>	
	<form name="arrayField" method="post">
		<input type="hidden" name="currentPage" value="1">
		<input type="hidden" name="category" value="${category }">
		<input type="hidden" name="viewName" value="appDocView">
		<input type="hidden" name="array" value="">
	</form>	
	<form name="suffForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="rid">
		<input type="hidden" name="uid">
		<input type="hidden" name="number">
		<input type="hidden" name="uname">
		<input type="hidden" name="category" value="${category }">
		<input type="hidden" name="currentGroup" value="${currentGroup }">
		<input type="hidden" name="currentPage" value="${currentPage }">
		<input type="hidden" name="viewName" value="appDocView">
		<input type="hidden" name="state" value="1">
		<input type="hidden" name="changeState" value="3">
		<div id="div">
			<input type="file" id="upload1" name="upload" style="width: 100%;" class="text ui-widget-content ui-corner-all" >
		</div>
	</form>
	<form name="sendMailForm" method="post">
		<input type="hidden" name="uid" id="personalUid">
		<input type="hidden" name="subject" id="personalSubject">
		<input type="hidden" name="body" id="personalBody">
		<input type="hidden" name="viewName" value="appDocView">
		<input type="hidden" name="currentPage" value="1">
		<input type="hidden" name="isModifiedInfo" value="no">
	</form>
		<!-- 修正dialog -->	
		<div class="dialog-modify" title="不備メール発送">
			<p class="validateTips"></p>
			<fieldset>
				<label for="recipient">宛先</label>
				<input type="text" name="recipient" id="recipient" value="" style="width: 100%;" readonly="readonly" class="text ui-widget-content ui-corner-all">
				<span style="line-height: 50%;"><br></span>
				<label for="title">タイトル</label>
				<input type="text" name="title" id="subject_tmp" value="入試願書お申し込みについてのご案内" style="width: 100%;" class="text ui-widget-content ui-corner-all">
				<span style="line-height: 50%;"><br></span>
				<label for="content">内容</label>
				<textarea style="width: 100%;" rows="12" id="body_tmp" class="ui-widget-content ui-corner-all"></textarea>
				<span style="line-height: 50%;"><br></span>
				<label for="file1">ファイル</label>
				<form name="inSuffForm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="rid">
					<input type="hidden" name="uid">
					<input type="hidden" name="number">
					<input type="hidden" name="subject">
					<input type="hidden" name="body">
					<input type="hidden" name="uname">
					<input type="hidden" name="category" value="${category }">
					<input type="hidden" name="currentGroup" value="${currentGroup }">
					<input type="hidden" name="currentPage" value="${currentPage }">
					<input type="hidden" name="viewName" value="appDocView">
					<input type="hidden" name="state" value="1">
					<input type="hidden" name="changeState" value="2">
					<input type="file" id="upload1" name="upload" style="width: 100%;" class="text ui-widget-content ui-corner-all" >
				</form>
			</fieldset>
		</div>
	<!-- 完了dialog -->
	<div class="dialog-complete" title="受付完了">
		<p id="complete-content"></p>
	</div>
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
</body>
</html>