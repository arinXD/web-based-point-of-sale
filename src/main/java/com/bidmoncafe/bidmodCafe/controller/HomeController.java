package com.bidmoncafe.bidmodCafe.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.bidmoncafe.bidmodCafe.middleware.AuthMiddleware;
import com.bidmoncafe.bidmodCafe.model.RestaurantOrder;
import com.bidmoncafe.bidmodCafe.repository.OrderRepository;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class HomeController {
	
	@Autowired
	OrderRepository orderRepository; 
	
	@GetMapping("/")
	public String welcome(Model model,
			HttpServletRequest request) {
		
		String path = AuthMiddleware.isAuth(request, "index");
		Iterable<RestaurantOrder> tableOrders = orderRepository.findByOrderType("table");
		Iterable<RestaurantOrder> takeHomeOrders = orderRepository.findByOrderType("takeHome");

		model.addAttribute("message", "Welcome to Bidmod Cafe! Path(/)");
		model.addAttribute("tableOrders", tableOrders);
		model.addAttribute("takeHomeOrders", takeHomeOrders);
		
		return path;
	}
	
	@GetMapping("/error")
	public String handleError(HttpServletRequest request) {
	    Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
	    
	    if (status != null) {
	        Integer statusCode = Integer.valueOf(status.toString());
	    
	        if(statusCode == HttpStatus.NOT_FOUND.value()) {
	            return "error-404";
	        }
	        else if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
	            return "error-500";
	        }
	    }
	    return "error";
	}
}
