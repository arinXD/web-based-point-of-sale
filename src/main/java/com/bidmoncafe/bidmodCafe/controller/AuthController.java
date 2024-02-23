package com.bidmoncafe.bidmodCafe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bidmoncafe.bidmodCafe.DTO.LoginDTO;
import com.bidmoncafe.bidmodCafe.middleware.AuthMiddleware;
import com.bidmoncafe.bidmodCafe.model.User;
import com.bidmoncafe.bidmodCafe.repository.UserRepository;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {
	@Autowired
	UserRepository userRepository;
	private static User currentUser;
	
	public static User getCurrentUser() {
		return currentUser;
	}
	
	public static void setCurrentUser(User currentUser) {
		AuthController.currentUser = currentUser;
	}


	@GetMapping("/register")
	public String getRegisterForm(Model model) {
		return "register";
	}

	@PostMapping("/register")
	public String register(
			@RequestParam("email") String email, 
			@RequestParam("password") String password,
			Model model) {
		User regisUser = new User();
		regisUser.setEmail(email);
		regisUser.setPassword(password);
		userRepository.save(regisUser);
		return "redirect:/login";
	}

	@GetMapping("/login")
	public String getLoginForm(HttpServletRequest request, Model model) {
		String path = AuthMiddleware.isAuth(request, "redirect:/");
		return path;
	}

	@PostMapping("/login")
	public String login(
			@RequestParam("email") String email, 
			@RequestParam("password") String password, 
			HttpServletRequest request) {
		User user = userRepository.findByEmail(email);
		if (user == null) {
			return "redirect:/login?error=incorrect_email";
		} else {
			if(!(user.getPassword().equals(password))) {
				return "redirect:/login?error=incorrect_password";
			}else {				
				HttpSession session = request.getSession();
				User authenUser = new User();
				authenUser.setEmail(user.getEmail());
				authenUser.setName(user.getName());
				setCurrentUser(authenUser);
				session.setAttribute("user", authenUser);
				return "redirect:/";
			}
		}
	}

	@GetMapping("/logout")
	public String customLogout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
}
