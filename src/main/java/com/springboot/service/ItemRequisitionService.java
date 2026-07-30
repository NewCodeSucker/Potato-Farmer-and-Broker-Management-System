package com.springboot.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.dto.RequisitionDetailFormDTO;
import com.springboot.dto.RequisitionFormDTO;
import com.springboot.model.CycleRegister;
import com.springboot.model.Item;
import com.springboot.model.ItemRequisition;
import com.springboot.model.ItemRequisitionDetail;
import com.springboot.repository.CycleRegisterRepository;
import com.springboot.repository.ItemRepository;
import com.springboot.repository.ItemRequisitionRepository;

@Service
public class ItemRequisitionService {

    private static final String DRAFT = "DRAFT";
    private static final String SUBMITTED = "SUBMITTED";
    private static final String CHEMICAL = "CHEMICAL";

    private final ItemRequisitionRepository requisitionRepository;
    private final CycleRegisterRepository cycleRegisterRepository;
    private final ItemRepository itemRepository;

    public ItemRequisitionService(
            ItemRequisitionRepository requisitionRepository,
            CycleRegisterRepository cycleRegisterRepository,
            ItemRepository itemRepository) {

        this.requisitionRepository = requisitionRepository;
        this.cycleRegisterRepository = cycleRegisterRepository;
        this.itemRepository = itemRepository;
    }

    public List<ItemRequisition> findFarmerRequisitions(
            int farmerId,
            Integer registerId,
            String status) {

        return requisitionRepository.findFarmerRequisitions(
                farmerId,
                registerId,
                status
        );
    }

    public List<CycleRegister> findApprovedProgressCycles(int farmerId) {

        return cycleRegisterRepository
                .findApprovedProgressCyclesByFarmerId(
                        farmerId
                );
    }
    public List<Item> findChemicalItems() {
        return itemRepository
                .findByItemTypeOrderByItemNameAsc(CHEMICAL);
    }

    public ItemRequisition findOwnedRequisition(
            int requisitionId,
            int farmerId) {

        return requisitionRepository
                .findByIdAndFarmerIdWithDetails(
                        requisitionId,
                        farmerId
                )
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "ไม่พบใบเบิกที่ต้องการ"
                        )
                );
    }

    @Transactional
    public ItemRequisition createDraft(
            RequisitionFormDTO form,
            int farmerId) {

    	CycleRegister register =
    	        findApprovedProgressRegister(
    	                form.getRegisterId(),
    	                farmerId
    	        );

        validateDetails(form.getDetails());

        ItemRequisition requisition =
                new ItemRequisition();

        requisition.setCycle(register);
        requisition.setStatus(DRAFT);
        requisition.setSubmitDate(LocalDate.now());

        addDetails(
                requisition,
                form.getDetails()
        );

        return requisitionRepository.save(requisition);
    }

    @Transactional
    public ItemRequisition updateDraft(
            int requisitionId,
            RequisitionFormDTO form,
            int farmerId) {

        ItemRequisition requisition =
                findOwnedRequisition(
                        requisitionId,
                        farmerId
                );

        ensureDraft(requisition);

        CycleRegister register =
                findApprovedProgressRegister(
                        form.getRegisterId(),
                        farmerId
                );

        validateDetails(form.getDetails());

        requisition.setCycle(register);

        requisition.getDetails().clear();

        addDetails(
                requisition,
                form.getDetails()
        );

        return requisitionRepository.save(requisition);
    }

    @Transactional
    public void deleteDraft(
            int requisitionId,
            int farmerId) {

        ItemRequisition requisition =
                findOwnedRequisition(
                        requisitionId,
                        farmerId
                );

        ensureDraft(requisition);

        requisitionRepository.delete(requisition);
    }

    @Transactional
    public void submit(
            int requisitionId,
            int farmerId) {

        ItemRequisition requisition =
                findOwnedRequisition(
                        requisitionId,
                        farmerId
                );

        ensureDraft(requisition);

        if (requisition.getDetails() == null
                || requisition.getDetails().isEmpty()) {

            throw new IllegalArgumentException(
                    "ใบเบิกต้องมีอย่างน้อย 1 รายการ"
            );
        }

        requisition.setStatus(SUBMITTED);
        requisition.setSubmitDate(LocalDate.now());

        requisitionRepository.save(requisition);
    }

    public RequisitionFormDTO createEditForm(
            ItemRequisition requisition) {

        RequisitionFormDTO form =
                new RequisitionFormDTO();

        form.setRequisitionId(
                requisition.getRequisitionId()
        );

        form.setRegisterId(
                requisition.getCycle().getRegisterId()
        );

        List<RequisitionDetailFormDTO> details =
                new ArrayList<>();

        for (ItemRequisitionDetail detail
                : requisition.getDetails()) {

            RequisitionDetailFormDTO row =
                    new RequisitionDetailFormDTO();

            row.setItemId(
                    detail.getItem().getItemId()
            );

            row.setQty(detail.getQty());
            row.setCause(detail.getCause());

            details.add(row);
        }

        form.setDetails(details);

        return form;
    }

    public BigDecimal calculateTotal(
            ItemRequisition requisition) {

        BigDecimal total = BigDecimal.ZERO;

        if (requisition.getDetails() == null) {
            return total;
        }

        for (ItemRequisitionDetail detail
                : requisition.getDetails()) {

            total = total.add(
                    detail.getTotalPrice()
            );
        }

        return total;
    }

    private CycleRegister findApprovedProgressRegister(Integer registerId,int farmerId) {

        if (registerId == null) {
            throw new IllegalArgumentException(
                    "กรุณาเลือกรอบเพาะปลูก"
            );
        }

        return cycleRegisterRepository
                .findApprovedProgressCycleByRegisterIdAndFarmerId(
                        registerId,
                        farmerId
                )
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "สามารถสร้างใบเบิกได้เฉพาะรอบที่ได้รับอนุมัติและกำลังดำเนินการอยู่เท่านั้น"
                        )
                );
    }
    private void validateDetails(
            List<RequisitionDetailFormDTO> details) {

        if (details == null || details.isEmpty()) {
            throw new IllegalArgumentException(
                    "ต้องมีรายการเบิกอย่างน้อย 1 รายการ"
            );
        }

        for (RequisitionDetailFormDTO row : details) {

            if (row.getItemId() == null) {
                throw new IllegalArgumentException(
                        "กรุณาเลือกรายการยา/สารเคมี"
                );
            }

            if (row.getQty() == null
                    || row.getQty() <= 0) {

                throw new IllegalArgumentException(
                        "จำนวนที่เบิกต้องมากกว่า 0"
                );
            }

            if (row.getCause() == null
                    || row.getCause().trim().isEmpty()) {

                throw new IllegalArgumentException(
                        "กรุณาระบุเหตุผลการเบิก"
                );
            }

            Item item = itemRepository
                    .findById(row.getItemId())
                    .orElseThrow(() ->
                            new IllegalArgumentException(
                                    "ไม่พบรายการสินค้า"
                            )
                    );

            if (!CHEMICAL.equalsIgnoreCase(
                    item.getItemType())) {

                throw new IllegalArgumentException(
                        "สามารถเบิกได้เฉพาะยาและสารเคมี"
                );
            }
        }
    }

    private void addDetails(
            ItemRequisition requisition,
            List<RequisitionDetailFormDTO> rows) {

        for (RequisitionDetailFormDTO row : rows) {

            Item item = itemRepository
                    .findById(row.getItemId())
                    .orElseThrow(() ->
                            new IllegalArgumentException(
                                    "ไม่พบรายการสินค้า"
                            )
                    );

            if (!CHEMICAL.equalsIgnoreCase(
                    item.getItemType())) {

                throw new IllegalArgumentException(
                        "สามารถเบิกได้เฉพาะยาและสารเคมี"
                );
            }

            ItemRequisitionDetail detail =
                    new ItemRequisitionDetail();

            detail.setItem(item);
            detail.setQty(row.getQty());
            detail.setCause(row.getCause().trim());
            detail.setUnitPrice(item.getUnitPrice());

            requisition.addDetail(detail);
        }
    }

    private void ensureDraft(
            ItemRequisition requisition) {

        if (!DRAFT.equalsIgnoreCase(
                requisition.getStatus())) {

            throw new IllegalArgumentException(
                    "ใบเบิกที่ส่งแล้วไม่สามารถแก้ไขหรือลบได้"
            );
        }
    }
}