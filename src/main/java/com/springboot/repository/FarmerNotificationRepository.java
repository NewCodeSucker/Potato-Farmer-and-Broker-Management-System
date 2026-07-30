package com.springboot.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.model.FarmerNotification;

public interface FarmerNotificationRepository
        extends JpaRepository<FarmerNotification, Integer> {

    List<FarmerNotification>
    findTop10ByFarmerFarmerIdOrderByCreatedAtDesc(
            int farmerId
    );

    long countByFarmerFarmerIdAndReadStatusFalse(
            int farmerId
    );

    Optional<FarmerNotification>
    findByNotificationIdAndFarmerFarmerId(
            int notificationId,
            int farmerId
    );
}