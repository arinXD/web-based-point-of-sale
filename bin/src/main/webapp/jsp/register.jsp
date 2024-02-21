
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Register</title>
</head>
<body>
	<h1>Welcome to Register Page</h1>
	<form action="/register" method="post">
		<div>
			<input placeholder="Email" name="email" required />
		</div>
		<div>
			<input placeholder="Password" name="password" required />
		</div>
		<button type="submit">Register</button>
	</form>
</body>
</html>