package com.bidmoncafe.bidmodCafe.API;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.bidmoncafe.bidmodCafe.model.Category;
import com.bidmoncafe.bidmodCafe.repository.CategoryRepository;
import com.bidmoncafe.bidmodCafe.repository.ProductRepository;


@RestController
@RequestMapping("/api/categories")
public class CategoryAPI {
	@Autowired
	CategoryRepository categoryRepository;
	@Autowired
	ProductRepository productRepository;
	
	@GetMapping
    public List<Category> getOrderPage() {
        List<Category> categories = (List<Category>) categoryRepository.findAll();
		return categories;
    }
}
