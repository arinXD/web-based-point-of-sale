package com.bidmoncafe.bidmodCafe.API;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bidmoncafe.bidmodCafe.DTO.LoginDTO;
import com.bidmoncafe.bidmodCafe.DTO.ResponseLogin;
import com.bidmoncafe.bidmodCafe.controller.AuthController;
import com.bidmoncafe.bidmodCafe.model.User;
import com.bidmoncafe.bidmodCafe.repository.UserRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/auth")
public class AuthAPI {
	
	@Autowired
	UserRepository userRepository;
	
	@PostMapping("/register")
	public User register(@RequestBody LoginDTO loginDto) {
		try {
			User user = new User();
			user.setEmail(loginDto.getEmail());
			user.setPassword(loginDto.getPassword());
			user = userRepository.save(user);
			return user;			
		}catch (Exception e) {
			return null;
		}
		
	}
	@PostMapping("/login")
	public ResponseLogin login(@RequestBody LoginDTO loginDto, HttpServletRequest request) {
		User user = userRepository.findByEmail(loginDto.getEmail());
		ResponseLogin res = new ResponseLogin();
		if (user == null) {
			res.ok = false;
			res.message = "Incorrect email.";
			return res;
		} else {
			if(!(user.getPassword().equals(loginDto.getPassword()))) {
				res.ok = false;
				res.message = "Incorrect password.";
				return res;
			}else {				
				HttpSession session = request.getSession();
				User authenUser = new User();
				authenUser.setEmail(user.getEmail());
				authenUser.setName(user.getName());
				AuthController.setCurrentUser(authenUser);
				session.setAttribute("user", authenUser);
				res.ok = true;
				res.message = "Login success.";
				return res;
			}
		}
		
	}
}