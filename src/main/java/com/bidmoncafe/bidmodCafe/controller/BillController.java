package com.bidmoncafe.bidmodCafe.controller;

import java.lang.ProcessBuilder.Redirect;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bidmoncafe.bidmodCafe.middleware.AuthMiddleware;
import com.bidmoncafe.bidmodCafe.model.OrderDetail;
import com.bidmoncafe.bidmodCafe.model.RestaurantOrder;
import com.bidmoncafe.bidmodCafe.repository.BilllRepository;
import com.bidmoncafe.bidmodCafe.repository.HistoryRepository;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class BillController {
	
	@Autowired
    private BilllRepository repo;
    
    @Autowired
    private HistoryRepository orderRepository;

    @GetMapping("/orderdetail")
    public String fetchData(Model model, HttpServletRequest request) {
    	String path = AuthMiddleware.isAuth(request, "orderdetail");
        List<OrderDetail> orderDetailList = repo.fetchData();
        model.addAttribute("orderDetails", orderDetailList);
        return path;
    }

    @GetMapping("/orderdetail/{orderId}")
    public String getOrderDetailsByOrderId(HttpServletRequest request, @PathVariable Integer orderId, Model model) {
    	String path = AuthMiddleware.isAuth(request, "checkbill");
        Optional<RestaurantOrder> orderOptional = orderRepository.findById(orderId);

        if (orderOptional.isEmpty()) {
            model.addAttribute("orderDetails", Collections.emptyList());
            return "checkbill"; 
        }
        List<OrderDetail> orderDetails = repo.findByOrderId(orderId);
        model.addAttribute("orderDetails", orderDetails);
        return path;
    }
    
    
    
}
