package com.springboot.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;

import jakarta.persistence.*;

@Entity
@Table(name = "purchase_order")
public class PurchaseOrder {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(length = 10)
    private int purchaseId;

    @Column(nullable = false)
    private LocalDate purchaseDate;

    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal  quantity;

    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal  totalprice;

    @ManyToOne
    @JoinColumn(name = "register_id")
    private CycleRegister cycle;

    
    public PurchaseOrder() {}
	public PurchaseOrder(int purchaseId, LocalDate purchaseDate, BigDecimal  quantity, BigDecimal  totalprice, CycleRegister cycle) {
		super();
		this.purchaseId = purchaseId;
		this.purchaseDate = purchaseDate;
		this.quantity = quantity;
		this.totalprice = totalprice;
		this.cycle = cycle;
	}

	public int getPurchaseId() {
		return purchaseId;
	}

	public void setPurchaseId(int purchaseId) {
		this.purchaseId = purchaseId;
	}

	public LocalDate getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(LocalDate purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public BigDecimal  getQuantity() {
		return quantity;
	}

	public void setQuantity(BigDecimal  quantity) {
		this.quantity = quantity;
	}

	public BigDecimal  getTotalPrice() {
		return totalprice;
	}

	public void setTotalprice(BigDecimal  totalpirce) {
		this.totalprice = totalpirce;
	}

	public CycleRegister getCycle() {
		return cycle;
	}

	public void setCycle(CycleRegister cycle) {
		this.cycle = cycle;
	}
    
    
}
