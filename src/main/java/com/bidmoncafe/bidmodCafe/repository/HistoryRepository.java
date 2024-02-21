package com.bidmoncafe.bidmodCafe.repository;
import org.springframework.data.repository.CrudRepository;

import com.bidmoncafe.bidmodCafe.model.RestaurantOrder;

public interface HistoryRepository extends CrudRepository<RestaurantOrder, Integer> {
	RestaurantOrder findById(int orderId);
}
