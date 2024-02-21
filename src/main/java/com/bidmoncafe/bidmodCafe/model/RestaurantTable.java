package com.bidmoncafe.bidmodCafe.model;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class RestaurantTable {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int tableId;
	private String title;
	private int status;
	
	@OneToMany(mappedBy = "restaurantTable", cascade = CascadeType.ALL)
	@JsonIgnore
    private List<RestaurantOrder> orders = new ArrayList<>();

	public int getTableId() {
		return tableId;
	}

	public void setTableId(int tableId) {
		this.tableId = tableId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public List<RestaurantOrder> getOrders() {
		return orders;
	}

	public void setOrders(List<RestaurantOrder> orders) {
		this.orders = orders;
	}

	public RestaurantTable(int tableId, String title, int status, List<RestaurantOrder> orders) {
		super();
		this.tableId = tableId;
		this.title = title;
		this.status = status;
		this.orders = orders;
	}
	
	public RestaurantTable() {}
	
}
