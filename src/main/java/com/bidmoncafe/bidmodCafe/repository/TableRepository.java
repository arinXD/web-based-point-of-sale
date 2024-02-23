package com.bidmoncafe.bidmodCafe.repository;

import org.springframework.data.repository.CrudRepository;

import com.bidmoncafe.bidmodCafe.model.RestaurantTable;

public interface TableRepository extends CrudRepository<RestaurantTable, Integer> {

}
