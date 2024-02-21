package com.bidmoncafe.bidmodCafe.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.bidmoncafe.bidmodCafe.model.User;

public interface UserRepository extends CrudRepository<User, Long>{
	@Query("SELECT u FROM User u WHERE u.email = :email")
	public User findByEmail(String email);
}
