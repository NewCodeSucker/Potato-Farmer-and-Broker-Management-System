package com.springboot.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "item_requisition")
public class ItemRequisition {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(length = 10)
    private int requisitionId;

    public String getBrokerRemark() {
		return brokerRemark;
	}

	public void setBrokerRemark(String brokerRemark) {
		this.brokerRemark = brokerRemark;
	}

	public String getRequisitionType() {
		return requisitionType;
	}

	public void setRequisitionType(String requisitionType) {
		this.requisitionType = requisitionType;
	}

	@Column(length = 20, nullable = false)
    private String status;

    @Column(nullable = false)
    private LocalDate submitDate;
    
    @Column(length = 500)
    private String brokerRemark;
    
    @Column(length = 30)
    private String requisitionType;
    
    @ManyToOne
    @JoinColumn(name = "register_id", nullable = false)
    private CycleRegister cycle;

    @OneToMany(
        mappedBy = "itemRequisition",
        cascade = CascadeType.ALL,
        orphanRemoval = true,
        fetch = FetchType.LAZY
    )
    private List<ItemRequisitionDetail> details = new ArrayList<>();

    public ItemRequisition() {
    }

    public ItemRequisition(
            int requisitionId,
            String status,
            LocalDate submitDate,
            CycleRegister cycle) {

        this.requisitionId = requisitionId;
        this.status = status;
        this.submitDate = submitDate;
        this.cycle = cycle;
    }

    public int getRequisitionId() {
        return requisitionId;
    }

    public void setRequisitionId(int requisitionId) {
        this.requisitionId = requisitionId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getSubmitDate() {
        return submitDate;
    }

    public void setSubmitDate(LocalDate submitDate) {
        this.submitDate = submitDate;
    }

    public CycleRegister getCycle() {
        return cycle;
    }

    public void setCycle(CycleRegister cycle) {
        this.cycle = cycle;
    }

    public List<ItemRequisitionDetail> getDetails() {
        return details;
    }

    public void setDetails(List<ItemRequisitionDetail> details) {
        this.details = details;
    }

    public void addDetail(ItemRequisitionDetail detail) {
        details.add(detail);
        detail.setItemRequisition(this);
    }

    public void removeDetail(ItemRequisitionDetail detail) {
        details.remove(detail);
        detail.setItemRequisition(null);
    }
}