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
<script src="<%=cp%>/resources/js/jquery-1.11.3.js" type="text/javascript"></script>
<script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
    <!-- ログインCSS -->
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="<%=cp%>/resources/js/jquery.validate.min.js" type="text/javascript"></script>
		<script src="<%=cp%>/resources/js/additional-methods.min.js" type="text/javascript"></script>
			<script src="<%=cp%>/resources/js/jquery.validate.js" type="text/javascript"></script>
				<script src="<%=cp%>/resources/js/additional-methods.js" type="text/javascript"></script>
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
	/* @media (min-width:768px){.nav-tabs.nav-justified>li{display:table-cell;width:i} */
	/* label, input { display:block; } */
</style>
<script type="text/javascript">
	$(document).ready(function(){
		//ナビゲーションバーに効果を付与
		$("a").removeAttr("background-color");
		$("#4").css("background-color","#B0E0E6");
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
		$('#kanji_name').text("管理者名(－)");
		$('#id').text("ID(－)");
		var temp = $('#array').val().split(" ");
		switch (temp[0]) {
		case "kanji_name":
			if (temp[1] != null) {
				$('#'+temp[0]).text("管理者名(▼)");
			} else {
				$('#'+temp[0]).text("管理者名(▲)");
			}
			break;
		case "id":
			if (temp[1] != null) {
				$('#'+temp[0]).text("ID(▼)");
			} else {
				$('#'+temp[0]).text("ID(▲)");
			}
			break;
		}
		
	});
	//管理者追加ボタンをクリックする時
	function add(){
		location.href="./addAdmin";
	}
	//管理者権限を変更ボタンをクリックする時
	//s：管理者のID
	function edit(s){
		var link="./editAdmin?pk="+s;
		window.open(link,"Window","width=470, height=500, menubar=no,status=yes,scrollbars=no");
	}
	//ページング
	function movePage(pageNum) {
		document.pageForm.action="againadmin";
		document.pageForm.currentPage.value=pageNum;
		document.pageForm.submit();
	}
	//Groupページング
	function moveGroup(pageNum) {
		document.pageForm.action="againadmin";
		document.pageForm.currentPage.value=pageNum;
		document.pageForm.submit();
	}
	//管理者権限を削除
	function del(s){
		//削除する前に確認メッセージを表示
		if (confirm("該当管理者を脱退させますか")) {
			location.href="./delAdmin?pk="+s;
        } else {
            history(-1);
        }
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
		document.arrayField.action="againadmin";
		document.arrayField.submit();
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
<table class="table table-hover table-bordered ">
<input type="hidden" id="array" value="${array }">
<thead class="tr" style="font-weight: bold;">
<td><a href="javascript:array('kanji_name')" id="kanji_name" style="text-decoration: none;">管理者名(▼)</a></td>
<td><a href="javascript:array('id')" id="id" style="text-decoration: none;">ID(－)</a></td>
<td>権限</td>
<td>修正/削除</td></thead>
<c:forEach items="${appList}" var="usersVo">
<tr class="tr"><td>${usersVo.kanji_name}</td><td>${usersVo.id}</td>
<td><c:if test="${usersVo.admin=='2'}">特殊</c:if>
<c:if test="${usersVo.admin=='1'}">一般</c:if>
</td><td align="center" style="width: 200px"><button style="width: 60px; height: 30px;" class="btn btn-default btn-xs" onclick="javascript:edit('${usersVo.id}');">修正</button>
<button style="width: 60px; height: 30px;" class="btn btn-default btn-xs" onclick="javascript:del('${usersVo.id}');">削除</button></td></tr>
</c:forEach>
</table>
<button class="btn btn-default" onclick="javascript:add();">管理者追加</button>
<!-- 페이지 이동 -->
<div align="center">
	<form name="search" id="search" action="againadmin" method="get">
	<input type="hidden" name="currentPage" value="1">
			<select name="select" id="select" onchange="javascript:onchange1();">
			<option value="">検索条件を選択してください</option>
			<option value="admin">管理者名</option>
			<option value="id">ID</option>
			</select>
			<input type="text" name="text" id="text">
			<input type="submit" value="検索">
			</form>
			<form name="pageForm" action="admin" method="get">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="viewName" value="appDocView">
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
<form name="arrayField" method="get">
		<input type="hidden" name="currentPage" value="1">
		<input type="hidden" name="category" value="${category }">
		<input type="hidden" name="array" value="">
</form>	

</div>
<input type="hidden" value="${filter }" id="filter">
<input type="hidden" value="${keyword }" name="filter">
</body>
</html>
