<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html class="bg-[#EAF9F4]">

		<head>
			<jsp:include page="components/Header.jsp" />
			<title>Bidmod Cafe</title>
			<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
			<link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" type="text/css" />
			<script src="https://cdn.tailwindcss.com"></script>
		</head>

		<body class="bg-[#EAF9F4] h-[100vh]">
			<jsp:include page="components/NavBar.jsp" />
			<div class="container mx-auto mt-5">
				<div class="flex flex-row gap-5">
					<div class="w-[60%]">
						<div class="flex flex-row gap-3 mb-3">
							<h1 class="flex-1 text-2xl text-[#005F3B] font-bold">Product</h1>
							<input id="searchInput" type="text" placeholder="Search..." class="bg-white px-3 border border-1 rounded-lg" />
							<button onclick="searchProduct()" class="active:scale-90 rounded-full bg-green-600 p-2 w-10 h-10 text-white">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
									<path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
								</svg>
							</button>
							<button class="active:scale-90 rounded-full bg-green-600 p-2 w-10 h-10 text-white">
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6">
									<path fill-rule="evenodd" d="M11.078 2.25c-.917 0-1.699.663-1.85 1.567L9.05 4.889c-.02.12-.115.26-.297.348a7.493 7.493 0 0 0-.986.57c-.166.115-.334.126-.45.083L6.3 5.508a1.875 1.875 0 0 0-2.282.819l-.922 1.597a1.875 1.875 0 0 0 .432 2.385l.84.692c.095.078.17.229.154.43a7.598 7.598 0 0 0 0 1.139c.015.2-.059.352-.153.43l-.841.692a1.875 1.875 0 0 0-.432 2.385l.922 1.597a1.875 1.875 0 0 0 2.282.818l1.019-.382c.115-.043.283-.031.45.082.312.214.641.405.985.57.182.088.277.228.297.35l.178 1.071c.151.904.933 1.567 1.85 1.567h1.844c.916 0 1.699-.663 1.85-1.567l.178-1.072c.02-.12.114-.26.297-.349.344-.165.673-.356.985-.57.167-.114.335-.125.45-.082l1.02.382a1.875 1.875 0 0 0 2.28-.819l.923-1.597a1.875 1.875 0 0 0-.432-2.385l-.84-.692c-.095-.078-.17-.229-.154-.43a7.614 7.614 0 0 0 0-1.139c-.016-.2.059-.352.153-.43l.84-.692c.708-.582.891-1.59.433-2.385l-.922-1.597a1.875 1.875 0 0 0-2.282-.818l-1.02.382c-.114.043-.282.031-.449-.083a7.49 7.49 0 0 0-.985-.57c-.183-.087-.277-.227-.297-.348l-.179-1.072a1.875 1.875 0 0 0-1.85-1.567h-1.843ZM12 15.75a3.75 3.75 0 1 0 0-7.5 3.75 3.75 0 0 0 0 7.5Z" clip-rule="evenodd" />
								</svg>								  
							</button>
						</div>
						<div class="bg-white border-1 rounded-md p-4 h-[500px]">
							<ul id="product-list" class="grid grid-cols-4 gap-4">
								
							</ul>
						</div>
						<div>
							<ul id="category-list" class="w-100 flex flex-row gap-2 mt-3">
							</ul>
						</div>
					</div>
					<div class="w-[40%]">
						<div class="bg-white border-1 rounded-md h-[561px]">
							<h2 class="text-xl text-center py-3">Checkout</h2>
							<form name="checkoutForm">
								<div class="w-full">
									<div class="bg-[#F1F1F1] mb-2">
										<ul class='grid grid-cols-4 py-1 border-1 border border-t-[#B7B7B7] border-b-[#B7B7B7]'>
											<span class="w-full text-base text-[#767676] font-normal"></span>
											<span class="w-full text-base text-[#767676] font-normal text-start">Name</span>
											<span class="w-full text-base text-[#767676] font-normal text-center">QTY</span>
											<span class="w-full text-base text-[#767676] font-normal text-center">Price</span>
										</ul>
									</div>
									<ul id="checkout-list" class="flex flex-col gap-2 w-full overflow-y-auto h-[425px]">

									</ul>
									<div class="grid grid-cols-2 gap-2 place-items-center">
										<span class="text-center text-lg font-bold text-black">Total</span>
										<span id="totalPrice" class="text-center text-lg text-green-600 font-bold">฿0</span>
									</div>
								</div>
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
				<!-- modal -->
				<dialog id="orderTypeModal" class="modal">
					<div class="modal-box">
						<h3 class="font-bold mb-3 text-lg">Select order type.</h3>
						<div class="flex flex-row gap-3">
							<button onclick="setOrderDetail('table')" class="btn btn-accent w-1/2">Table</button>
							<button onclick="setOrderDetail('takeHome')" class="btn btn-primary w-1/2">Take Home</button>
						</div>
					</div>
					<form method="dialog" class="modal-backdrop">
						<button>close</button>
					</form>
				</dialog>
			</div>
			
			<script>
				async function setOrderDetail(type){
					const formData = getFormData()
					window.orderType = type
					console.log(window.orderType);
					const options = {
						url: "http://localhost:4000/api/orders",
						method: "POST",
						headers: {
							'Accept': 'application/json',
							'Content-Type': 'application/json;charset=UTF-8'
						},
						data: {
							orderType: window.orderType,
							orderDetail: formData,
						}
					};
					try{
						const res = await axios(options)
						await axios.post("http://localhost:4000/api/actions", {
							action: window.action
						})
						const order = res.data
						let targetUrl
						if(window.action=="saveOrder"){
							if(window.orderType=="takeHome"){
								targetUrl = "/"
							}else{
								targetUrl = "/tables?orderId=" + order.orderId
							}
						}else{
							if(window.orderType=="takeHome"){
								targetUrl = "/orderdetail/" + order.orderId
							}else{
								targetUrl = "/tables?orderId=" + order.orderId
							}
						}
						window.location.href = targetUrl
					}catch(error){
						console.log(error);
						alert(error);
					}
				}
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
						alert("Check out is emty.")
						return
					}
					
					if(window.orderType==null){
						orderTypeModal.showModal()
						window.action = "saveOrder"
						return
					}
					
					let url = "http://localhost:4000/api"
					let method
					let targetUrl
					url += "/orders/" + window.orderId + "/details"
					method = "PUT"
					targetUrl = "/"
					const options = {
						url,
						method,
						headers: {
							'Accept': 'application/json',
							'Content-Type': 'application/json;charset=UTF-8'
						},
						data: {
							orderType: window.orderType,
							orderDetail: formData
						}
					};

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

					if(Object.keys(formData).length==0){
						alert("Check out is emty.")
						return
					}

					if(window.orderType==null){
						orderTypeModal.showModal()
						window.action = "checkOutOrder"
						return
					}

					window.location.href = "/orderdetail/" + window.orderId 
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
					if(products.length == 0){
						document.querySelector("#product-list").innerHTML = "ไม่มีรายการสินค้า"
					}else{
						products.forEach(product => {
							innerProdictList +=
								'<li productId=' + product.productId + ' productPrice=' + product.productPrice + ' productTitle="' + product.productTitle + '" class="products cursor-pointer rounded-lg flex flex-col justify-center items-center">' +
									'<img class="rounded-md h-[120px] border-1 border border-b-0 object-cover w-full rounded-br-none rounded-bl-none" src="' + product.img + '" alt="' + product.productTitle + '" />' +
									'<div class="border-1 border w-full flex flex-col items-center pt-1 pb-2 rounded-br-md rounded-bl-md">' +
										'<div class="w-full px-1 overflow-hidden inline-block text-ellipsis whitespace-nowrap">' + product.productTitle + '</div>' +
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
				}
				function updateCheckOutForm(){
					let innerCheckOutList = ""
					const qtyClass = "flex justify-center items-center p-1 w-7 h-7 border border-green-700 text-green-700 font-bold rounded-full cursor-pointer"
					let total = 0
					checkOutList.forEach(product => {
						total += parseInt(product.productPrice)
						const orderDetailId = product.orderDetailId || null
						innerCheckOutList +=
							'<li class="grid grid-cols-4 gap-3 w-full">'+
								'<span class="hidden"><input type="hidden" name="orderDetailId[]" value="'+ orderDetailId +'" /></span>'+
								'<span class="hidden"><input type="hidden" name="id[]" value="'+ product.productId +'" /></span>'+
								'<div class="py-2 w-[100%] flex justify-center items-center">'+
								'	<div onclick="removeProduct('+ product.productId +')" class="cursor-pointer flex justify-center items-center mx-auto w-7 h-7 text-center text-red-500"><svg data-slot="icon" fill="none" stroke-width="1.5" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0"></path></svg></div>'+
								'</div>'+
								'<span class="py-2 w-[100%] text-start text-base text-black font-normal">'+
								 	product.productTitle+
								'</span>'+
								'<div class="flex items-center justify-center py-2 w-[100%] text-center text-base text-black font-normal">'+
								'	<input type="hidden" name="qty[]" value="'+ product.qty +'" />'+ 
									'<div class="flex flex-row justify-center items-center gap-3">' +
										'<div onclick="decreaseProduct('+ product.productId +')" class="'+ qtyClass +'"><svg data-slot="icon" fill="none" stroke-width="1.5" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="M5 12h14"></path></svg></div>' + 
										'<div>'+ product.qty +'</div>' +
										'<div onclick="increasProduct('+ product.productId +')" class="'+ qtyClass +'"><svg data-slot="icon" fill="none" stroke-width="1.5" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"></path></svg></div>' +
									'</div>' +
								'</div>'+
								'<div class="py-2 w-[100%] flex items-center justify-center text-base text-black font-normal">'+
								'	<input type="hidden" name="price[]" value="'+ product.productPrice +'" />'+ product.productPrice.toLocaleString("en-US")+
								'</div>'+
							'</li>'
					})
					document.querySelector("#checkout-list").innerHTML = innerCheckOutList
					document.querySelector("#totalPrice").innerHTML = "฿" + total.toLocaleString("en-US")
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
				async function getOrder(id) {
					try {
						const order = await axios.get("http://localhost:4000/api/orders/" + id);
						return order.data;
					} catch (error) {
						console.log("Error fetching categories:", error);
						return [];
					}
				}
				async function searchProduct(){
					const queryString = document.querySelector("#searchInput").value
					const cid = window.cid
					var products
					document.querySelector("#product-list").innerHTML = "Searching..."
					try {
						const res = await axios.get("http://localhost:4000/api/products/categories/"+ cid +"?productTitle=" + queryString);
						products = res.data
					} catch (error) {
						console.log("Error fetching:", error);
						products = []
					}finally{
						updateProductList(products)
					}
				}
				function findCategoryId(name){
					const cid = categories.filter(cat=>cat.categoryTitle==name)[0]
					return cid.categoryId
				}

				(async () => {
					const urlParams = new URLSearchParams(window.location.search);
					const orderId = urlParams.get('orderId') || null ;
					window.orderId = orderId
					window.orderType = null
					window.action = null
					checkOutList = []	
					if(orderId){
						// checkOutList
						let data = await getOrderDetails(orderId)
						let order = await getOrder(orderId)
						window.orderType = order.orderType
						updateOrderDetails(data)
					}
					
					
					categories = await getCategories();
					let showProduct = []
					productsList = []
					let type = categories[0]?.categoryTitle
					window.cid = findCategoryId(type)
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
							window.cid = findCategoryId(type)
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