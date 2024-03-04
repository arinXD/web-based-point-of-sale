package com.bidmoncafe.bidmodCafe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.bidmoncafe.bidmodCafe.middleware.AuthMiddleware;
import com.bidmoncafe.bidmodCafe.model.Category;
import com.bidmoncafe.bidmodCafe.model.Product;
import com.bidmoncafe.bidmodCafe.repository.BillRepository;
import com.bidmoncafe.bidmodCafe.repository.MenuRepository;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MenuController {
	
	@Autowired
	private MenuRepository menuRepo;
	
	@Autowired
	private BillRepository orderDetailRepo;
	
	@GetMapping("/menu")
	public String fetchMenu(Model model, HttpServletRequest request) {
		String path = AuthMiddleware.isAuth(request, "menu");
		Iterable<Product> menus = menuRepo.findAll();
        model.addAttribute("menus", menus);
		return path;
	}
	
	@PostMapping("/menu")
	public String insertMenu(@RequestParam String name, 
	                         @RequestParam double price, 
	                         @RequestParam String img,
	                         @RequestParam int categoryId) {
	    Product product = new Product();
	    product.setProductTitle(name);
	    product.setProductPrice(price);
	    product.setImg(img);
	    
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
	
	@GetMapping("/menu/edit/{productId}")
	public String showById(HttpServletRequest request, @PathVariable Integer productId, Model model) {
		String path = AuthMiddleware.isAuth(request, "edit-menu");
	    Product product = menuRepo.findById(productId).orElse(null);
	    model.addAttribute("product", product);
	    return path;
	}

	@PostMapping("/menu/edit/{productId}")
	public String updateById(@PathVariable Integer productId, @RequestParam String name,
	                         @RequestParam double price, @RequestParam String img,
	                         @RequestParam int categoryId) {
		
	    Product product = menuRepo.findById(productId).orElse(null);
	    if (product != null) {
	        product.setProductTitle(name);
	        product.setProductPrice(price);
	        product.setImg(img);

	        Category category = new Category();
	        category.setCategoryId(categoryId);
	        product.setCategory(category);

	        menuRepo.save(product);
	    }
	    return "redirect:/menu";
	}
	
}
