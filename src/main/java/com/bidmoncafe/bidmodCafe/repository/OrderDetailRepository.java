package com.bidmoncafe.bidmodCafe.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.bidmoncafe.bidmodCafe.model.OrderDetail;


public interface OrderDetailRepository extends CrudRepository<OrderDetail, Integer> {
	
    @Query("SELECT od FROM OrderDetail od WHERE od.restaurantOrder.orderId = :id")
    public Iterable<OrderDetail> findByRestaurantOrderId(int id);
}
