package com.bidmoncafe.bidmodCafe.API;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bidmoncafe.bidmodCafe.DTO.OrderDTO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

class Action {
	public String action;

	public Action() {

	}

	public Action(String action) {
		this.action = action;
	}
}

@RestController
@RequestMapping("/api/actions")
public class ActionAPI {

	@GetMapping
	public Action getAction(HttpServletRequest req, HttpServletResponse res) {
		Cookie[] cookies = req.getCookies();
		String action = null;
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if (cookie.getName().equals("action")) {
					action = cookie.getValue();
					break;

				}
			}
		}
		return new Action(action);
	}

	@PostMapping
	public void setAction(@RequestBody Action action, HttpServletRequest req, HttpServletResponse res) {
		Cookie cookie = new Cookie("action", action.action);
		cookie.setMaxAge(30 * 60);
		res.addCookie(cookie);
	}
}
