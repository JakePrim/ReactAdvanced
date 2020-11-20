<%@page import="java.util.List"%>
<%@page import="com.jakeprim.domain.Book" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String bookId = request.getParameter("bookId");
	Book updateBook = null;
	List<Book> books = (List<Book>) request.getServletContext().getAttribute("books");
	for (Book book : books) {
		if (book.getBookId().equals(bookId)) {
			updateBook = book;
			System.out.println(book);
			request.setAttribute("updateBook", book);
			break;
		}
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>修改图书信息</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/add.css">
<script type="text/javascript">
	function validate_from() {
		var bookId = document.getElementById("bookId").value;
		if (bookId == null || bookId == '') {
			alert("图书编号不能为空");
			return false;
		}
		var idreg = /^b[0-9]{4}$/;
		if (!idreg.test(bookId)) {
			alert("图书编号以b开头,后面跟4个随机数");
			return false;
		}
		var bookName = document.getElementById("bookName").value;
		if (bookName == null || bookName == '') {
			alert("图书名不能为空");
			return false;
		}
		var bookPrice = document.getElementById("bookPrice").value;
		if (bookPrice == null || bookPrice == '') {
			alert("图书价格不能为空");
			return false;
		}
		var reg = /(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/;
		if (!reg.test(bookPrice)) {
			alert("图书价格填写不正确");
			return false;
		}
		var remarks = document.getElementById("remarks").value;
		if (remarks == null || remarks == '') {
			alert("图书备注不能为空");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/dept/list.do"> 图书信息管理 </a>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<h1>Hello, XXX!</h1>
			<p>请小心的修改图书信息。。。</p>
		</div>
		<div class="page-header">
			<h3>
				<small>修改</small>
			</h3>
		</div>
		<c:if test="${updateBook != null }">
			<form class="form-horizontal" onsubmit="return validate_from()"
				action="${pageContext.request.contextPath }/dept/update.do"
				method="post" enctype="multipart/form-data">

				<div class="form-group">
					<label for="name" class="col-sm-2 control-label">图书编号 ：</label>
					<div class="col-sm-8">
						<input name="bookId" class="form-control" id="bookId"
							readonly="readonly" value="${updateBook.bookId }">
					</div>
				</div>
				<div class="form-group">
					<label for="name" class="col-sm-2 control-label">图书名称 ：</label>
					<div class="col-sm-8">
						<input name="bookName" class="form-control" id="bookName"
							value="${updateBook.bookName }">
					</div>
				</div>
				<div class="form-group">
					<label for="categoryId" class="col-sm-2 control-label">分类 ：</label>
					<select id="categoryId" name="categoryId"
						class="col-sm-2 form-control"
						style="width: auto; margin-left: 15px">
						<c:forEach items="${applicationScope.category }" var="ca"
							varStatus="idx">
							<c:if test="${updateBook.category.categoryId == ca.categoryId}">
								<option value="${ca.categoryId }" selected="selected">${ca.categoryName }</option>
							</c:if>
							<c:if test="${updateBook.category.categoryId != ca.categoryId}">
								<option value="${ca.categoryId }">${ca.categoryName }</option>
							</c:if>
						</c:forEach>
					</select>
				</div>

				<div class="form-group">
					<label for="name" class="col-sm-2 control-label">价格 ：</label>
					<div class="col-sm-8">
						<input name="bookPrice" class="form-control" id="bookPrice"
							value="${updateBook.price }">
					</div>
				</div>

				<div class="form-group">
					<label for="name" class="col-sm-2 control-label">图书封面 ：</label> <input
						type="file" id="bookPic" name="bookPic" style="padding-left: 15px" value="${updateBook.path }">
				</div>

				<div class="form-group">
					<label for="name" class="col-sm-2 control-label">备注 ：</label>
					<div class="col-sm-8">
						<input name="remarks" class="form-control" id="remarks"
							value="${updateBook.note }">
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-primary">修改</button>
						&nbsp;&nbsp;&nbsp;
					</div>
				</div>
			</form>
		</c:if>
	</div>
	<footer class="text-center"> copy@imooc </footer>
</body>
</html>