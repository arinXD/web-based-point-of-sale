package com.bidmoncafe.bidmodCafe.API;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.bidmoncafe.bidmodCafe.repository.OrderDetailRepository;
import com.bidmoncafe.bidmodCafe.repository.OrderRepository;
import com.bidmoncafe.bidmodCafe.repository.ProductRepository;

@RestController
@RequestMapping("/api/orders/details")
public class OrderDetailAPI {
	
	@Autowired
	OrderDetailRepository orderDetailRepository;
	
	@Autowired
	ProductRepository productRepository; 
	
	@Autowired
	OrderRepository orderRepository;
	
	
	
}
