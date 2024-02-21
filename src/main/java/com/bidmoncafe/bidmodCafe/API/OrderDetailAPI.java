package com.bidmoncafe.bidmodCafe.API;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bidmoncafe.bidmodCafe.DTO.OrderDetailDTO;
import com.bidmoncafe.bidmodCafe.model.OrderDetail;
import com.bidmoncafe.bidmodCafe.model.Product;
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
