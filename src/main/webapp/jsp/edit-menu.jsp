<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="components/Header.jsp" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="bg-[#EAF9F4]">
	<jsp:include page="components/NavBar.jsp" />
	<div class="container mx-auto mt-10">
		<div class="bg-white border-1 rounded-md p-6">
			<h1 class="text-3xl text-[#005F3B] font-bold mb-5">Edit Menu</h1>
			<form action="/menu/edit/${product.productId}" method="post">
				<div class="relative z-0 w-full mb-5 group">
					<input type="text" value="${product.productTitle}" name="name"
						id="name"
						class="block py-2.5 px-0 w-full text-md text-black bg-transparent border-0 border-b-2 border-gray-300  focus:outline-none focus:ring-0 focus:border-green-600 peer"
						placeholder=" " required /> <label for="floating_email"
						class="peer-focus:font-medium absolute text-sm text-gray-500  duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 rtl:peer-focus:left-auto peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">
						ชื่ออาหาร</label>
				</div>
				<div class="relative z-0 w-full mb-5 group">
					<input type="number" value="${product.productPrice}" name="price"
						id="price"
						class="block py-2.5 px-0 w-full text-md text-black bg-transparent border-0 border-b-2 border-gray-300  focus:outline-none focus:ring-0 focus:border-green-600 peer"
						placeholder=" " required /> <label for="floating_password"
						class="peer-focus:font-medium absolute text-sm text-gray-500  duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">ราคา</label>
				</div>
				<div class="relative z-0 w-full mb-5 group">
					<input type="text" value="${product.img}" name="img" id="img"
						class="block py-2.5 px-0 w-full text-md text-black bg-transparent border-0 border-b-2 border-gray-300  focus:outline-none focus:ring-0 focus:border-green-600 peer"
						placeholder=" " required /> <label for="floating_repeat_password"
						class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">รูปภาพ
						password</label>
				</div>
				<div class="relative z-0 w-full mb-5 group">
					<input type="radio" id="food" name="categoryId" value="1"
						${product.category.categoryId == 1 ? 'checked' : ''}>อาหาร
					<input type="radio" id="water" name="categoryId" value="2"
						${product.category.categoryId == 2 ? 'checked' : ''}>เครื่องดื่ม
				</div>


				<button type="submit"
									class="text-white inline-flex items-center bg-[#0E9F68] hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center">
									<svg class="me-1 -ms-1 w-5 h-5" fill="currentColor"
										viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
										<path fill-rule="evenodd"
											d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
											clip-rule="evenodd"></path></svg>
									ยืนยัน
								</button>
			</form>
		</div>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>

</body>
</html>