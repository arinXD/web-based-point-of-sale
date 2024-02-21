package com.bidmoncafe.bidmodCafe.DTO;

import java.util.ArrayList;
import java.util.List;

import com.bidmoncafe.bidmodCafe.model.Product;

public class CategoryDTO {
	private int categoryId;
	private String categoryTitle;
    private List<Product> products = new ArrayList<>();
}
