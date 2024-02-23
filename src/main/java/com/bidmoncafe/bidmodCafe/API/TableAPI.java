package com.bidmoncafe.bidmodCafe.API;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bidmoncafe.bidmodCafe.model.RestaurantTable;
import com.bidmoncafe.bidmodCafe.repository.TableRepository;

@RestController
@RequestMapping("/api/tables")
public class TableAPI {
	
	@Autowired
	TableRepository tableRepository;
	
	@GetMapping
	public Iterable<RestaurantTable> getAllTables() {
		return tableRepository.findAll();
	}
	@PostMapping
	public RestaurantTable createTable() {
		RestaurantTable newTable = new RestaurantTable();
		newTable.setStatus(false);
		RestaurantTable table = tableRepository.save(newTable);
		return table;
	}
	@DeleteMapping("/{id}")
	public boolean deleteTable(@PathVariable int id) {
		boolean ok = true;
		Optional<RestaurantTable> tableOption = tableRepository.findById(id);
		RestaurantTable table = tableOption.orElse(null);
		if(table.getStatus()) {
			ok = false;
			return ok;
		}else {
			tableRepository.delete(table);
			return ok;
		}
	}
}
