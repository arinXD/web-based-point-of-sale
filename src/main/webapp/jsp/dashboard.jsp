<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
    <h1>Dashboard</h1>

    <div>
        <h2>Total Quantity: ${totalQuantity}</h2>
        <h2>Total Price: ${totalPrice}</h2>
    </div>

    <div>

        <table border="1">
            <thead>
                <tr>
                    <th>Menu</th>
                    <th>Percentage</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${menuSalesPercentage}" var="menuEntry">
                    <tr>
                        <td>${menuEntry.key}</td>
                        <td><fmt:formatNumber value="${menuEntry.value}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
