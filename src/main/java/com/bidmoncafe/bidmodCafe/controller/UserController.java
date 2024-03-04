package com.bidmoncafe.bidmodCafe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bidmoncafe.bidmodCafe.middleware.AuthMiddleware;
import com.bidmoncafe.bidmodCafe.model.User;

import com.bidmoncafe.bidmodCafe.repository.UserRepository;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UserController {

	@Autowired
	UserRepository userRepo;

	@GetMapping("/users")
	public String getAllOrders(HttpServletRequest request, Model model) {
		String path = AuthMiddleware.isAuth(request, "user");
		Iterable<User> user = userRepo.findAll();
		model.addAttribute("users", user);
		return path;
	}

	@PostMapping("/user")
	public String insertMenu(@RequestParam String name,@RequestParam String email,@RequestParam String password,Model model) {
		
		User existingUser = userRepo.findByEmail(email);
	    if (existingUser != null) {
	        model.addAttribute("errorMessage", "Email already exists. Please choose a different email.");
	        return "redirect:/user";
	    }
		
		User user = new User();
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);


		userRepo.save(user);
		return "redirect:/user";
	}
	
	@GetMapping("/user/{id}")
    public String deleteUser(@PathVariable @NonNull Long id) {
        userRepo.deleteById(id);
        return "redirect:/user";
    }
}
