package com.bidmoncafe.bidmodCafe.API;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bidmoncafe.bidmodCafe.DTO.DashboardDTO;
import com.bidmoncafe.bidmodCafe.repository.BillRepository;
import com.bidmoncafe.bidmodCafe.repository.OrderRepository;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardAPI {
	@Autowired
	private BillRepository billRepository;
	
	@Autowired
	private OrderRepository orderRepository;

	@GetMapping("/{yearInput}/{monthInput}")
	public DashboardDTO getData(@PathVariable String yearInput,@PathVariable String monthInput) {
		
		List<Object[]> percentageSellByDate = billRepository.getPercentageSellByDate(yearInput, monthInput);
	    List<Map<String, Object>> sellInDate = new ArrayList<>();

	    for (Object[] result : percentageSellByDate) {
	        String dayOfWeek = (String) result[0];
	        Double totalProfit = (Double) result[1];
	        
	        Map<String, Object> resultMap = new HashMap<>();
	        resultMap.put("day", dayOfWeek);
	        resultMap.put("revenur", totalProfit);
	        
	        sellInDate.add(resultMap);
	    }
	    
	    List<Object[]> revenueInMonths = billRepository.getRevenueInMonth(yearInput);
	    List<Map<String, Object>> revenueInMonth = new ArrayList<>();

	    for (Object[] result : revenueInMonths) {
	        String month = (String) result[0];
	        Double revenur = (Double) result[1];
	        
	        Map<String, Object> resultMap = new HashMap<>();
	        resultMap.put("month", month);
	        resultMap.put("revenur", revenur);
	        
	        revenueInMonth.add(resultMap);
	    }
	    
	    
	    List<Object[]> revenueInYears = billRepository.getRevenueInYear(yearInput);
	    List<Map<String, Object>> revenueInYear = new ArrayList<>();
	    
	    for (Object[] result : revenueInYears) {
	        String year = (String) String.valueOf(result[0]);
	        Double revenur = (Double) result[1];
	        
	        Map<String, Object> resultMap = new HashMap<>();
	        resultMap.put("year", year);
	        resultMap.put("revenur", revenur);
	        
	        revenueInYear.add(resultMap);
	    }
	    
	    List<Object[]> percenProducts = billRepository.getPercenProduct(yearInput, monthInput);
	    List<Map<String, Object>> percenProduct = new ArrayList<>();
	    
	    for (Object[] result : percenProducts) {
	        String pro = (String) String.valueOf(result[0]);
	        Double per = (Double) result[1];
	        
	        Map<String, Object> resultMap = new HashMap<>();
	        resultMap.put("productName", pro);
	        resultMap.put("revenur", per);
	        
	        percenProduct.add(resultMap);
	    }
	    
	    
	    double totalRevenue = orderRepository.getTotalRevenue();
	    double totalTakeHomeRevenue = orderRepository.getTotalTakeHomeRevenue();
	    double totalTableRevenue = totalRevenue - totalTakeHomeRevenue;
	    double totalCountOrder = orderRepository.getTotalCountOrder();
	    double totalCountTakeHome = orderRepository.getTotalCountTakeHome();
	    double totalCountTable = totalCountOrder - totalCountTakeHome;
	    
	    DashboardDTO dashboardDTO = new DashboardDTO();
	    dashboardDTO.sellInDate = sellInDate;
	    dashboardDTO.revenueInMonth = revenueInMonth;
	    dashboardDTO.productPercentage = percenProduct;
	    dashboardDTO.revenueInYear = revenueInYear.get(0);
	    dashboardDTO.totalRevenue = totalRevenue;
	    dashboardDTO.totalTakeHomeRevenue = totalTakeHomeRevenue;
	    dashboardDTO.totalTableRevenue = totalTableRevenue;
	    dashboardDTO.totalCountOrder = totalCountOrder;
	    dashboardDTO.totalCountTakeHome = totalCountTakeHome;
	    dashboardDTO.totalCountTable = totalCountTable;
	    
		return dashboardDTO;
	}
	
}
