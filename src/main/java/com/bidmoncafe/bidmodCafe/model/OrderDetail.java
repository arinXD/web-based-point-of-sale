package com.bidmoncafe.bidmodCafe.model;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "orderDetailId")
public class OrderDetail {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int orderDetailId;
	private int quantity;
	private double price;
	
	@ManyToOne
    @JoinColumn(name = "orderId")
	@JsonIgnore
    private RestaurantOrder restaurantOrder;
	
	@ManyToOne
    @JoinColumn(name = "productId")
    private Product product;

	public int getOrderDetailId() {
		return orderDetailId;
	}

	public void setOrderDetailId(int orderDetailId) {
		this.orderDetailId = orderDetailId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public RestaurantOrder getRestaurantOrder() {
		return restaurantOrder;
	}

	public void setRestaurantOrder(RestaurantOrder restaurantOrder) {
		this.restaurantOrder = restaurantOrder;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public OrderDetail(int orderDetailId, int quantity, double price, RestaurantOrder restaurantOrder,
			Product product) {
		super();
		this.orderDetailId = orderDetailId;
		this.quantity = quantity;
		this.price = price;
		this.restaurantOrder = restaurantOrder;
		this.product = product;
	}
	
	
	public OrderDetail(int quantity, double price, RestaurantOrder restaurantOrder, Product product) {
		super();
		this.quantity = quantity;
		this.price = price;
		this.restaurantOrder = restaurantOrder;
		this.product = product;
	}

	public OrderDetail() {}
}
