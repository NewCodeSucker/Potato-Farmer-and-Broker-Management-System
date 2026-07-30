package com.springboot.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springboot.model.Farmer;
import com.springboot.repository.FarmerRepository;

@Service
public class FarmerService {

    @Autowired
    private FarmerRepository farmerRepository;

    public Optional<Farmer> findByUserName(String userName){
        return farmerRepository.findByUserName(userName);
    }
    
    public Farmer save(Farmer farmer) {
        return farmerRepository.save(farmer);
    }

    public Optional<Farmer> findById(Integer farmerId){
        return farmerRepository.findById(farmerId);
    }
    


}