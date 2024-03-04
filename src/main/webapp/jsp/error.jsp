<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<jsp:include page="components/Header.jsp" />
<title>Bidmod Cafe</title>
</head>
<body>
	<div class="w-fit h-fit mx-auto my-[10em]">
		<h1 class="text-center text-4xl mb-10">${status} - ${error}</h1>
		<div class="flex justify-center">
			<a href="/"
				class="w-fit inline-block px-5 py-3 rounded-lg bg-green-500 text-white mx-auto">Home<a />
		</div>
	</div>
</body>
</html>