package com.bidmoncafe.bidmodCafe.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.bidmoncafe.bidmodCafe.model.Product;
public interface ProductRepository extends CrudRepository<Product, Integer> {
	@Query("SELECT p FROM Product p WHERE p.productTitle = :productTitle")
	public Product findByProductTitle(String productTitle);

	@Query("SELECT p FROM Product p WHERE p.category.categoryId = :categoryId")
	public List<Product> findByCategory(int categoryId);
	
	@Query("SELECT p FROM Product p WHERE p.category.categoryId = :categoryId AND p.productTitle LIKE %:productTitle%")
	public List<Product> searchProducts(@Param("categoryId") int categoryId, @Param("productTitle") String productTitle);
}
