package com.bidmoncafe.bidmodCafe.API;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bidmoncafe.bidmodCafe.DTO.OrderDTO;
import com.bidmoncafe.bidmodCafe.DTO.OrderDetailDTO;
import com.bidmoncafe.bidmodCafe.model.OrderDetail;
import com.bidmoncafe.bidmodCafe.model.Product;
import com.bidmoncafe.bidmodCafe.model.RestaurantOrder;
import com.bidmoncafe.bidmodCafe.model.RestaurantTable;
import com.bidmoncafe.bidmodCafe.repository.OrderDetailRepository;
import com.bidmoncafe.bidmodCafe.repository.OrderRepository;
import com.bidmoncafe.bidmodCafe.repository.ProductRepository;
import com.bidmoncafe.bidmodCafe.repository.TableRepository;

@RestController
@RequestMapping("/api/orders")
public class OrderAPI {

	@Autowired
	OrderRepository orderRepository;

	@Autowired
	ProductRepository productRepository;

	@Autowired
	OrderDetailRepository orderDetailRepository;
	
	@Autowired
	TableRepository tableRepository;

	@GetMapping
	public List<RestaurantOrder> getOrders() {
		List<RestaurantOrder> orders = (List<RestaurantOrder>) orderRepository.findAll();
		return orders;
	}

	@GetMapping("/{id}")
	public Optional<RestaurantOrder> getOrder(@PathVariable String id) {
		try {
			int oid = Integer.parseInt(id);
			Optional<RestaurantOrder> orders = orderRepository.findById(oid);
			return orders;
		} catch (Exception e) {
			return null;
		}
	}

	@GetMapping("/{id}/details")
	public Iterable<OrderDetail> getOrderDetails(@PathVariable String id) {
		try {
			int oid = Integer.parseInt(id);
			Iterable<OrderDetail> orderDetails = orderDetailRepository.findByRestaurantOrderId(oid);
			return orderDetails;
		} catch (Exception error) {
			return null;
		}
	}

	@PutMapping("/{id}/details")
	public void updateOrderDetails(@PathVariable int id ,@RequestBody OrderDTO orderDto ) {
		Optional<RestaurantOrder> orderOptional = orderRepository.findById(id);
		RestaurantOrder order = orderOptional.orElse(null);
		ArrayList<Integer> odIdList = new ArrayList<Integer>(){};
		for(OrderDetailDTO od: orderDto.orderDetail) {
			Optional<Product> productOptional = productRepository.findById(od.pid);
			Product product = productOptional.orElse(null); 
			
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrderDetailId(od.orderDetailId);
			orderDetail.setPrice(od.price);
			orderDetail.setQuantity(od.qty);
			orderDetail.setProduct(product);
			orderDetail.setRestaurantOrder(order);
			OrderDetail newOrderDetail = orderDetailRepository.save(orderDetail);
			odIdList.add(newOrderDetail.getOrderDetailId());
		}
		Iterable<OrderDetail> orderDetails = orderDetailRepository.findAll();
		ArrayList<Integer> odIdList2 = new ArrayList<Integer>(){};
		for(OrderDetail orderDetail: orderDetails) {
			odIdList2.add(orderDetail.getOrderDetailId());
		}
		
        for (int numId : odIdList2) {
            if (!odIdList.contains(numId)) {
            	Optional<OrderDetail> orderDetailOptional = orderDetailRepository.findById(numId);
            	OrderDetail orderDtail = orderDetailOptional.orElse(null); 
    			orderDetailRepository.delete(orderDtail);
            }
        }
	}

	@PostMapping
	public RestaurantOrder createOrder(@RequestBody OrderDTO order) {
		RestaurantOrder newOrder = new RestaurantOrder();
		newOrder.setOrderType(order.orderType);
		int total = 0;
		ArrayList<OrderDetail> orderDatails = new ArrayList() {};
		for (OrderDetailDTO od : order.orderDetail) {
			Optional<Product> productOptional = productRepository.findById(od.pid);
			Product product = productOptional.orElse(null);
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setQuantity(od.qty);
			orderDetail.setPrice(od.price);
			orderDetail.setProduct(product);
			orderDetail.setRestaurantOrder(newOrder);
			total += od.price * od.qty;
			orderDatails.add(orderDetail);
		}
		newOrder.setTotal(total);
		newOrder.setDate(new Date());
		newOrder.setOrderType(order.orderType);
		newOrder.setStatus(0);
		newOrder.setOrderDetails(orderDatails);
		orderRepository.save(newOrder);
		
		return newOrder;
	}
	
	@PutMapping("/{oid}/tables/{tid}")
	public RestaurantOrder updateOrder(@PathVariable int oid ,@PathVariable int tid) {
		try {			
			RestaurantTable table = new RestaurantTable();
			Optional<RestaurantOrder> orderOptin = orderRepository.findById(oid);
			RestaurantOrder order = orderOptin.orElse(null);
			table.setTableId(tid);
			table.setStatus(true);
			tableRepository.save(table);
			order.setRestaurantTable(table);
			orderRepository.save(order);
			return order;
		}catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}

}

class ResponseDTO{
	public boolean ok;
	public ResponseDTO(boolean ok) {
		this.ok = ok;
	}
}
