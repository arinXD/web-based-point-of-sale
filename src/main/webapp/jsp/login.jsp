<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html>

	<head>
		<jsp:include page="components/Header.jsp" />
		<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.js"></script>
		<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/toastify-js@1.12.0/src/toastify.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/toastify-js@1.12.0/src/toastify.min.css" rel="stylesheet">

		<title>Bidmod Cafe - Login</title>
		<title>Please Log In</title>
	</head>

	<body>
		<div class="login-page flex flex-row-reverse">
			<div class="relative w-[50%] h-[100vh]">
				<h1 style="text-shadow: black 1px 0 10px;"
					class="drop-shadow-2xl text-9xl leading-tight absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 text-white">
					Bidmod
					Café</h1>
				<img class="block w-full h-[100vh] object-cover"
					src="https://images.squarespace-cdn.com/content/v1/5ac2ddf285ede15e39a57666/1611799878407-31ZK0ZAWK1S6KODWZ1YG/Design-Anthology-2021-00+Greennomad%2C+Busan+-+Heewon+Jeong-3.jpg"
					alt="banner" />
			</div>
			<div class="w-[50%] relative">
				<div class="w-[50%] absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
					<h1 class="text-center mb-2 font-bold text-3xl">Login</h1>
					<h2 class="mb-2 text-center">Bidmod Cafe POS</h2>
					<form class="space-y-4">
						<div>
							<label for="email" class="block mb-2 text-sm font-medium text-gray-900">Email:</label>
							<input type="email" name="email" value="" id="email"
								class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
								placeholder="example@email.com" required />
						</div>
						<div>
							<label for="password" class="block mb-2 text-sm font-medium text-gray-900">Password:</label>
							<input type="password" name="password" value="" id="password"
								class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
								placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;"
								required />
						</div>
						<div>
							<button type="button" onclick="login()"
								class="mt-3 bg-[#0E9F68] text-white w-full rounded-lg py-2">Login</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<script>
			async function login() {
				const email = document.getElementById("email").value;
				const password = document.getElementById("password").value;

				const options = {
					method: "POST",
					url: "http://localhost:4000/api/auth/login",
					headers: {
						'Accept': 'application/json',
						'Content-Type': 'application/json;charset=UTF-8'
					},
					data: {
						email,
						password
					}
				};

				try {
					const res = await axios(options);
					const data = res.data
					if (data.ok) {
						window.location.href = "/";
					} else {
						Toastify({
							text: data.message,
							duration: 3000,
							close: true,
							style: {
								background: "red",
								borderRadius: "10px"
							},
							gravity: "top", // `top` or `bottom`
							position: "center", // `left`, `center` or `right`
							backgroundColor: "red", // Background color set to red
							onClick: function () { } // Callback after click
						}).showToast();
					}
				} catch (error) {
					console.log(error);
					alert(error.message);
				}
			}
		</script>
	</body>

	</html>