<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="utf-8">
		<title>Register</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.js"></script>
		<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	</head>

	<body>
		<h1>Welcome to Register Page</h1>
		<form>
			<div>
				<input placeholder="Email" name="email" id="email" required />
			</div>
			<div>
				<input placeholder="Password" name="password" id="password" required />
			</div>
			<button type="button" id="submitBtn">Register</button>
		</form>

		<script>
			function hashPassword(string) {
				return CryptoJS.SHA1(string).toString(CryptoJS.enc.Hex);
			}

			async function register() {
				const email = document.querySelector("#email").value;
				const password = document.querySelector("#password").value;
				const hashPw = hashPassword(password);

				console.log(email, hashPw);

				const options = {
					method: "POST",
					url: "http://localhost:4000/api/auth/register",
					headers: {
						'Accept': 'application/json',
						'Content-Type': 'application/json;charset=UTF-8'
					},
					data: {
						email: email,
						password: hashPw
					}
				};

				try {
					await axios(options);
					window.location.href = "/login";
				} catch (error) {
					console.log(error);
					alert(error.message);
				}
			}

			document.querySelector("#submitBtn").addEventListener("click", register);
		</script>
	</body>

	</html>