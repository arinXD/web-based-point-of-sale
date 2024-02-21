<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html>

		<head>
			<jsp:include page="components/Header.jsp" />
			<title>Bidmod Cafe</title>
			<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/js-sha1@0.7.0/src/sha1.min.js"></script>
		</head>

		<body class="bg-[#EAF9F4]">
			<jsp:include page="components/NavBar.jsp" />
			<div class="container mx-auto mt-5">
				<div class="flex flex-row gap-5">
					<div class="w-[70%]">
						<div class="flex flex-row gap-3 mb-3">
							<h1 class="flex-1 text-2xl text-[#005F3B] font-bold mb-3">Product</h1>
							<input type="text" placeholder="Search..." class="px-3 border border-1 rounded-lg" />
							<button class="border border-1 rounded-lg bg-green-600 px-3 text-white">Search</button>
							<button class="border border-1 rounded-lg bg-green-600 px-3 text-white">option</button>
						</div>
						<div class="bg-white border-1 rounded-md p-4 h-[60.5vh]">
							<ul id="product-list" class="grid grid-cols-4 gap-4">
								<!-- <c:forEach items="${categories[0].products}" var="product">
									<li class="cursor-pointer rounded-lg flex flex-col justify-center items-center">
										<img class="rounded-md h-[120px] object-cover w-full rounded-br-none rounded-bl-none"
											src="${product.img}" alt="${product.productTitle}" />
										<div
											class="border-1 border w-full flex flex-col items-center pt-1 pb-2 rounded-br-md rounded-bl-md">
											<div>${product.productTitle}</div>
											<div class="font-bold text-green-700">$${product.productPrice}</div>
										</div>
									</li>
								</c:forEach> -->
							</ul>
						</div>
						<div>
							<ul id="category-list" class="w-100 flex flex-row gap-2 mt-3">
							</ul>
						</div>
					</div>
					<div class="w-[30%]">
						<div class="bg-white border-1 rounded-md h-[70vh]">
							<h2 class="text-xl text-center py-3">Checkout</h2>
							<form name="checkoutForm">
								<table class="w-full">
									<thead class="bg-[#F1F1F1]">
										<tr class='py-1 border-1 border border-t-[#B7B7B7] border-b-[#B7B7B7]'>
											<th class="w-[15%] text-base text-[#767676] font-normal"></th>
											<th class="w-[28.33%] text-base text-[#767676] font-normal">Name</th>
											<th class="w-[28.33%] text-base text-[#767676] font-normal">QTY</th>
											<th class="w-[28.33%] text-base text-[#767676] font-normal">Price</th>
										</tr>
									</thead>
									<tbody id="checkout-list">
									</tbody>
								</table>
							</form>
						</div>
						<div class="mt-3 flex gap-3">
							<button onclick="saveOrder()"
								class="w-1/2 rounded-lg bg-[#4B78D0] text-white rounded-lg border border-1 p-3 border border-1 p-3">บันทึก</button>
							<button onclick="checkOutOrder()"
								class="w-1/2 rounded-lg bg-[#007A4C] text-white rounded-lg border border-1 p-3 border border-1 p-3">ชำระเงิน</button>
						</div>
					</div>
				</div>
			</div>
			<script>
				function getFormData() {
					const checkOutData = []
					const form = document.forms["checkoutForm"]
					const orderDetailIds = Array.from(form.querySelectorAll("input[name='orderDetailId[]']")).map(input => input.value);
					const ids = Array.from(form.querySelectorAll("input[name='id[]']")).map(input => input.value);
					const qties = Array.from(form.querySelectorAll("input[name='qty[]']")).map(input => input.value);
					const prices = Array.from(form.querySelectorAll("input[name='price[]']")).map(input => input.value);
					for(let i=0; i < ids.length; i++){
						let data = {
							orderDetailId: orderDetailIds[i],
							pid: ids[i],
							qty: qties[i],
							price: prices[i]
						}
						checkOutData.push(data)
					}
					return(checkOutData);
				}
				async function saveOrder(){
					const formData = getFormData()
					if(Object.keys(formData).length==0){
						console.log("form data is null");
						return
					}
					let url = "http://localhost:4000/api"
					let method
					let targetUrl
					if(window.orderId){
						url += "/orders/" + window.orderId + "/details"
						method = "PUT"
						targetUrl = "/"
					}else{
						url += "/orders"
						method = "POST"
						targetUrl = "/"
					}
					const options = {
						url,
						method,
						headers: {
							'Accept': 'application/json',
							'Content-Type': 'application/json;charset=UTF-8'
						},
						data: formData
					};
					console.log(formData);
					try{
						await axios(options)
						window.location.href = targetUrl
					}catch(error){
						console.log(error);
						alert(error);
					}
				}
				async function checkOutOrder(){
					const formData = getFormData()
				}
				async function getCategories() {
					try {
						const categories = await axios.get("http://localhost:4000/api/categories");
						return categories.data;
					} catch (error) {
						console.log("Error fetching categories:", error);
						return [];
					}
				}
				async function getProducts(categories, type) {
					for (const category of categories) {
						if (category.categoryTitle === type) {
							return category.products;
						}
					}
					return [];
				}
				function updateProductList(products) {
					let innerProdictList = ""
					products.forEach(product => {
						innerProdictList +=
							'<li productId=' + product.productId + ' productPrice=' + product.productPrice + ' productTitle="' + product.productTitle + '" class="products cursor-pointer rounded-lg flex flex-col justify-center items-center">' +
							'<img class="rounded-md h-[120px] object-cover w-full rounded-br-none rounded-bl-none" src="' + product.img + '" alt="' + product.productTitle + '" />' +
							'<div class="border-1 border w-full flex flex-col items-center pt-1 pb-2 rounded-br-md rounded-bl-md">' +
							'<div>' + product.productTitle + '</div>' +
							'<div class="font-bold text-green-700">฿' + product.productPrice + '</div>' +
							'</div>' +
							'</li>'
					})
					document.querySelector("#product-list").innerHTML = innerProdictList
					document.querySelectorAll(".products").forEach(product => {
						product.addEventListener("click", () => {
							let productData = {
								productId: product.getAttribute("productId"),
								productPrice: product.getAttribute("productPrice"),
								productTitle: product.getAttribute("productTitle"),
								qty: 1,
							}
							updateCheckOutList(productData)
						})
					})
				}
				function updateCheckOutForm(){
					let innerCheckOutList = ""
					const qtyClass = "flex justify-center items-center p-1 w-7 h-7 border border-green-700 text-green-700 font-bold rounded-full cursor-pointer"
					checkOutList.forEach(product => {
						const orderDetailId = product.orderDetailId || null
						innerCheckOutList +=
							'<tr>'+
								'<td class="hidden"><input type="hidden" name="orderDetailId[]" value="'+ orderDetailId +'" /></td>'+
								'<td class="hidden"><input type="hidden" name="id[]" value="'+ product.productId +'" /></td>'+
								'<td class="py-2 w-[15%] text-center">'+
								'	<div onclick="removeProduct('+ product.productId +')" class="cursor-pointer flex justify-center items-center ms-auto w-7 h-7 text-center text-red-500"><svg data-slot="icon" fill="none" stroke-width="1.5" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0"></path></svg></div>'+
								'</td>'+
								'<td class="py-2 w-[28.33%] text-center text-base text-black font-normal">'+
								 	product.productTitle+
								'</td>'+
								'<td class="py-2 w-[28.33%] text-center text-base text-black font-normal">'+
								'	<input type="hidden" name="qty[]" value="'+ product.qty +'" />'+ 
									'<div class="flex flex-row justify-center items-center gap-3">' +
										'<div onclick="decreaseProduct('+ product.productId +')" class="'+ qtyClass +'"><svg data-slot="icon" fill="none" stroke-width="1.5" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="M5 12h14"></path></svg></div>' + 
										'<div>'+ product.qty +'</div>' +
										'<div onclick="increasProduct('+ product.productId +')" class="'+ qtyClass +'"><svg data-slot="icon" fill="none" stroke-width="1.5" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"></path></svg></div>' +
									'</div>' +
								'</td>'+
								'<td class="py-2 w-[28.33%] text-center text-base text-black font-normal">'+
								'	<input type="hidden" name="price[]" value="'+ product.productPrice +'" />'+ product.productPrice.toLocaleString("en-US")+
								'</td>'+
							'</tr>'
					})
					document.querySelector("#checkout-list").innerHTML = innerCheckOutList
				}
				function getProductPrice(id){
					const product = productsList.filter(product=>product.productId==id)[0]
					return product.productPrice
				}
				function increasProduct(id){
					getProductPrice(id)
					const existingProductIndex = checkOutList.findIndex(checkout => checkout.productId == id);
					checkOutList[existingProductIndex].qty += 1;
					const price = getProductPrice(id)
					checkOutList[existingProductIndex].productPrice += parseInt(price)
					updateCheckOutForm()
				}
				function decreaseProduct(id){
					const existingProductIndex = checkOutList.findIndex(checkout => checkout.productId == id);
					checkOutList[existingProductIndex].qty -= 1;
					const price = getProductPrice(id)
					checkOutList[existingProductIndex].productPrice -= parseInt(price)
					if(checkOutList[existingProductIndex].qty==0){
						removeProduct(id)
						return
					}
					updateCheckOutForm()
				}
				function updateCheckOutList(productData) {
					const existingProductIndex = checkOutList.findIndex(checkout => checkout.productId == productData.productId);
					if (existingProductIndex !== -1) {
						checkOutList[existingProductIndex].qty += 1;
						checkOutList[existingProductIndex].productPrice +=  parseInt(productData.productPrice) 
					} else {
						productData.productPrice = parseInt(productData.productPrice)
						productData.orderDetailId = null
						checkOutList.push(productData);
					}
					updateCheckOutForm()
					
				}
				function removeProduct(id) {
					checkOutList = checkOutList.filter(product => product.productId != id);
					updateCheckOutForm()
				}
				function hash() {
					console.log(sha1.hex('The quick brown fox jumps over the lazy dog'));
				}
				async function getOrderDetails(oid){
					try {
						const orderDetails = await axios.get("http://localhost:4000/api/orders/"+oid+"/details");
						return orderDetails.data;
					} catch (error) {
						console.log("Error fetching categories:", error);
						return [];
					}
				}
				async function updateOrderDetails(orderDetails){
					orderDetails.forEach(element => {
						let productData = {
							orderDetailId: element.orderDetailId,
							productId: element.product.productId,
							productPrice: element.price,
							productTitle: element.product.productTitle,
							qty: element.quantity,
						}
						checkOutList.push(productData);
					});
					updateCheckOutForm()
				}
				function getAllProducts(categories){
					const products = []
					categories.forEach(category=>{
						products.push(...category.products)
					})
					return products
				}


				(async () => {
					const urlParams = new URLSearchParams(window.location.search);
					const orderId = urlParams.get('orderId') || null ;
					window.orderId = orderId
					checkOutList = []	
					if(orderId){
						// checkOutList
						let data = await getOrderDetails(orderId)
						console.log(data);
						updateOrderDetails(data)
					}
					hash()
					
					const categories = await getCategories();
					let showProduct = []
					productsList = []
					let type = categories[0]?.categoryTitle
					showProduct = await getProducts(categories, type)
					productsList = getAllProducts(categories)
					updateProductList(showProduct)
					const activeType = ["border-2", "border-green-700", "font-bold", "text-green-700"]

					let innerCatList = ""
					categories.forEach(category => {
						innerCatList += '<li id="' + category.categoryTitle + '" class="category w-[50%] bg-white rounded-lg border border-1 p-3 cursor-pointer">' + category.categoryTitle + '</li>'
					})

					document.querySelector("#category-list").innerHTML = innerCatList
					document.querySelector("#" + type).classList.add(...activeType)
					const types = document.querySelectorAll(".category")
					types.forEach(btn => {
						btn.addEventListener("click", async (event) => {
							type = event.target.innerText
							showProduct = await getProducts(categories, type)
							updateProductList(showProduct)
							types.forEach(typeBtn => {
								typeBtn.classList.remove(...activeType);
							});

							event.target.classList.add(...activeType);
						});
					});

				})();
			</script>
		</body>

		</html>