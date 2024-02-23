<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="components/Header.jsp" />
<title>Bidmod Cafe</title>
</head>
<body class="bg-[#EAF9F4]">
	<jsp:include page="components/NavBar.jsp" />
	<div class="container mx-auto mt-5">
		<div class="bg-white border-1 rounded-md p-6">
			<h1>${message}</h1>
			<div class="flex flex-row gap-4 items-center my-4">
				<h1 class="text-3xl text-[#005F3B] font-bold">Add order</h1>
				<a href="/orders">
					<div class="active:scale-90 flex justify-center items-center p-1 w-7 h-7 bg-green-700 text-white font-bold rounded-full cursor-pointer">
						<svg data-slot="icon" fill="none" stroke-width="1.5" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"></path></svg>
					</div>
				</a>
			</div>
			<ul class="grid grid-cols-2 gap-4">
				<li>
					<ul class="grid grid-cols-2 gap-4">
						<% int c = 0; %>
						<c:forEach items="${tableOrders}" var="tableOrder">
							<li class="">
								<a href="/orders?orderId=${tableOrder.orderId}" class="relative p-3 bg-[#49C77B] rounded-md flex flex-row justify-center items-center px-10">
									<div class="text-white text-lg font-bold flex flex-col justify-center items-center p-2">
										<div>Table</div>
										<div>${tableOrder.restaurantTable.title}</div>
									</div>
									<div class="absolute flex flex-col justify-center top-[7%] right-[3%]">
										<div class="bg-[#FDEDD3] text-[#C3841D] border border-2 border-[#C3841D] flex flex-row items-center gap-2 justify-center px-[.5em] py-[.1em] rounded-[2em]">
											<p class="text-sm">รอจ่ายตัง</p>
										</div>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
				</li>
				<li>
					<ul class="grid grid-cols-2 gap-4">
						<% c = 0; %>
						<c:forEach items="${takeHomeOrders}" var="takeHomeOrder">
							<li class="">
								<a href="/orders?orderId=${takeHomeOrder.orderId}" class="relative p-3 bg-cyan-600 rounded-md flex flex-row justify-center items-center px-10">
									<div class="text-white text-lg font-bold flex flex-col justify-center items-center p-2">
										<div>Order</div>
										<div><%= ++c %></div>
									</div>
									<div class="absolute flex flex-col justify-center top-[7%] right-[3%]">
										<div class="bg-[#FDEDD3] text-[#C3841D] border border-2 border-[#C3841D] flex flex-row items-center gap-2 justify-center px-[.5em] py-[.1em] rounded-[2em]">
											<p class="text-sm">รอจ่ายตัง</p>
										</div>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>