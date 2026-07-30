package com.springboot.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.springboot.model.Farmer;

@Repository
public interface FarmerRepository extends JpaRepository<Farmer, Integer> {

    Optional<Farmer> findByUserName(String userName);
    
    

}