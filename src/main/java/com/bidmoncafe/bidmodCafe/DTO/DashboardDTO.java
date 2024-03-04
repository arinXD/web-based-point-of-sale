package com.bidmoncafe.bidmodCafe.DTO;

import java.util.List;
import java.util.Map;

public class DashboardDTO {
	public List<Map<String, Object>> sellInDate;
	public List<Map<String, Object>> revenueInMonth;
	public List<Map<String, Object>> productPercentage;
	public Map<String, Object> revenueInYear;
	public double totalRevenue;
	public double totalTakeHomeRevenue;
	public double totalTableRevenue;
	public double totalCountOrder;
	public double totalCountTakeHome;
	public double totalCountTable;
}
