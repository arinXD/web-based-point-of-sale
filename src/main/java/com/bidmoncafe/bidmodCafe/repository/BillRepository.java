package com.bidmoncafe.bidmodCafe.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bidmoncafe.bidmodCafe.model.OrderDetail;
import com.bidmoncafe.bidmodCafe.model.RestaurantTable;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

import java.time.LocalDateTime;
import java.util.Calendar;

@Repository
public class BillRepository {

	private String currentYear = String.valueOf(LocalDateTime.now().getYear());;
	private String month = String.valueOf(LocalDateTime.now().getMonthValue());
	private String currentMonth = month.length() == 1 ? "0" + month : month;

	@PersistenceContext
	private EntityManager em;

	public List<OrderDetail> fetchData() {
		Query data = em.createQuery("FROM OrderDetail");
		return data.getResultList();
	}

	public OrderDetail findById(Integer id) {
		return em.find(OrderDetail.class, id);
	}

	@Transactional
	public OrderDetail save(OrderDetail order_detail) {
		em.persist(order_detail);
		return order_detail;
	}

	@Transactional
	public OrderDetail deleteById(Integer id) {
		OrderDetail order_detail = em.find(OrderDetail.class, id);
		if (order_detail != null) {
			em.remove(order_detail);
		}
		return order_detail;
	}

	public List<OrderDetail> findByOrderId(Integer orderId) {
		Query query = em.createQuery("SELECT od FROM OrderDetail od WHERE od.restaurantOrder.id = :orderId");
		query.setParameter("orderId", orderId);
		return query.getResultList();
	}

	public RestaurantTable findTableById(Integer tableId) {
		return em.find(RestaurantTable.class, tableId);
	}

	public List getPercentageSellByDate(String year, String month) {
		Query nativeQuery = em.createNativeQuery(
				"SELECT  DAYNAME(`restaurant_order`.`date`) AS dayOfWeek, SUM(`restaurant_order`.`total`) AS totalProfit FROM `restaurant_order` WHERE `restaurant_order`.`date` LIKE :datePattern GROUP BY dayOfWeek");
		String datePattern = "";
		if (year.isEmpty()) {
			datePattern += this.currentYear;
		} else {
			datePattern += year;
		}
		if (month.isEmpty()) {
			datePattern += "-" + this.currentMonth;
		} else {
			datePattern += "-" + month;
		}
		nativeQuery.setParameter("datePattern", datePattern + "%");
		return nativeQuery.getResultList();
	}
	
	public List getRevenueInMonth(String year) {
		Query nativeQuery = em.createNativeQuery(
				"SELECT "
				+ "MONTHNAME(`restaurant_order`.`date`) AS orderMonth, "
				+ "SUM(`restaurant_order`.`total`) AS totalProfit "
				+ "FROM "
				+ "`restaurant_order` "
				+ "WHERE "
				+ "`restaurant_order`.`date` LIKE :yearPattern "
				+ "GROUP BY "
				+ "orderMonth");
		String yearPattern = "";
		if (year.isEmpty()) {
			yearPattern += this.currentYear;
		} else {
			yearPattern += year;
		}

		nativeQuery.setParameter("yearPattern", yearPattern + "%");
		return nativeQuery.getResultList();
	}
	
	public List getRevenueInYear(String year) {
		Query nativeQuery = em.createNativeQuery(
				"SELECT YEAR(`restaurant_order`.`date`) AS orderYear, SUM(`restaurant_order`.`total`) AS totalProfit FROM `restaurant_order` WHERE `restaurant_order`.`date` LIKE :yearPattern GROUP BY orderYear");
		String yearPattern = "";
		if (year.isEmpty()) {
			yearPattern += this.currentYear;
		} else {
			yearPattern += year;
		}

		nativeQuery.setParameter("yearPattern", yearPattern + "%");
		return nativeQuery.getResultList();
	}
	public List getPercenProduct(String year, String month) {
		Query nativeQuery = em.createNativeQuery(
				"SELECT product.product_title as productName, (SUM(order_detail.price) / (SELECT SUM(order_detail.price) FROM order_detail, restaurant_order WHERE order_detail.order_id = restaurant_order.order_id AND restaurant_order.date LIKE :year GROUP BY YEAR(`restaurant_order`.`date`)) )*100 as total FROM `order_detail`, `restaurant_order`, product WHERE restaurant_order.order_id = order_detail.order_id AND order_detail.product_id = product.product_id AND restaurant_order.date LIKE :year GROUP BY product.product_title");
		String datePattern = "";
		if (year.isEmpty()) {
			datePattern += this.currentYear;
		} else {
			datePattern += year;
		}
		if (month.isEmpty()) {
			datePattern += "-" + this.currentMonth;
		} else {
			datePattern += "-" + month;
		}
		nativeQuery.setParameter("year", datePattern + "%");
		return nativeQuery.getResultList();
	}

}

