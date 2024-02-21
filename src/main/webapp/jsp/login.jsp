<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Please Log In</title>
</head>
<body>
	<div class="login-page">
		<h1>Login</h1>
		<h2>Bidmod Cafe POS</h2>
		<form method="post" action="login">
			<div>
				<input placeholder="Email" name="email" value="" required />
			</div>
			<div>
				<input placeholder="Password" name="password" value="" required />
			</div>
			<div>
				<button>Login</button>
			</div>
		</form>
	</div>

	<script>
		// JavaScript function to validate form inputs
		function validateForm() {
			var username = document.getElementById("username").value;
			var password = document.getElementById("password").value;

			if (username === "" || password === "") {
				document.getElementById("error").style.display = "block";
				return false;
			} else {
				document.getElementById("error").style.display = "none";
				return true;
			}
		}
	</script>
</body>
</html>