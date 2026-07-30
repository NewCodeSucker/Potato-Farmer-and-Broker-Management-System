package com.springboot.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.constant.RequisitionStatus;
import com.springboot.constant.RequisitionType;
import com.springboot.model.CycleRegister;
import com.springboot.model.Farmland;
import com.springboot.model.Item;
import com.springboot.model.ItemRequisition;
import com.springboot.model.ItemRequisitionDetail;
import com.springboot.repository.ItemRepository;
import com.springboot.repository.ItemRequisitionRepository;

@Service
public class InitialAllocationService {

    private static final BigDecimal SEED_PER_RAI =
            new BigDecimal("200.00");

    private static final BigDecimal FERTILIZER_15_PER_RAI =
            new BigDecimal("50.00");

    private static final BigDecimal FERTILIZER_13_PER_RAI =
            new BigDecimal("50.00");

    private static final BigDecimal FERTILIZER_46_PER_RAI =
            new BigDecimal("25.00");

    private final ItemRepository itemRepository;
    private final ItemRequisitionRepository requisitionRepository;
    private final FarmlandService landAreaService;

    public InitialAllocationService(
            ItemRepository itemRepository,
            ItemRequisitionRepository requisitionRepository,
            FarmlandService landAreaService) {

        this.itemRepository = itemRepository;
        this.requisitionRepository = requisitionRepository;
        this.landAreaService = landAreaService;
    }

    @Transactional
    public ItemRequisition createInitialAllocation(
            CycleRegister register,
            List<Farmland> lands) {

        boolean alreadyExists =
                requisitionRepository
                    .existsByCycleRegisterIdAndRequisitionType(
                        register.getRegisterId(),
                        RequisitionType.INITIAL_ALLOCATION
                    );

        if (alreadyExists) {
            return requisitionRepository
                    .findByRegisterIdAndTypeWithDetails(
                        register.getRegisterId(),
                        RequisitionType.INITIAL_ALLOCATION
                    )
                    .orElseThrow();
        }

        BigDecimal totalRai =
                landAreaService.calculateTotalRai(lands);

        if (totalRai.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException(
                    "ไม่สามารถจัดสรรได้ เนื่องจากพื้นที่รวมเป็นศูนย์"
            );
        }

        Item seed = findItem(
                "SEED",
                "หัวพันธุ์"
        );

        Item fertilizer15 = findItem(
                "FERTILIZER",
                "15-15-15"
        );

        Item fertilizer13 = findItem(
                "FERTILIZER",
                "13-13-21"
        );

        Item fertilizer46 = findItem(
                "FERTILIZER",
                "46-0-0"
        );

        ItemRequisition requisition =
                new ItemRequisition();

        requisition.setCycle(register);
        requisition.setSubmitDate(LocalDate.now());

        /*
         * เป็นการจัดสรรโดยระบบและถือว่าอนุมัติทันที
         */
        requisition.setStatus(
                RequisitionStatus.APPROVED
        );

        requisition.setRequisitionType(
                RequisitionType.INITIAL_ALLOCATION
        );

        requisition.addDetail(
                createDetail(
                        seed,
                        totalRai,
                        SEED_PER_RAI,
                        "จัดสรรหัวพันธุ์ตามพื้นที่ที่ได้รับอนุมัติ"
                )
        );

        requisition.addDetail(
                createDetail(
                        fertilizer15,
                        totalRai,
                        FERTILIZER_15_PER_RAI,
                        "จัดสรรปุ๋ยสูตร 15-15-15 ตามพื้นที่"
                )
        );

        requisition.addDetail(
                createDetail(
                        fertilizer13,
                        totalRai,
                        FERTILIZER_13_PER_RAI,
                        "จัดสรรปุ๋ยสูตร 13-13-21 ตามพื้นที่"
                )
        );

        requisition.addDetail(
                createDetail(
                        fertilizer46,
                        totalRai,
                        FERTILIZER_46_PER_RAI,
                        "จัดสรรปุ๋ยสูตร 46-0-0 ตามพื้นที่"
                )
        );

        return requisitionRepository.save(requisition);
    }

    private ItemRequisitionDetail createDetail(
            Item item,
            BigDecimal totalRai,
            BigDecimal quantityPerRai,
            String cause) {

        BigDecimal quantityDecimal =
                totalRai.multiply(quantityPerRai)
                        .setScale(
                            0,
                            RoundingMode.CEILING
                        );

        int quantity =
                quantityDecimal.intValueExact();

        ItemRequisitionDetail detail =
                new ItemRequisitionDetail();

        detail.setItem(item);
        detail.setCause(cause);
        detail.setQty(quantity);
        detail.setUnitPrice(item.getUnitPrice());

        return detail;
    }

    private Item findItem(
            String itemType,
            String keyword) {

        return itemRepository
                .findFirstByItemTypeAndItemNameContainingIgnoreCase(
                        itemType,
                        keyword
                )
                .orElseThrow(() ->
                        new IllegalArgumentException(
                            "ไม่พบรายการ "
                            + keyword
                            + " ในตาราง item"
                        )
                );
    }
}