package com.springboot.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.dto.FarmerCycleHistoryDTO;
import com.springboot.model.CycleRegister;
import com.springboot.model.ItemRequisition;
import com.springboot.model.ItemRequisitionDetail;
import com.springboot.model.PurchaseOrder;
import com.springboot.repository.ItemRequisitionRepository;
import com.springboot.repository.PurchaseOrderRepository;

@Service
public class FarmerCycleHistoryService {

    private final ItemRequisitionRepository requisitionRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;

    public FarmerCycleHistoryService(
            ItemRequisitionRepository requisitionRepository,
            PurchaseOrderRepository purchaseOrderRepository) {

        this.requisitionRepository = requisitionRepository;
        this.purchaseOrderRepository = purchaseOrderRepository;
    }

    @Transactional(readOnly = true)
    public FarmerCycleHistoryDTO buildHistory(
            CycleRegister register) {

        FarmerCycleHistoryDTO dto =
                new FarmerCycleHistoryDTO();

        dto.setRegister(register);

        /*
         * ดึงใบเบิกที่ผ่านอนุมัติทั้งหมด
         */
        List<ItemRequisition> requisitions =
                requisitionRepository
                    .findApprovedWithDetailsByRegisterId(
                        register.getRegisterId()
                    );

        dto.setRequisitions(requisitions);

        /*
         * คำนวณต้นทุนจากรายละเอียดใบเบิก
         */
        BigDecimal totalCost = BigDecimal.ZERO;

        for (ItemRequisition requisition : requisitions) {

            for (ItemRequisitionDetail detail
                    : requisition.getDetails()) {

                BigDecimal unitPrice =
                        detail.getUnitPrice() == null
                            ? BigDecimal.ZERO
                            : detail.getUnitPrice();

                BigDecimal detailCost =
                        unitPrice.multiply(
                            BigDecimal.valueOf(detail.getQty())
                        );

                totalCost = totalCost.add(detailCost);
            }
        }

        dto.setTotalCost(totalCost);

        /*
         * ดึงข้อมูลการขายทั้งหมดในรอบ
         */
        List<PurchaseOrder> purchases =
                purchaseOrderRepository
                    .findByCycleRegisterIdOrderByPurchaseDateAsc(
                        register.getRegisterId()
                    );

        dto.setPurchases(purchases);

        /*
         * เก็บรายการล่าสุดสำหรับแสดงวันที่ขายล่าสุด
         */
        if (!purchases.isEmpty()) {
            dto.setPurchase(
                purchases.get(purchases.size() - 1)
            );
        }

        /*
         * รวมปริมาณผลผลิตและรายรับ
         */
        BigDecimal totalQuantity = BigDecimal.ZERO;
        BigDecimal totalRevenue = BigDecimal.ZERO;

        for (PurchaseOrder purchase : purchases) {

            if (purchase.getQuantity() != null) {
                totalQuantity =
                        totalQuantity.add(
                            purchase.getQuantity()
                        );
            }

            if (purchase.getTotalPrice() != null) {
                totalRevenue =
                        totalRevenue.add(
                            purchase.getTotalPrice()
                        );
            }
        }

        dto.setTotalQuantity(totalQuantity);
        dto.setTotalRevenue(totalRevenue);

        /*
         * รายได้สุทธิ = รายรับรวม - ต้นทุนรวม
         */
        dto.setNetIncome(
            totalRevenue.subtract(totalCost)
        );

        return dto;
    }

    @Transactional(readOnly = true)
    public List<FarmerCycleHistoryDTO> buildHistories(
            List<CycleRegister> registers) {

        List<FarmerCycleHistoryDTO> histories =
                new ArrayList<>();

        for (CycleRegister register : registers) {
            histories.add(buildHistory(register));
        }

        return histories;
    }
}