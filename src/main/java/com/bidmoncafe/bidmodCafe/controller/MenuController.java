package com.bidmoncafe.bidmodCafe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.bidmoncafe.bidmodCafe.model.Category;
import com.bidmoncafe.bidmodCafe.model.Product;
import com.bidmoncafe.bidmodCafe.repository.BilllRepository;
import com.bidmoncafe.bidmodCafe.repository.MenuRepository;

@Controller
public class MenuController {
	
	@Autowired
	private MenuRepository menuRepo;
	
	@Autowired
	private BilllRepository orderDetailRepo;
	
	@GetMapping("/menu")
	public String fetchMenu(Model model) {
		Iterable<Product> menus = menuRepo.findAll();
        model.addAttribute("menus", menus);
		return "menu";
	}
	
	@PostMapping("/menu")
	public String insertMenu(@RequestParam String name, 
	                         @RequestParam double price, 
	                         @RequestParam int categoryId) {
	    Product product = new Product();
	    product.setProductTitle(name);
	    product.setProductPrice(price);
	    
	    Category category = new Category();
	    category.setCategoryId(categoryId);
	    product.setCategory(category);
	    
	    menuRepo.save(product);
	    return "redirect:/menu"; 
	}

	
	@GetMapping("/menu/{productId}")
    public String deleteMenu(@PathVariable Integer productId) {
        Product product = menuRepo.findById(productId).orElse(null);
        if (product != null && !product.getOrderDetails().isEmpty()) {
            return "redirect:/menu";
        }
        
        menuRepo.deleteById(productId);
        return "redirect:/menu";
    }
}
