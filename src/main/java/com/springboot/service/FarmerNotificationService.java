package com.springboot.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.model.Farmer;
import com.springboot.model.FarmerNotification;
import com.springboot.repository.FarmerNotificationRepository;

@Service
public class FarmerNotificationService {

    private final FarmerNotificationRepository repository;

    public FarmerNotificationService(
            FarmerNotificationRepository repository) {

        this.repository = repository;
    }

    public void create(
            Farmer farmer,
            String title,
            String message,
            String notificationType,
            String targetUrl) {

        FarmerNotification notification =
                new FarmerNotification();

        notification.setFarmer(farmer);
        notification.setTitle(title);
        notification.setMessage(message);
        notification.setNotificationType(
                notificationType
        );

        notification.setTargetUrl(targetUrl);
        notification.setCreatedAt(
                LocalDateTime.now()
        );

        notification.setReadStatus(false);

        repository.save(notification);
    }

    public List<FarmerNotification> findLatest(
            int farmerId) {

        return repository
                .findTop10ByFarmerFarmerIdOrderByCreatedAtDesc(
                        farmerId
                );
    }

    public long countUnread(int farmerId) {

        return repository
                .countByFarmerFarmerIdAndReadStatusFalse(
                        farmerId
                );
    }

    @Transactional
    public FarmerNotification markAsRead(
            int notificationId,
            int farmerId) {

        FarmerNotification notification =
                repository
                    .findByNotificationIdAndFarmerFarmerId(
                        notificationId,
                        farmerId
                    )
                    .orElseThrow();

        notification.setReadStatus(true);

        return repository.save(notification);
    }
}