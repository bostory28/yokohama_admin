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
<style type="text/css">
	.tr td {
			text-align: center;
			height: 47px;
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
<title>受験者</title>

<script src="<%=cp%>/resources/js/jquery-1.11.3.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/jquery.validate.min.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/additional-methods.min.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/jquery.validate.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/additional-methods.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/js/jquery-ui-1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="<%=cp%>/resources/js/jquery-ui-1.11.4/jquery-ui.css">
<script type="text/javascript">
	var pdialog;
	$(document).ready(function(){
		//ナビゲーションバーに効果を付与
		$("a").removeAttr("background-color");
		 $("#3").css("background-color","#B0E0E6");
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
					if(select=="id"||select=="admin"){
						var x = /^[\S]+$/;
						if(x.test(text)==false||text==null){
							alert("検索語を入力してください。");
							return x.test(text);
						}
					}
					frm.submit();
					
			}	
			  
		});

		/* 整列 */
		$('#name').text("受験者名(－)");
		$('#id').text("メール(－)");
		var temp = $('#array').val().split(" ");
		switch (temp[0]) {
		case "name":
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
		}
		
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
	});
	//ページング
	function movePage(pageNum) {
		document.pageForm.action="againtestee";
		document.pageForm.currentPage.value=pageNum;
		document.pageForm.submit();
	}
	//Groupページング
	function moveGroup(pageNum) {
		document.pageForm.action="againtestee";
		document.pageForm.currentPage.value=pageNum;
		document.pageForm.submit();
	}
	//願書を見るページ
	function view(rid,number,sort){
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
		window.open("http://192.168.1.51:9999/kissco/oz/sample.html?sort="+ sort + "&rid="+rid+"&number="+number, "願書", "width="+width*2/3+", height="+height+", toolbar=no, menubar=no, scrollbars=no, resizable=yes");
		
	/*  var target_name="aaaa";
	 var aa=window.open("about:blank",target_name,"width=1000, height=1000, resizable= yes");
	 document.appGoForm.target = target_name;
	 document.appGoForm.action="appForm";
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
		document.arrayField.action="againtestee";
		document.arrayField.submit();
	}
	//メール作成form
	function goMailForm(uid) {
		document.getElementById('recipient_per').setAttribute("value", uid);
		pdialog.dialog("open");
	}
	function onchange1(){
		$(".error").text("");
	}
</script>
</head>
<body>
<br><br><br>
<div class="col-xs-8 col-xs-offset-2">
<div class="container_tmp">
<table class="table table-bordered table-hover">
	<input type="hidden" id="array" value="${array }">
	<thead class="tr" style="font-weight: bold;">
	<td><a href="javascript:array('name')" id="name" style="text-decoration: none;">受験者名(▼)</a></td>
	<td><a href="javascript:array('id')" id="id" style="text-decoration: none;">メール(－)</a></td>
	<td>一般入学</td>
	<td>センター利用入学</td>
	<td>公募推薦入学</td>
	<td>社会人入学</td>
	<td>特待生入学</td>
	<td>AO入学</td></thead>
	<c:forEach items="${appList}" var="usersVo">
	<tr class="tr"><td>${usersVo.name}</td>
	<td><a href="javascript:goMailForm('${usersVo.id }')">${usersVo.id}</a></td>
	<td>
	<c:if test="${usersVo.reportname1=='一般入学'}">
		<c:if test="${usersVo.state1==0}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','一般入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state1==1}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','一般入学')">申請済</a></c:if>
		<c:if test="${usersVo.state1==2}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','一般入学')">不備</a></c:if>
		<c:if test="${usersVo.state1==3}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','一般入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname2=='一般入学'}">
		<c:if test="${usersVo.state2==0}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','一般入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state2==1}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','一般入学')">申請済</a></c:if>
		<c:if test="${usersVo.state2==2}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','一般入学')">不備</a></c:if>
		<c:if test="${usersVo.state2==3}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','一般入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname3=='一般入学'}">
		<c:if test="${usersVo.state3==0}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','一般入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state3==1}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','一般入学')">申請済</a></c:if>
		<c:if test="${usersVo.state3==2}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','一般入学')">不備</a></c:if>
		<c:if test="${usersVo.state3==3}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','一般入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname4=='一般入学'}">
		<c:if test="${usersVo.state4==0}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','一般入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state4==1}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','一般入学')">申請済</a></c:if>
		<c:if test="${usersVo.state4==2}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','一般入学')">不備</a></c:if>
		<c:if test="${usersVo.state4==3}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','一般入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname5=='一般入学'}">
		<c:if test="${usersVo.state5==0}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','一般入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state5==1}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','一般入学')">申請済</a></c:if>
		<c:if test="${usersVo.state5==2}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','一般入学')">不備</a></c:if>
		<c:if test="${usersVo.state5==3}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','一般入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname6=='一般入学'}">
		<c:if test="${usersVo.state6==0}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','一般入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state6==1}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','一般入学')">申請済</a></c:if>
		<c:if test="${usersVo.state6==2}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','一般入学')">不備</a></c:if>
		<c:if test="${usersVo.state6==3}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','一般入学')">完了</a></c:if>
	</c:if>
	</td>
	<td>
	<c:if test="${usersVo.reportname1=='センター利用入学'}">
		<c:if test="${usersVo.state1==0}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','センター利用入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state1==1}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','センター利用入学')">申請済</a></c:if>
		<c:if test="${usersVo.state1==2}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','センター利用入学')">不備</a></c:if>
		<c:if test="${usersVo.state1==3}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','センター利用入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname2=='センター利用入学'}">
		<c:if test="${usersVo.state2==0}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','センター利用入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state2==1}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','センター利用入学')">申請済</a></c:if>
		<c:if test="${usersVo.state2==2}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','センター利用入学')">不備</a></c:if>
		<c:if test="${usersVo.state2==3}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','センター利用入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname3=='センター利用入学'}">
		<c:if test="${usersVo.state3==0}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','センター利用入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state3==1}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','センター利用入学')">申請済</a></c:if>
		<c:if test="${usersVo.state3==2}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','センター利用入学')">不備</a></c:if>
		<c:if test="${usersVo.state3==3}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','センター利用入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname4=='センター利用入学'}">
		<c:if test="${usersVo.state4==0}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','センター利用入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state4==1}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','センター利用入学')">申請済</a></c:if>
		<c:if test="${usersVo.state4==2}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','センター利用入学')">不備</a></c:if>
		<c:if test="${usersVo.state4==3}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','センター利用入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname5=='センター利用入学'}">
		<c:if test="${usersVo.state5==0}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','センター利用入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state5==1}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','センター利用入学')">申請済</a></c:if>
		<c:if test="${usersVo.state5==2}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','センター利用入学')">不備</a></c:if>
		<c:if test="${usersVo.state5==3}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','センター利用入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname6=='センター利用入学'}">
		<c:if test="${usersVo.state6==0}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','センター利用入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state6==1}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','センター利用入学')">申請済</a></c:if>
		<c:if test="${usersVo.state6==2}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','センター利用入学')">不備</a></c:if>
		<c:if test="${usersVo.state6==3}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','センター利用入学')">完了</a></c:if>
	</c:if>
	</td>
	<td>
	<c:if test="${usersVo.reportname1=='公募推薦入学'}">
		<c:if test="${usersVo.state1==0}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','公募推薦入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state1==1}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','公募推薦入学')">申請済</a></c:if>
		<c:if test="${usersVo.state1==2}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','公募推薦入学')">不備</a></c:if>
		<c:if test="${usersVo.state1==3}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','公募推薦入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname2=='公募推薦入学'}">
		<c:if test="${usersVo.state2==0}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','公募推薦入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state2==1}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','公募推薦入学')">申請済</a></c:if>
		<c:if test="${usersVo.state2==2}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','公募推薦入学')">不備</a></c:if>
		<c:if test="${usersVo.state2==3}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','公募推薦入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname3=='公募推薦入学'}">
		<c:if test="${usersVo.state3==0}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','公募推薦入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state3==1}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','公募推薦入学')">申請済</a></c:if>
		<c:if test="${usersVo.state3==2}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','公募推薦入学')">不備</a></c:if>
		<c:if test="${usersVo.state3==3}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','公募推薦入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname4=='公募推薦入学'}">
		<c:if test="${usersVo.state4==0}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','公募推薦入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state4==1}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','公募推薦入学')">申請済</a></c:if>
		<c:if test="${usersVo.state4==2}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','公募推薦入学')">不備</a></c:if>
		<c:if test="${usersVo.state4==3}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','公募推薦入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname5=='公募推薦入学'}">
		<c:if test="${usersVo.state5==0}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','公募推薦入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state5==1}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','公募推薦入学')">申請済</a></c:if>
		<c:if test="${usersVo.state5==2}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','公募推薦入学')">不備</a></c:if>
		<c:if test="${usersVo.state5==3}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','公募推薦入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname6=='公募推薦入学'}">
		<c:if test="${usersVo.state6==0}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','公募推薦入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state6==1}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','公募推薦入学')">申請済</a></c:if>
		<c:if test="${usersVo.state6==2}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','公募推薦入学')">不備</a></c:if>
		<c:if test="${usersVo.state6==3}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','公募推薦入学')">完了</a></c:if>
	</c:if>
	</td>
	<td>
	<c:if test="${usersVo.reportname1=='社会人入学'}">
		<c:if test="${usersVo.state1==0}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','社会人入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state1==1}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','社会人入学')">申請済</a></c:if>
		<c:if test="${usersVo.state1==2}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','社会人入学')">不備</a></c:if>
		<c:if test="${usersVo.state1==3}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','社会人入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname2=='社会人入学'}">
		<c:if test="${usersVo.state2==0}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','社会人入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state2==1}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','社会人入学')">申請済</a></c:if>
		<c:if test="${usersVo.state2==2}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','社会人入学')">不備</a></c:if>
		<c:if test="${usersVo.state2==3}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','社会人入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname3=='社会人入学'}">
		<c:if test="${usersVo.state3==0}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','社会人入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state3==1}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','社会人入学')">申請済</a></c:if>
		<c:if test="${usersVo.state3==2}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','社会人入学')">不備</a></c:if>
		<c:if test="${usersVo.state3==3}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','社会人入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname4=='社会人入学'}">
		<c:if test="${usersVo.state4==0}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','社会人入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state4==1}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','社会人入学')">申請済</a></c:if>
		<c:if test="${usersVo.state4==2}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','社会人入学')">不備</a></c:if>
		<c:if test="${usersVo.state4==3}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','社会人入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname5=='社会人入学'}">
		<c:if test="${usersVo.state5==0}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','社会人入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state5==1}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','社会人入学')">申請済</a></c:if>
		<c:if test="${usersVo.state5==2}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','社会人入学')">不備</a></c:if>
		<c:if test="${usersVo.state5==3}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','社会人入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname6=='社会人入学'}">
		<c:if test="${usersVo.state6==0}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','社会人入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state6==1}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','社会人入学')">申請済</a></c:if>
		<c:if test="${usersVo.state6==2}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','社会人入学')">不備</a></c:if>
		<c:if test="${usersVo.state6==3}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','社会人入学')">完了</a></c:if>
	</c:if>
	</td>
		<td>
	<c:if test="${usersVo.reportname1=='特待生入学'}">
		<c:if test="${usersVo.state1==0}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','特待生入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state1==1}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','特待生入学')">申請済</a></c:if>
		<c:if test="${usersVo.state1==2}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','特待生入学')">不備</a></c:if>
		<c:if test="${usersVo.state1==3}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','特待生入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname2=='特待生入学'}">
		<c:if test="${usersVo.state2==0}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','特待生入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state2==1}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','特待生入学')">申請済</a></c:if>
		<c:if test="${usersVo.state2==2}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','特待生入学')">不備</a></c:if>
		<c:if test="${usersVo.state2==3}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','特待生入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname3=='特待生入学'}">
		<c:if test="${usersVo.state3==0}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','特待生入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state3==1}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','特待生入学')">申請済</a></c:if>
		<c:if test="${usersVo.state3==2}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','特待生入学')">不備</a></c:if>
		<c:if test="${usersVo.state3==3}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','特待生入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname4=='特待生入学'}">
		<c:if test="${usersVo.state4==0}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','特待生入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state4==1}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','特待生入学')">申請済</a></c:if>
		<c:if test="${usersVo.state4==2}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','特待生入学')">不備</a></c:if>
		<c:if test="${usersVo.state4==3}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','特待生入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname5=='特待生入学'}">
		<c:if test="${usersVo.state5==0}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','特待生入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state5==1}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','特待生入学')">申請済</a></c:if>
		<c:if test="${usersVo.state5==2}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','特待生入学')">不備</a></c:if>
		<c:if test="${usersVo.state5==3}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','特待生入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname6=='特待生入学'}">
		<c:if test="${usersVo.state6==0}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','特待生入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state6==1}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','特待生入学')">申請済</a></c:if>
		<c:if test="${usersVo.state6==2}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','特待生入学')">不備</a></c:if>
		<c:if test="${usersVo.state6==3}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','特待生入学')">完了</a></c:if>
	</c:if>
	</td>
	<td>
	<c:if test="${usersVo.reportname1=='AO入学'}">
		<c:if test="${usersVo.state1==0}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','AO入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state1==1}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','AO入学')">申請済</a></c:if>
		<c:if test="${usersVo.state1==2}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','AO入学')">不備</a></c:if>
		<c:if test="${usersVo.state1==3}"><a href="javascript:view('${usersVo.report1}','${usersVo.number}','AO入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname2=='AO入学'}">
		<c:if test="${usersVo.state2==0}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','AO入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state2==1}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','AO入学')">申請済</a></c:if>
		<c:if test="${usersVo.state2==2}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','AO入学')">不備</a></c:if>
		<c:if test="${usersVo.state2==3}"><a href="javascript:view('${usersVo.report2}','${usersVo.number}','AO入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname3=='AO入学'}">
		<c:if test="${usersVo.state3==0}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','AO入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state3==1}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','AO入学')">申請済</a></c:if>
		<c:if test="${usersVo.state3==2}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','AO入学')">不備</a></c:if>
		<c:if test="${usersVo.state3==3}"><a href="javascript:view('${usersVo.report3}','${usersVo.number}','AO入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname4=='AO入学'}">
	<c:if test="${usersVo.state4==0}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','AO入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state4==1}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','AO入学')">申請済</a></c:if>
		<c:if test="${usersVo.state4==2}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','AO入学')">不備</a></c:if>
		<c:if test="${usersVo.state4==3}"><a href="javascript:view('${usersVo.report4}','${usersVo.number}','AO入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname5=='AO入学'}">
			<c:if test="${usersVo.state5==0}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','AO入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state5==1}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','AO入学')">申請済</a></c:if>
		<c:if test="${usersVo.state5==2}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','AO入学')">不備</a></c:if>
		<c:if test="${usersVo.state5==3}"><a href="javascript:view('${usersVo.report5}','${usersVo.number}','AO入学')">完了</a></c:if>
	</c:if>
	<c:if test="${usersVo.reportname6=='AO入学'}">
		<c:if test="${usersVo.state6==0}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','AO入学')">迷衲</a></c:if>
		<c:if test="${usersVo.state6==1}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','AO入学')">申請済</a></c:if>
		<c:if test="${usersVo.state6==2}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','AO入学')">不備</a></c:if>
		<c:if test="${usersVo.state6==3}"><a href="javascript:view('${usersVo.report6}','${usersVo.number}','AO入学')">完了</a></c:if>
	</c:if>
	</td>
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
		<form name="search" id="search" action="againtestee" method="get">
			<input type="hidden" name="currentPage" value="1">
			<select name="select" id="select" onchange="javascirpt:onchange1();">
			<option value="">検索条件を選択してください</option>
			<option value="admin">受験者名</option>
			<option value="id">メール</option>
			</select>
			<input type="text" name="text" id="text">
			<input type="submit" value="検索">
			</form>

			<form name="pageForm" action="testee" method="get">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="array" value="${array }">
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
<br><br><br>
</body>
</html>
