package com.bidmoncafe.bidmodCafe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TableController {
	@GetMapping("/tables")
	public String getTablePage(Model model) {
		return "table";
	}
}
