<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bill</title>
<script>
    function validatePayment() {
        var amountPaid = document.getElementById("amountPaid").value;
        var totalPrice = document.getElementById("totalPrice").value;
        
        if (parseFloat(amountPaid) < parseFloat(totalPrice)) {
            alert("จำนวนเงินที่ชำระควรเท่ากับหรือมากกว่าราคารวม");
            return false;
        }
        
        return true;
    }
    
    function setAmountPaid() {
        var amountPaidInput = document.getElementById("amountPaid");
        var checkbox = document.getElementById("checkbox");
        var methodInput = document.getElementById("method");
        var totalPrice = parseFloat(document.getElementById("totalPrice").value);

        if (checkbox.checked) {
            amountPaidInput.value = totalPrice;
        } else {
            amountPaidInput.value = "";
        }
    }
</script>
</head>
<body>
    <h1>Bill</h1>
    <table border="1">
        <thead>
            <tr>
                <td>Table:</td>
                <td>${orderDetails[0].restaurantOrder.restaurantTable.tableId}</td>
                <td>${orderDetails[0].restaurantOrder.orderType}</td>
            </tr>
            <tr>
                <th>Product Title</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${orderDetails}" var="orderDetail">
                <tr>
                    <td>${orderDetail.product.productTitle}</td>
                    <td>${orderDetail.quantity}</td>
                    <td>${orderDetail.price}</td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="2"><b>Total:</b></td>
                <td>
                    <c:choose>
                        <c:when test="${empty orderDetails}">
                            0
                        </c:when>
                        <c:otherwise>
                            <c:set var="totalPrice" value="0" />
                            <c:forEach items="${orderDetails}" var="orderDetail">
                                <c:set var="totalPrice" value="${totalPrice + orderDetail.price}" />
                            </c:forEach>
                            ${totalPrice}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </tbody>
    </table>

    <form action="/history" method="POST" onsubmit="return validatePayment()">
    <label for="amountPaid">Amount Paid:</label>
    <input type="number" id="amountPaid" name="amountPaid" required value="">
	<input type="checkbox" id="checkbox" onchange="setAmountPaid()" name="method"> Pay Total Price
    <input type="hidden" id="totalPrice" name="totalPrice" value="${totalPrice}">
    <c:forEach items="${orderDetails}" var="orderDetail">
        <input type="hidden" id="orderId" name="orderId" value="${orderDetail.restaurantOrder.orderId}">
    </c:forEach>
    <input type="submit" value="Calculate Change">
</form>
    
</body>
</html>
