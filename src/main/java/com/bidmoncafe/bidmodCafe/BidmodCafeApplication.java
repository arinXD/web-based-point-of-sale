package com.bidmoncafe.bidmodCafe;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class BidmodCafeApplication {

	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(BidmodCafeApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(BidmodCafeApplication.class, args);
	}

}
