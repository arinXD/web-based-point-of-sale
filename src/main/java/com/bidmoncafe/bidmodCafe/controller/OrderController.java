package com.bidmoncafe.bidmodCafe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.bidmoncafe.bidmodCafe.middleware.AuthMiddleware;
import com.bidmoncafe.bidmodCafe.model.Category;
import com.bidmoncafe.bidmodCafe.repository.CategoryRepository;
import com.bidmoncafe.bidmodCafe.repository.ProductRepository;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class OrderController {
	@Autowired
	CategoryRepository categoryRepository;
	@Autowired
	ProductRepository productRepository;
	
	@GetMapping("/orders")
	public String getOrderPage(Model model, HttpServletRequest request) {
		String path = AuthMiddleware.isAuth(request, "order");
		Iterable<Category> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);
		return path;
	}
}
