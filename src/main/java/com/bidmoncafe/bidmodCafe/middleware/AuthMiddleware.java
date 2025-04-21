package com.bidmoncafe.bidmodCafe.middleware;

import com.bidmoncafe.bidmodCafe.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AuthMiddleware {
	public static String isAuth(HttpServletRequest request, String target) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		String path;
		path = user != null ? target : "redirect:/login";
		if(path.contains("login") && user==null) {
			path = "login";
		}else if(!path.contains("login") && user==null) {
			path = "redirect:/login";
		}else {
			path = target;
		}
		return path;
	}
}
