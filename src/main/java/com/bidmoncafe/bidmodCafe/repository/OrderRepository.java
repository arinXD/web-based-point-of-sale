package com.bidmoncafe.bidmodCafe.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.bidmoncafe.bidmodCafe.model.RestaurantOrder;

public interface OrderRepository extends CrudRepository<RestaurantOrder, Integer>{
	
	@Query("SELECT o FROM RestaurantOrder o WHERE o.status = 0")
	public Iterable<RestaurantOrder> findAll();
	
	@Query("SELECT o FROM RestaurantOrder o WHERE o.orderType = :orderType AND o.status = 0")
	public Iterable<RestaurantOrder> findByOrderType(String orderType);
	
	@Query("SELECT SUM(o.total) FROM RestaurantOrder o")
	public Double getTotalRevenue();

	@Query("SELECT SUM(o.total) FROM RestaurantOrder o WHERE o.orderType = 'table'")
	public Double getTotalTakeHomeRevenue();

	@Query("SELECT COUNT(o) FROM RestaurantOrder o")
	public Long getTotalCountOrder();

	@Query("SELECT COUNT(o.orderType) FROM RestaurantOrder o WHERE o.orderType = 'table'")
	public Long getTotalCountTakeHome();
	
}