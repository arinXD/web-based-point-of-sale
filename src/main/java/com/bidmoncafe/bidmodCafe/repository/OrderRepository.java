package com.bidmoncafe.bidmodCafe.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.bidmoncafe.bidmodCafe.model.RestaurantOrder;

public interface OrderRepository extends CrudRepository<RestaurantOrder, Integer>{
	
	@Query("SELECT o FROM RestaurantOrder o WHERE o.status = 0")
	public Iterable<RestaurantOrder> findAll();
	
	@Query("SELECT o FROM RestaurantOrder o WHERE o.orderType = :orderType AND o.status = 0")
	public Iterable<RestaurantOrder> findByOrderType(String orderType);
}

