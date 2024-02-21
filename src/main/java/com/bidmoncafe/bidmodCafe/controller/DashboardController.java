package com.bidmoncafe.bidmodCafe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.bidmoncafe.bidmodCafe.model.OrderDetail;
import com.bidmoncafe.bidmodCafe.repository.BilllRepository;

@Controller
public class DashboardController {
    
    @Autowired
    private BilllRepository dashboardRepo;
    
    @GetMapping("/dashboard")
    public String fetchData(Model model) {
        List<OrderDetail> dashboard = dashboardRepo.fetchData();
        
        // Calculate total quantity and total price
        int totalQuantity = 0;
        double totalPrice = 0;
        for (OrderDetail orderDetail : dashboard) {
            totalQuantity += orderDetail.getQuantity();
            totalPrice += orderDetail.getPrice();
        }
        
        // Calculate percentage of total sales for each menu
        Map<String, Double> menuSalesPercentage = new HashMap<>();
        for (OrderDetail orderDetail : dashboard) {
            String menuName = orderDetail.getProduct().getProductTitle();
            double menuTotalSales = menuSalesPercentage.getOrDefault(menuName, 0.0);
            menuTotalSales += (orderDetail.getPrice() / totalPrice) * 100;
            menuSalesPercentage.put(menuName, menuTotalSales);
        }
        
        model.addAttribute("dashboard", dashboard);
        model.addAttribute("totalQuantity", totalQuantity);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("menuSalesPercentage", menuSalesPercentage);
        
        return "dashboard";
    }
}
