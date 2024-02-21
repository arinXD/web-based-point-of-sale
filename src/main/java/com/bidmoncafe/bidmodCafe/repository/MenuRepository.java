package com.bidmoncafe.bidmodCafe.repository;

import org.springframework.data.repository.CrudRepository;

import com.bidmoncafe.bidmodCafe.model.Product;


public interface MenuRepository extends CrudRepository<Product, Integer>{

}
