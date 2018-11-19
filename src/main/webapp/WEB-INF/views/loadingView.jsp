<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="org.apache.log4j.*, oz.framework.api.*, oz.scheduler.*, oz.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./resources/css/loading/loading.css">
<title></title>
</head>
<body>
	<form name="form" action="appDoc" method="POST">
		<input type="hidden" name="isUser" value="${isUser }">
		<input type="hidden" name="session" value="${identity }">
		<input type="hidden" name="currentPage" value="${currentPage }">
		<input type="hidden" name="viewName" value="appDocView">
		<input type="hidden" name="category" value="すべて">
		<input type="hidden" name="state" value="1">
	</form>
	
	<script type="text/javascript">
		setTimeout('form.submit();',700);
	</script>
	
	
	<div class="loading-container">
	    <div class="loading"></div>
	    <div id="loading-text">loading</div>
	</div>
</body>
</html>