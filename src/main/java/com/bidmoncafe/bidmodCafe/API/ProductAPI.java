package com.bidmoncafe.bidmodCafe.API;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bidmoncafe.bidmodCafe.model.Product;
import com.bidmoncafe.bidmodCafe.repository.ProductRepository;

@RestController
@RequestMapping("/api/products")
public class ProductAPI {
	
	@Autowired
	ProductRepository productRepository;
	
	@GetMapping("/categories/{cid}")
	public List<Product> searchProduct(@PathVariable int cid, @RequestParam String productTitle){
		return productRepository.searchProducts(cid, productTitle);
	}
}
