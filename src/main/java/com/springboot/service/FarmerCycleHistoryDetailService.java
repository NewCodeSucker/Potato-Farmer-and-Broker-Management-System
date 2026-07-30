package com.springboot.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.dto.FarmerCycleHistoryDetailDTO;
import com.springboot.model.CycleRegister;
import com.springboot.model.ItemRequisition;
import com.springboot.model.ItemRequisitionDetail;
import com.springboot.model.PurchaseOrder;
import com.springboot.repository.ItemRequisitionRepository;
import com.springboot.repository.PurchaseOrderRepository;

@Service
public class FarmerCycleHistoryDetailService {

    private final PurchaseOrderRepository purchaseOrderRepository;
    private final ItemRequisitionRepository itemRequisitionRepository;

    public FarmerCycleHistoryDetailService(
            PurchaseOrderRepository purchaseOrderRepository,
            ItemRequisitionRepository itemRequisitionRepository) {

        this.purchaseOrderRepository =
                purchaseOrderRepository;

        this.itemRequisitionRepository =
                itemRequisitionRepository;
    }

    @Transactional(readOnly = true)
    public FarmerCycleHistoryDetailDTO buildDetail(
            CycleRegister register) {

        FarmerCycleHistoryDetailDTO dto =
                new FarmerCycleHistoryDetailDTO();

        dto.setRegister(register);

        List<PurchaseOrder> purchases =
                purchaseOrderRepository
                    .findByCycleRegisterIdOrderByPurchaseDateAsc(
                        register.getRegisterId()
                    );

        dto.setPurchases(purchases);

        BigDecimal totalQuantity =
                BigDecimal.ZERO;

        BigDecimal totalRevenue =
                BigDecimal.ZERO;

        for (PurchaseOrder purchase : purchases) {

            if (purchase.getQuantity() != null) {
                totalQuantity = totalQuantity.add(
                    purchase.getQuantity()
                );
            }

            if (purchase.getTotalPrice() != null) {
                totalRevenue = totalRevenue.add(
                    purchase.getTotalPrice()
                );
            }
        }

        dto.setTotalQuantity(totalQuantity);
        dto.setTotalRevenue(totalRevenue);

        List<ItemRequisition> requisitions =
                itemRequisitionRepository
                    .findApprovedWithDetailsByRegisterId(
                        register.getRegisterId()
                    );

        dto.setRequisitions(requisitions);

        BigDecimal totalCost =
                BigDecimal.ZERO;

        for (ItemRequisition requisition : requisitions) {

            if (requisition.getDetails() == null) {
                continue;
            }

            for (ItemRequisitionDetail detail
                    : requisition.getDetails()) {

                BigDecimal unitPrice =
                        detail.getUnitPrice() == null
                            ? BigDecimal.ZERO
                            : detail.getUnitPrice();

                BigDecimal rowTotal =
                        unitPrice.multiply(
                            BigDecimal.valueOf(
                                detail.getQty()
                            )
                        );

                totalCost = totalCost.add(rowTotal);
            }
        }

        dto.setTotalCost(totalCost);

        dto.setNetIncome(
            totalRevenue.subtract(totalCost)
        );

        return dto;
    }
}