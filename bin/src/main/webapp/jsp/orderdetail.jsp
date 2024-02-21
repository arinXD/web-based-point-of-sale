<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details</title>
</head>
<body>
	<h1>Order Details</h1>
	<a href="/history">history</a>
	<a href="/menu">menu</a>
	<a href="/dashboard">dashboard</a>
	<table border="1">
		<thead>
			<tr>
				<th>Order Detail ID</th>
				<th>Quantity</th>
				<th>Price</th>
				<th>OrderID</th>
				<th>productTitle</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach items="${orderDetails}" var="orderDetail" varStatus="loop">
				<c:choose>
				<c:when test="${orderDetail.restaurantOrder.status == 1}">

					</c:when>
					<c:otherwise>
						<tr>
							<td>${orderDetail.orderDetailId}</td>
							<td>${orderDetail.quantity}</td>
							<td>${orderDetail.price}</td>
							<td>${orderDetail.restaurantOrder.orderId}</td>
							<td>${orderDetail.product.productTitle}</td>
							<c:if
								test="${loop.index == 0 || orderDetails[loop.index - 1].restaurantOrder.orderId != orderDetail.restaurantOrder.orderId}">
								<td><a
									href="orderdetail/${orderDetail.restaurantOrder.orderId}">View
										Order</a></td>
							</c:if>
						</tr>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>
