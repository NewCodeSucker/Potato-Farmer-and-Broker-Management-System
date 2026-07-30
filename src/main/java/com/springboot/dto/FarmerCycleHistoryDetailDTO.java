package com.springboot.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.springboot.model.CycleRegister;
import com.springboot.model.ItemRequisition;
import com.springboot.model.PurchaseOrder;

public class FarmerCycleHistoryDetailDTO {

    private CycleRegister register;

    private List<PurchaseOrder> purchases =
            new ArrayList<>();

    private List<ItemRequisition> requisitions =
            new ArrayList<>();

    private BigDecimal totalQuantity =
            BigDecimal.ZERO;

    private BigDecimal totalRevenue =
            BigDecimal.ZERO;

    private BigDecimal totalCost =
            BigDecimal.ZERO;

    private BigDecimal netIncome =
            BigDecimal.ZERO;

    public FarmerCycleHistoryDetailDTO() {
    }

    public CycleRegister getRegister() {
        return register;
    }

    public void setRegister(CycleRegister register) {
        this.register = register;
    }

    public List<PurchaseOrder> getPurchases() {
        return purchases;
    }

    public void setPurchases(
            List<PurchaseOrder> purchases) {

        this.purchases = purchases;
    }

    public List<ItemRequisition> getRequisitions() {
        return requisitions;
    }

    public void setRequisitions(
            List<ItemRequisition> requisitions) {

        this.requisitions = requisitions;
    }

    public BigDecimal getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(
            BigDecimal totalQuantity) {

        this.totalQuantity = totalQuantity;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(
            BigDecimal totalRevenue) {

        this.totalRevenue = totalRevenue;
    }

    public BigDecimal getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(
            BigDecimal totalCost) {

        this.totalCost = totalCost;
    }

    public BigDecimal getNetIncome() {
        return netIncome;
    }

    public void setNetIncome(
            BigDecimal netIncome) {

        this.netIncome = netIncome;
    }
}