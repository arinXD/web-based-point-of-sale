package com.bidmoncafe.bidmodCafe.repository;

import java.util.List;
import org.springframework.stereotype.Repository;

import com.bidmoncafe.bidmodCafe.model.OrderDetail;
import com.bidmoncafe.bidmodCafe.model.RestaurantTable;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

@Repository
public class BilllRepository {
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
	


}
