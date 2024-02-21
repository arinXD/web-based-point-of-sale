<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Menu</title>
</head>
<body>
	<h1>Menu</h1>
	<form action="/menu" method="post">
    <label>Name</label>
    <input type="text" name="name" required> 
    <label>Price</label>
    <input type="number" name="price" required> <br>
    <input type="radio" id="food" name="categoryId" value="1">
  	<label for="html">อาหาร</label>
  	<input type="radio" id="water" name="categoryId" value="2">
  	<label for="css">น้ำ</label><br>
    <input type="submit" value="Submit">
</form>
	<c:forEach items="${menus}" var="menu">
		${menu.productTitle}
		${menu.productPrice}
		<a href="/menu/${menu.productId}" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
	</c:forEach>
	
</body>
</html>