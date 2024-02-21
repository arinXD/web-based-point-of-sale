package com.bidmoncafe.bidmodCafe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.bidmoncafe.bidmodCafe.model.RestaurantOrder;
import com.bidmoncafe.bidmodCafe.model.RestaurantTable;
import com.bidmoncafe.bidmodCafe.repository.BilllRepository;
import com.bidmoncafe.bidmodCafe.repository.HistoryRepository;

@Controller
public class HistoryController {

    @Autowired
    HistoryRepository historyRepo;
    
    @Autowired
    BilllRepository billRepo;
    
    @GetMapping("/history")
    public String getAllOrders(Model model) {
    	Iterable<RestaurantOrder> orders = historyRepo.findAll();
    	model.addAttribute("orders", orders);
        return "history";
    }
    
    @PostMapping("/history")
    public String calculateChange(@RequestParam("amountPaid") double amountPaid,
                                  @RequestParam("totalPrice") double totalPrice, 
                                  @RequestParam("orderId") int orderId,
                                  @RequestParam(value = "method", required = false) String method, Model model) {
    	
    	if (method == null || method.isEmpty()) {
            method = "cash";
        }else {
        	method = "transfer";
        }
    	
        double change = amountPaid - totalPrice;

        RestaurantOrder bill = historyRepo.findById(orderId);
        if (bill == null) {
            return "error";
        } else {
            bill.setMoneyChange(change);
            bill.setTotal(totalPrice);
            bill.setMethod(method);
            
            RestaurantTable table = bill.getRestaurantTable();
            if (table == null) {
                bill.setRestaurantTable(null);
                bill.setStatus(1);
            
            } else {
                table.setStatus(0);
                bill.setStatus(1);
            }
            historyRepo.save(bill);
        }
        model.addAttribute("bills", bill);
        return "bill";
    }

}
