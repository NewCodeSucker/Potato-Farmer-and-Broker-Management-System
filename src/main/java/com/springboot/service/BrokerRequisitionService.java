package com.springboot.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.dto.BrokerRequisitionListDTO;
import com.springboot.model.Farmer;
import com.springboot.model.ItemRequisition;
import com.springboot.model.ItemRequisitionDetail;
import com.springboot.repository.CycleRegisterRepository;
import com.springboot.repository.ItemRequisitionDetailRepository;
import com.springboot.repository.ItemRequisitionRepository;

@Service
public class BrokerRequisitionService {

    private static final String INITIAL_ALLOCATION =
            "INITIAL_ALLOCATION";

    private static final String SUBMITTED =
            "SUBMITTED";

    private static final String APPROVED =
            "APPROVED";

    private static final String REJECTED =
            "REJECTED";

    private final ItemRequisitionRepository requisitionRepository;

    private final ItemRequisitionDetailRepository detailRepository;

    private final CycleRegisterRepository cycleRegisterRepository;

    private final FarmerNotificationService notificationService;

    public BrokerRequisitionService(
            ItemRequisitionRepository requisitionRepository,
            ItemRequisitionDetailRepository detailRepository,
            CycleRegisterRepository cycleRegisterRepository,
            FarmerNotificationService notificationService) {

        this.requisitionRepository =
                requisitionRepository;

        this.detailRepository =
                detailRepository;

        this.cycleRegisterRepository =
                cycleRegisterRepository;

        this.notificationService =
                notificationService;
    }

    /*
     * ===========================
     * BROKER LIST
     * ===========================
     */

    @Transactional(readOnly = true)
    public List<BrokerRequisitionListDTO> findRequisitions(
            Integer cycleId,
            String status) {

        String normalizedStatus =
                normalizeStatusFilter(status);

        List<ItemRequisition> requisitions =
                requisitionRepository
                        .findBrokerRequisitions(
                                cycleId,
                                normalizedStatus
                        );

        List<BrokerRequisitionListDTO> result =
                new ArrayList<>();

        for (ItemRequisition requisition : requisitions) {

            int requisitionId =
                    requisition.getRequisitionId();

            int registerId =
                    requisition.getCycle()
                            .getRegisterId();

            Farmer farmer =
                    cycleRegisterRepository
                            .findFarmerByRegisterId(
                                    registerId
                            )
                            .orElse(null);

            List<ItemRequisitionDetail> details =
                    detailRepository
                            .findByRequisitionIdWithItem(
                                    requisitionId
                            );

            BigDecimal totalPrice =
                    calculateTotal(details);

            BrokerRequisitionListDTO dto =
                    new BrokerRequisitionListDTO();

            dto.setRequisitionId(
                    requisitionId
            );

            dto.setCycleId(
                    requisition.getCycle()
                            .getCycle()
                            .getCyleId()
            );

            dto.setCycleName(
                    requisition.getCycle()
                            .getCycle()
                            .getCycleName()
            );

            dto.setSubmitDate(
                    requisition.getSubmitDate()
            );

            dto.setStatus(
                    requisition.getStatus()
            );

            dto.setDetailCount(
                    details.size()
            );

            dto.setTotalPrice(
                    totalPrice
            );

            if (farmer != null) {

                dto.setFarmerId(
                        farmer.getFarmerId()
                );

                dto.setFarmerName(
                        farmer.getFirstname()
                        + " "
                        + farmer.getLastname()
                );

                dto.setPhoneNumber(
                        farmer.getPhoneNumber()
                );

            } else {

                dto.setFarmerName(
                        "ไม่พบข้อมูลเกษตรกร"
                );

                dto.setPhoneNumber("-");
            }

            result.add(dto);
        }

        return result;
    }

    /*
     * ===========================
     * BROKER DETAIL
     * ===========================
     */

    @Transactional(readOnly = true)
    public ItemRequisition findDetail(
            int requisitionId) {

        ItemRequisition requisition =
                requisitionRepository
                        .findBrokerRequisitionDetail(
                                requisitionId
                        )
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "ไม่พบใบเบิกที่ต้องการ"
                                )
                        );

        ensureNotInitialAllocation(
                requisition
        );

        return requisition;
    }

    @Transactional(readOnly = true)
    public Farmer findFarmer(
            ItemRequisition requisition) {

        return cycleRegisterRepository
                .findFarmerByRegisterId(
                        requisition.getCycle()
                                .getRegisterId()
                )
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "ไม่พบข้อมูลเกษตรกรของใบเบิก"
                        )
                );
    }

    /*
     * ===========================
     * CALCULATE TOTAL
     * ===========================
     */

    public BigDecimal calculateTotal(
            ItemRequisition requisition) {

        if (requisition == null
                || requisition.getDetails() == null) {

            return BigDecimal.ZERO;
        }

        return calculateTotal(
                requisition.getDetails()
        );
    }

    private BigDecimal calculateTotal(
            List<ItemRequisitionDetail> details) {

        BigDecimal total =
                BigDecimal.ZERO;

        if (details == null) {
            return total;
        }

        for (ItemRequisitionDetail detail : details) {

            if (detail == null) {
                continue;
            }

            total = total.add(
                    detail.getTotalPrice()
            );
        }

        return total;
    }

    /*
     * ===========================
     * APPROVE / REJECT
     * ===========================
     */

    @Transactional
    public void review(
            int requisitionId,
            String decision) {

        ItemRequisition requisition =
                requisitionRepository
                        .findBrokerRequisitionDetail(
                                requisitionId
                        )
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "ไม่พบใบเบิกที่ต้องการ"
                                )
                        );

        /*
         * ป้องกันโบรกเกอร์พิจารณา
         * ใบจัดสรรหัวพันธุ์และปุ๋ย
         */
        ensureNotInitialAllocation(
                requisition
        );

        if (!SUBMITTED.equalsIgnoreCase(
                requisition.getStatus())) {

            throw new IllegalArgumentException(
                    "พิจารณาได้เฉพาะใบเบิกที่ส่งแล้วเท่านั้น"
            );
        }

        String finalStatus =
                normalizeDecision(decision);

        requisition.setStatus(
                finalStatus
        );

        requisitionRepository.save(
                requisition
        );

        Farmer farmer =
                findFarmer(requisition);

        String cycleName =
                requisition.getCycle()
                        .getCycle()
                        .getCycleName();

        if (APPROVED.equals(finalStatus)) {

            notificationService.create(
                    farmer,
                    "ใบเบิกได้รับการอนุมัติ",
                    "ใบเบิก REQ"
                    + requisition.getRequisitionId()
                    + " ของรอบ "
                    + cycleName
                    + " ได้รับการอนุมัติแล้ว",
                    "REQUISITION_APPROVED",
                    "/farmer/requisition/"
                    + requisition.getRequisitionId()
            );

        } else {

            notificationService.create(
                    farmer,
                    "ใบเบิกไม่ได้รับการอนุมัติ",
                    "ใบเบิก REQ"
                    + requisition.getRequisitionId()
                    + " ของรอบ "
                    + cycleName
                    + " ไม่ได้รับการอนุมัติ",
                    "REQUISITION_REJECTED",
                    "/farmer/requisition/"
                    + requisition.getRequisitionId()
            );
        }
    }

    /*
     * ===========================
     * VALIDATION
     * ===========================
     */

    private void ensureNotInitialAllocation(
            ItemRequisition requisition) {

        String type =
                requisition.getRequisitionType();

        /*
         * NULL ถือว่าเป็นใบเบิกเกษตรกรเดิม
         * จึงอนุญาตให้แสดงและพิจารณา
         */
        if (type != null
                && INITIAL_ALLOCATION
                    .equalsIgnoreCase(type.trim())) {

            throw new IllegalArgumentException(
                    "ไม่สามารถพิจารณาใบจัดสรรหัวพันธุ์และปุ๋ยได้"
            );
        }
    }

    private String normalizeStatusFilter(
            String status) {

        if (status == null
                || status.trim().isEmpty()) {

            return null;
        }

        return status.trim()
                .toUpperCase();
    }

    private String normalizeDecision(
            String decision) {

        if (APPROVED.equalsIgnoreCase(
                decision)) {

            return APPROVED;
        }

        if (REJECTED.equalsIgnoreCase(
                decision)) {

            return REJECTED;
        }

        throw new IllegalArgumentException(
                "ผลการพิจารณาไม่ถูกต้อง"
        );
    }
}