<%@page import="com.bidmoncafe.bidmodCafe.controller.AuthController"%>
<%@page import="com.bidmoncafe.bidmodCafe.model.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<% User currentUser = AuthController.getCurrentUser(); %>
<nav class="py-[14px] px-[50px] bg-[#0E9F68] text-white">
	<ul class="flex flex-row justify-between items-center">
		<li class="felx-1">
			<h1 class="font-bold">
				<a href="/">Bidmod Café</a>
			</h1>
		</li>
		<li>
			<ul class="flex gap-16">
				<li>บัญชีผู้ใช้</li>
				<li>โต๊ะ</li>
				<li>สินค้า</li>
				<li>แผนภูมิ</li>
				<li>บิล</li>
				<li><%= currentUser.getEmail() %></li>
			</ul>
		</li>
	</ul>
</nav>