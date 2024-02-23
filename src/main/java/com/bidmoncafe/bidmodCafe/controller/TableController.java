package com.bidmoncafe.bidmodCafe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.bidmoncafe.bidmodCafe.middleware.AuthMiddleware;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class TableController {
	@GetMapping("/tables")
	public String getTablePage(Model model, HttpServletRequest request) {
		String path = AuthMiddleware.isAuth(request, "table");
		return path;
	}
}
