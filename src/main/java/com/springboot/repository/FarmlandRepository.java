package com.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.springboot.model.Farmland;

public interface FarmlandRepository
        extends JpaRepository<Farmland, Integer>{

    List<Farmland> findByFarmerFarmerId(int farmerId);
    

    @Query("""
        SELECT DISTINCT f
        FROM Farmland f
        JOIN f.cycleRegisters cr
        WHERE f.farmer.farmerId = :farmerId
        AND cr.cycle.cyleId = :cycleId
    """)
    List<Farmland> findByFarmerIdAndCycleId(int farmerId, int cycleId);
    
    List<Farmland>
    findByCycleRegistersRegisterId(
            int registerId
    );

}