package com.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.model.CropCycle;

public interface CropCycleRepository
	extends JpaRepository<CropCycle,Integer>{
	
	List<CropCycle> findAllByOrderByCycleNameAsc();
	
	List<CropCycle> findAllByOrderByCyleIdDesc();
	
	List<CropCycle> findAllByOrderByOpenRegDateDesc();
	
	List<CropCycle> findAllByOrderByStatusAsc();
	
    List<CropCycle> findByStatus(String status);

	
	List<CropCycle> findByStatusAndCycleNameContainingIgnoreCase(
            String status,
            String cycleName);

}