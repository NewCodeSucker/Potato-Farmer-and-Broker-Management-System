package com.springboot.dto;

import java.util.ArrayList;
import java.util.List;

public class RequisitionFormDTO {

    private Integer requisitionId;
    private Integer registerId;

    private List<RequisitionDetailFormDTO> details =
            new ArrayList<>();

    public RequisitionFormDTO() {
    }

    public Integer getRequisitionId() {
        return requisitionId;
    }

    public void setRequisitionId(Integer requisitionId) {
        this.requisitionId = requisitionId;
    }

    public Integer getRegisterId() {
        return registerId;
    }

    public void setRegisterId(Integer registerId) {
        this.registerId = registerId;
    }

    public List<RequisitionDetailFormDTO> getDetails() {
        return details;
    }

    public void setDetails(
            List<RequisitionDetailFormDTO> details) {

        this.details = details;
    }
}