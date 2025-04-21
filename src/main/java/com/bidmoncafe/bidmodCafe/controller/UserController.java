package com.bidmoncafe.bidmodCafe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.bidmoncafe.bidmodCafe.middleware.AuthMiddleware;
import com.bidmoncafe.bidmodCafe.model.User;
import com.bidmoncafe.bidmodCafe.repository.UserRepository;


@Controller
public class UserController {

	@Autowired
	UserRepository userRepo;
	private BCryptPasswordEncoder bcrypt = new BCryptPasswordEncoder();

	@GetMapping("/users")
	public String getAllOrders(HttpServletRequest request, Model model) {
		String path = AuthMiddleware.isAuth(request, "user");
		Iterable<User> user = userRepo.findAll();
		User currentUser = AuthController.getCurrentUser();
		model.addAttribute("users", user);
		model.addAttribute("currentUser", currentUser);
		return path;
	}

	@PostMapping("/user")
	public String insertMenu(@RequestParam String name,@RequestParam String email,@RequestParam String password,Model model) {
		System.out.println("====================log");
		
		User existingUser = userRepo.findByEmail(email);
	    if (existingUser != null) {
	        model.addAttribute("errorMessage", "Email already exists. Please choose a different email.");
	        return "redirect:/users";
	    }
		
		User user = new User();
		user.setName(name);
		user.setEmail(email);
		String hashedPassword = bcrypt.encode(password);
		System.out.println(password);
		System.out.println(hashedPassword);
		user.setPassword(hashedPassword);
		System.out.println(user);
		userRepo.save(user);
		return "redirect:/users";
	}
	
	@GetMapping("/user/{id}")
    public String deleteUser(@PathVariable @NonNull Long id) {
        userRepo.deleteById(id);
        return "redirect:/users";
    }
}
