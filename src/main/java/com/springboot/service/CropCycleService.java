package com.springboot.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.model.CropCycle;
import com.springboot.model.Farmer;
import com.springboot.repository.CropCycleRepository;

@Service
public class CropCycleService {

    @Autowired
    private CropCycleRepository cropCycleRepository;

    public List<CropCycle> findAll(){
        return cropCycleRepository.findAll();
    }

    public List<CropCycle> sortByName(){
        return cropCycleRepository
                .findAllByOrderByCycleNameAsc();
    }

    public List<CropCycle> sortByDate(){

        return cropCycleRepository
                .findAllByOrderByOpenRegDateDesc();
    }
    
    public List<CropCycle> sortByStatus(){
        return cropCycleRepository
                .findAllByOrderByStatusAsc();
    }
    
    public void delete(Integer id){
        cropCycleRepository.deleteById(id);
    }	
    
    public CropCycle save(CropCycle cycle){
        return cropCycleRepository.save(cycle);
    }
    
    public List<CropCycle> findAllOrderByName(){
        return cropCycleRepository.findAllByOrderByCycleNameAsc();
    }

    public List<CropCycle> findAllOrderByStatus(){
        return cropCycleRepository.findAllByOrderByStatusAsc();
    }

    public List<CropCycle> findAllOrderByDate(){
        return cropCycleRepository.findAllByOrderByOpenRegDateDesc();
    }
    
    public List<CropCycle> getOpenCycles() {
        return cropCycleRepository.findByStatus("OPEN");
    }

    public List<CropCycle> searchOpenCycles(String keyword) {
        return cropCycleRepository
                .findByStatusAndCycleNameContainingIgnoreCase(
                        "OPEN",
                        keyword);
    }

	public Optional<CropCycle> findById(int cycleId) {
		return cropCycleRepository.findById(cycleId);
	}

	
	

}