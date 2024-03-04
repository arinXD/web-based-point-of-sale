<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<!DOCTYPE html>
			<html>

			<head>
				<jsp:include page="components/Header.jsp" />
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

						calculateChange();
					}

					function removeLastDigit() {
						var amountPaidInput = document.getElementById("amountPaid");
						amountPaidInput.value = amountPaidInput.value.slice(0, -1);

						calculateChange();
					}

					function removenumber() {
						var amountPaidInput = document.getElementById("amountPaid");
						amountPaidInput.value = "";

						calculateChange();
					}

					function addToAmountPaid(number) {
						var amountPaidInput = document.getElementById("amountPaid");
						amountPaidInput.value += number;

						calculateChange();
					}

					function calculateChange() {
						var amountPaid = parseFloat(document.getElementById("amountPaid").value);
						var totalPrice = parseFloat(document.getElementById("totalPrice").value);

						var change = amountPaid - totalPrice;

						var changeInput = document.getElementById("moneychange");
						if (isNaN(change)) {
							changeInput.textContent = "0.0";
						} else {
							changeInput.textContent = change.toFixed(2);
						}
					}
				</script>

				<style>
					#customers {
						border-collapse: collapse;
						width: 80%;
					}

					#customers td,
					#customers th {
						border: 1px solid #ddd;
						padding: 8px;
					}

					#customers tr:nth-child(even) {
						background-color: #f2f2f2;
					}

					#customers tr:hover {
						background-color: #ddd;
					}

					#customers th {
						padding-top: 12px;
						padding-bottom: 12px;
						text-align: left;
						background-color: #0E9E67;
						color: white;
					}

					.scrollable-table-container {
						overflow-y: auto;
						/* Enable vertical scrollbar */
						-webkit-overflow-scrolling: touch;
						/* Enable smooth scrolling on iOS devices */
					}

					.total-fixed {
						position: fixed;
						bottom: 25%;
						left: 43.5%;
						width: auto;
					}
				</style>
			</head>

			<body class="bg-[#EAF9F4]">
				<jsp:include page="components/NavBar.jsp" />
				<div class="container mx-auto mt-5">
					<div class="flex flex-row gap-5">
						<div class="w-[60%]">
							<div class="bg-white border-1 rounded-md relative">
								<div class="flex justify-between bg-gray-200 px-10 py-5 text-2xl">
									<p>
										<fmt:formatDate value="${orderDetails[0].restaurantOrder.date}"
											pattern="dd/MM/yyyy" />
									</p>
									<p>${orderDetails[0].restaurantOrder.restaurantTable.title}</p>
									<p>${orderDetails[0].restaurantOrder.orderType}</p>
									<p>
										<fmt:formatDate value="${orderDetails[0].restaurantOrder.date}"
											pattern="HH:mm" />
									</p>
								</div>
								<div class="scrollable-table-container" style="max-height: 50vh; overflow-y: auto;">
									<table id="customers" style="margin: 2rem auto;">
										<thead>
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
										</tbody>
										<tfoot>
											<tr>
												<td colspan="3" class="text-end px-4">
													Total :
													<c:choose>
														<c:when test="${empty orderDetails}">
															0
														</c:when>
														<c:otherwise>
															<c:set var="totalPrice" value="0" />
															<c:forEach items="${orderDetails}" var="orderDetail">
																<c:set var="totalPrice"
																	value="${totalPrice + orderDetail.price}" />
															</c:forEach>
															${totalPrice}
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</tfoot>
									</table>
								</div>

							</div>
						</div>
						<div class="w-[40%]">
							<div class="bg-white border-1 rounded-md h-[75vh]">
								<div class="flex justify-center px-10 py-6 text-5xl">
									<p class="">Cashier</p>
								</div>
								<div class="flex justify-between bg-gray-200 px-10 py-8 text-2xl font-bold">
									<p>Total :</p>
									<p>
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
									</p>

								</div>
								<div class="flex justify-between py-5 px-10 text-xl">
									<p>Money change:</p>
									<p id="moneychange">0.0</p>

								</div>
								<hr>
								<form action="/history" method="POST" onsubmit="return validatePayment()"
									class="bg-white px-10 pt-6 pb-8 mb-4 mx-auto">
									<div class="flex justify-between mb-4 items-center">
										<label for="amountPaid" class="block text-gray-700 text-xl">Amount
											Paid:</label> <input type="number" id="amountPaid" name="amountPaid"
											required value=""
											class="shadow appearance-none border rounded w-2/3 py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
									</div>

									<div class="grid grid-cols-3 gap-4 mb-4 mt-8">
										<button type="button" onclick="addToAmountPaid(1)"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">1</button>
										<button type="button" onclick="addToAmountPaid(2)"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">2</button>
										<button type="button" onclick="addToAmountPaid(3)"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">3</button>
										<button type="button" onclick="addToAmountPaid(4)"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">4</button>
										<button type="button" onclick="addToAmountPaid(5)"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">5</button>
										<button type="button" onclick="addToAmountPaid(6)"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">6</button>
										<button type="button" onclick="addToAmountPaid(7)"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">7</button>
										<button type="button" onclick="addToAmountPaid(8)"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">8</button>
										<button type="button" onclick="addToAmountPaid(9)"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">9</button>
										<button type="button" onclick="removenumber()"
											class="bg-gray-200 text-center text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">C</button>
										<button type="button" onclick="addToAmountPaid(0)"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">0</button>
										<button type="button" onclick="removeLastDigit()"
											class="bg-gray-200 text-gray-700 font-bold py-4 px-4 rounded focus:outline-none focus:shadow-outline hover:bg-gray-300">
											&lt;</button>
									</div>

									<div class="mt-5 mb-5">
										<div class="flex items-center ">
											<input type="checkbox" id="checkbox" onchange="setAmountPaid()"
												name="method" class="mr-5 h-8 w-8 leading-tight"
												style="color: #EAF9F4;"> <label for="checkbox"
												class="text-xl">Transfer</label>
										</div>
										<input type="hidden" id="totalPrice" name="totalPrice" value="${totalPrice}">
										<c:forEach items="${orderDetails}" var="orderDetail">
											<input type="hidden" id="orderId" name="orderId"
												value="${orderDetail.restaurantOrder.orderId}">
										</c:forEach>
									</div>
									<div class="flex items-center justify-between w-full">
										<input type="submit" value="Confirm"
											class="focus:outline-none text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:ring-green-300 font-medium rounded-lg text-md px-5 py-2.5 me-2 mb-2 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800 w-full">
									</div>
								</form>



							</div>
						</div>
					</div>
				</div>

			</body>

			</html>