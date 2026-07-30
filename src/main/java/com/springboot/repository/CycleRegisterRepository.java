package com.springboot.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.springboot.model.CropCycle;
import com.springboot.model.CycleRegister;
import com.springboot.model.Farmer;

public interface CycleRegisterRepository
        extends JpaRepository<CycleRegister, Integer> {

    List<CycleRegister> findByRegStatus(String regStatus);
    
    @Query("""
            SELECT COUNT(DISTINCT f.farmer.farmerId)
            FROM CycleRegister cr
            JOIN cr.farmlands f
            WHERE cr.cycle.cyleId = :cycleId
        """)
        long countFarmersByCycleId(int cycleId);

    @Query("""
    	    SELECT DISTINCT cr
    	    FROM CycleRegister cr
    	    JOIN cr.farmlands f
    	    WHERE f.farmer.farmerId = :farmerId
    	    ORDER BY cr.registerDate DESC
    	""")
    	List<CycleRegister> findByFarmerId(int farmerId);
    
   
    
    @Query("""
            SELECT COUNT(cr) > 0
            FROM CycleRegister cr
            JOIN cr.farmlands f
            WHERE cr.cycle.cyleId = :cycleId
            AND f.farmer.farmerId = :farmerId
        """)
        boolean existsByCycleIdAndFarmerId(int cycleId, int farmerId);
    
    @Query("""
            SELECT DISTINCT f.farmer
            FROM CycleRegister cr
            JOIN cr.farmlands f
            WHERE cr.cycle.cyleId = :cycleId
        """)
        List<Farmer> findFarmersByCycleId(int cycleId);
    
    @Query("""
    	    SELECT DISTINCT cr
    	    FROM CycleRegister cr
    	    JOIN cr.farmlands f
    	    WHERE cr.cycle.cyleId = :cycleId
    	    AND f.farmer.farmerId = :farmerId
    	""")
    	List<CycleRegister> findByCycleIdAndFarmerId(int cycleId,int farmerId);
    
    @Query("""
    	    SELECT DISTINCT f.farmer
    	    FROM CycleRegister cr
    	    JOIN cr.farmlands f
    	    WHERE cr.cycle.cyleId = :cycleId
    	    AND cr.regStatus = :status
    	""")
    	List<Farmer> findFarmersByCycleIdAndStatus(
    	        int cycleId,
    	        String status);
    
    @Query("""
    	    SELECT COUNT(cr)
    	    FROM CycleRegister cr
    	    WHERE cr.cycle.cyleId = :cycleId
    	    AND cr.scheduledPlantDate = :plantDate
    	    AND cr.regStatus = 'APPROVED'
    	""")
    	long countApprovedByPlantDate(
    	        int cycleId,
    	        LocalDate plantDate);
    @Query("""
    	    SELECT DISTINCT cr
    	    FROM CycleRegister cr
    	    JOIN cr.farmlands f
    	    WHERE cr.cycle.cyleId = :cycleId
    	    AND f.farmer.farmerId = :farmerId
    	    AND cr.regStatus = :status
    	    ORDER BY cr.registerId DESC
    	""")
    	List<CycleRegister> findByCycleIdAndFarmerIdAndStatus(
    	        int cycleId,
    	        int farmerId,
    	        String status);
    
    @Query("""
    	    SELECT DISTINCT cr
    	    FROM CycleRegister cr
    	    JOIN cr.farmlands f
    	    WHERE f.farmer.farmerId = :farmerId
    	    AND cr.regStatus = 'APPROVED'
    	    AND cr.cycle.status IN ('CLOSE', 'COMPLETED')
    	    ORDER BY cr.cycle.harvestDate DESC
    	""")
    	List<CycleRegister> findHistoryByFarmerId(int farmerId);
    
    @Query("""
    	    SELECT DISTINCT cr
    	    FROM CycleRegister cr
    	    JOIN cr.farmlands f
    	    WHERE f.farmer.farmerId = :farmerId
    	    AND cr.cycle.status NOT IN ('CLOSE', 'COMPLETED', 'CANCEL')
    	    ORDER BY cr.registerDate DESC
    	""")
    	List<CycleRegister> findCurrentByFarmerId(int farmerId);
    
    @Query("""
    	    SELECT DISTINCT cr
    	    FROM CycleRegister cr
    	    JOIN cr.farmlands land
    	    WHERE cr.registerId = :registerId
    	    AND land.farmer.farmerId = :farmerId
    	""")
    	Optional<CycleRegister> findHistoryRegisterForFarmer(
    	        int registerId,
    	        int farmerId
    	);
    
    @Query("""
    	    SELECT DISTINCT cr
    	    FROM CycleRegister cr
    	    JOIN cr.farmlands land
    	    WHERE land.farmer.farmerId = :farmerId
    	      AND UPPER(cr.regStatus) = 'APPROVED'
    	      AND UPPER(cr.cycle.status) = 'PROGRESS'
    	    ORDER BY cr.registerDate DESC
    	""")
    	List<CycleRegister> findApprovedProgressCyclesByFarmerId(
    	        @Param("farmerId") int farmerId
    	);

    @Query("""
    	    SELECT DISTINCT cr
    	    FROM CycleRegister cr
    	    JOIN cr.farmlands land
    	    WHERE cr.registerId = :registerId
    	      AND land.farmer.farmerId = :farmerId
    	      AND UPPER(cr.regStatus) = 'APPROVED'
    	      AND UPPER(cr.cycle.status) = 'PROGRESS'
    	""")
    	Optional<CycleRegister> findApprovedProgressCycleByRegisterIdAndFarmerId(
    	        @Param("registerId") int registerId,
    	        @Param("farmerId") int farmerId
    	);
    
    @Query("""
    	    SELECT DISTINCT land.farmer
    	    FROM CycleRegister register
    	    JOIN register.farmlands land
    	    WHERE register.registerId = :registerId
    	""")
    	Optional<Farmer> findFarmerByRegisterId(
    	        @Param("registerId") int registerId
    	);
    
    
}