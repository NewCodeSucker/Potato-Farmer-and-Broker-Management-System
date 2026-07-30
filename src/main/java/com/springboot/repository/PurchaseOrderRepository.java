package com.springboot.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.model.PurchaseOrder;

public interface PurchaseOrderRepository
        extends JpaRepository<PurchaseOrder, Integer> {

    List<PurchaseOrder>
        findByCycleRegisterIdOrderByPurchaseDateAsc(int registerId);

    Optional<PurchaseOrder>
        findFirstByCycleRegisterIdOrderByPurchaseDateDesc(int registerId);
    
    
}