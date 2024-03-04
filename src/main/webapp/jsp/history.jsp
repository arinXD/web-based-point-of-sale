<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>History</title>
<jsp:include page="components/Header.jsp" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
	rel="stylesheet" />
</head>
<body class="bg-[#EAF9F4]">
	<jsp:include page="components/NavBar.jsp" />
	<div class="container mx-auto mt-5">
		<div class="bg-white border-1 rounded-md p-6">
			<h1 class="text-3xl text-[#005F3B] font-bold mb-5">Order History</h1>
			<div id="accordion-flush" data-accordion="collapse"
				data-active-classes="bg-white text-gray-900"
				data-inactive-classes="text-gray-500 dark:text-gray-400">
				<c:forEach items="${orders}" var="order" varStatus="loop">
					<h2 id="accordion-flush-heading-${loop.index + 1}">
						<button type="button"
							class="flex items-center justify-between w-full py-5 font-medium rtl:text-right text-gray-500 border-b border-gray-200 dark:border-gray-700 dark:text-gray-400 gap-3"
							data-accordion-target="#accordion-flush-body-${loop.index + 1}"
							aria-expanded="false"
							aria-controls="accordion-flush-body-${loop.index + 1}">
							<span>Order ID : ${order.orderId}</span> <span><fmt:formatDate
									value="${order.date}" pattern="dd MM yyyy" /></span> <span><fmt:formatDate
									value="${order.date}" pattern="HH:mm" /></span> <span>${order.orderType}</span>
							<span>${order.restaurantTable.title == null ? 'กลับบ้าน' : order.restaurantTable.title}</span>
							<span>${order.method}</span>
							<svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0"
								aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
								fill="none" viewBox="0 0 10 6">
                                <path stroke="currentColor"
									stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
									d="M9 5 5 1 1 5" />
                            </svg>
						</button>
					</h2>
					<div id="accordion-flush-body-${loop.index + 1}" class="hidden"
						aria-labelledby="accordion-flush-heading-${loop.index + 1}">
						<div class=" border-b border-gray-200 dark:border-gray-700">
							<div class="relative overflow-x-auto">
								<div class="relative overflow-x-auto shadow-md">
									<table
										class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
										<thead
											class="text-xs text-gray-700 uppercase bg-[#0E9F68] text-white">
											<tr>
												<th scope="col" class="px-6 py-3">#</th>
												<th scope="col" class="px-6 py-3">ชื่อสินค้า</th>
												<th scope="col" class="px-6 py-3">QTY</th>
												<th scope="col" class="px-6 py-3">Price</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${order.orderDetails}" var="detail"
												varStatus="loop">
												<tr
													class="">
													<th scope="row"
														class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
														${loop.index + 1}</th>
													<td class="px-6 py-4 text-gray-900">${detail.product.productTitle}</td>
													<td class="px-6 py-4 text-gray-900">${detail.quantity}</td>
													<td class="px-6 py-4 text-gray-900">${detail.price}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>

			</div>

		</div>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
</body>
</html>
