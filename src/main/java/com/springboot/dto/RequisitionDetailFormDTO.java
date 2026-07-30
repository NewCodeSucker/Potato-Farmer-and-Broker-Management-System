package com.springboot.dto;

public class RequisitionDetailFormDTO {

    private Integer itemId;
    private Integer qty;
    private String cause;

    public RequisitionDetailFormDTO() {
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Integer getQty() {
        return qty;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public String getCause() {
        return cause;
    }

    public void setCause(String cause) {
        this.cause = cause;
    }
}