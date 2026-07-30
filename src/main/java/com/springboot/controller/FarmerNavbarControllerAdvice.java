package com.springboot.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.springboot.service.FarmerNotificationService;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class FarmerNavbarControllerAdvice {

    private final FarmerNotificationService notificationService;

    public FarmerNavbarControllerAdvice(
            FarmerNotificationService notificationService) {

        this.notificationService = notificationService;
    }

    @ModelAttribute
    public void addFarmerNavbarData(
            Model model,
            HttpSession session) {

        Integer farmerId =
                (Integer) session.getAttribute("farmerId");

        if (farmerId == null) {
            return;
        }

        model.addAttribute(
                "farmerNotifications",
                notificationService.findLatest(farmerId)
        );

        model.addAttribute(
                "unreadNotificationCount",
                notificationService.countUnread(farmerId)
        );
    }
}