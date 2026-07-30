package com.springboot.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.model.Farmland;
import com.springboot.repository.FarmlandRepository;

@Service
public class FarmlandService {

    @Autowired
    private FarmlandRepository farmlandRepository;

    public Farmland save(Farmland farmland) {
        return farmlandRepository.save(farmland);	
    }

    public List<Farmland> findAll() {
        return farmlandRepository.findAll();
    }

    public Optional<Farmland> findById(int landId) {
        return farmlandRepository.findById(landId);
    }

    public List<Farmland> findByFarmerId(int farmerId) {
        return farmlandRepository.findByFarmerFarmerId(farmerId);
    }

    public void deleteById(int landId) {
        farmlandRepository.deleteById(landId);
    }
    
    public void saveAll(List<Farmland> lands) {
        farmlandRepository.saveAll(lands);
    }
    
    public List<Farmland> findByFarmerIdAndCycleId(int farmerId, int cycleId) {
        return farmlandRepository.findByFarmerIdAndCycleId(farmerId, cycleId);
    }
    public BigDecimal calculateTotalRai(
            List<Farmland> lands) {

        BigDecimal total = BigDecimal.ZERO;

        for (Farmland land : lands) {

            BigDecimal rai =
                    land.getRai() == null
                            ? BigDecimal.ZERO
                            : land.getRai();

            BigDecimal ngan =
                    land.getNgan() == null
                            ? BigDecimal.ZERO
                            : land.getNgan();

            BigDecimal squareWah =
                    land.getSqureWah() == null
                            ? BigDecimal.ZERO
                            : land.getSqureWah();

            BigDecimal nganToRai =
                    ngan.divide(
                            BigDecimal.valueOf(4),
                            4,
                            RoundingMode.HALF_UP
                    );

            BigDecimal wahToRai =
                    squareWah.divide(
                            BigDecimal.valueOf(400),
                            4,
                            RoundingMode.HALF_UP
                    );

            total = total
                    .add(rai)
                    .add(nganToRai)
                    .add(wahToRai);
        }

        return total.setScale(
                2,
                RoundingMode.HALF_UP
        );
    }
}