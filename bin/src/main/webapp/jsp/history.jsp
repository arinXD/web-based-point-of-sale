<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>History</title>
</head>
<body>
	<h1>Order History</h1>
	<a href="/orderdetail">OrderDetail</a>
	<c:forEach items="${orders}" var="order">
		<table border="1" style="margin-bottom: 20px; text-align: center;">
			<thead>
				<tr>
					<th>Order ID</th>
					<th>Date</th>
					<th>Time</th>
					<th>Order Type</th>
					<th>Table</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${order.status != 1}">
						<tr>
							<td colspan="6">Not data</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<td>${order.orderId}</td>
							<td><fmt:formatDate value="${order.date}" pattern="dd MM yyyy" /></td>
							<td><fmt:formatDate value="${order.date}" pattern="HH:mm" /></td>
							<td>${order.orderType}</td>
							<td>${order.restaurantTable.title == null ? 'กลับบ้าน' : order.restaurantTable.title}</td>
						</tr>
						<tr>
							<th colspan="2">productTitle</th>
							<th colspan="2">quantity</th>
							<th colspan="1">price</th>
						</tr>
						<c:forEach items="${order.orderDetails}" var="detail">
							<tr>
								<td colspan="2">${detail.product.productTitle}</td>
								<td colspan="2">${detail.quantity}</td>
								<td colspan="1">${detail.price}</td>
							</tr>
						</c:forEach>
						<tr>
							<th colspan="2">ลูกค้าจ่าย</th>
							<th colspan="1">total</th>
							<th colspan="1">moneyChange</th>
							<th colspan="1">expend</th>
						</tr>
						<tr>
							<td colspan="2">${order.total + order.moneyChange}</td>
							<td colspan="1">${order.total}</td>
							<td colspan="1">${order.moneyChange}</td>
							<td colspan="1">${order.method}</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</c:forEach>
</body>
</html>
