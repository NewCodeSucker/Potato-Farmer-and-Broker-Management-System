package com.springboot.model;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.*;

@Entity
@Table(name = "crop_cycle")
public class CropCycle {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(length = 10)
	private int cyleId;
	
	@Column(length = 50, nullable = false)
	private String cycleName;
	
	@Column(precision = 10, scale = 2, nullable = false)
	private BigDecimal  purchasePrice;
	
    @Column(nullable = false)
	private LocalDate openRegDate;

    @Column(nullable = false)
	private LocalDate endRegDate;
    
    @Column(nullable = false)
	private LocalDate plantDate;
    
    @Column(nullable = false)
	private LocalDate harvestDate;
    
	private LocalDate endHarvestDate;
    
    @Column(nullable = false)
	private int maxpeople;
    
    @Column(length = 20,nullable = false)
	private String status;
    
    @Column(length = 20,nullable = false)
	private String potatoType;
    
    @OneToOne(mappedBy = "cycle")
    private Sale sales;
    
	public CropCycle() {}
	public CropCycle(int cyleId, String cycleName, BigDecimal purchasePrice, LocalDate openRegDate, LocalDate endRegDate, LocalDate plantDate,
			LocalDate harvestDate, LocalDate endHarvestDate, int maxpeople, String status, String potatoType) {
		super();
		this.cyleId = cyleId;
		this.cycleName = cycleName;
		this.purchasePrice = purchasePrice;
		this.openRegDate = openRegDate;
		this.endRegDate = endRegDate;
		this.plantDate = plantDate;
		this.harvestDate = harvestDate;
		this.endHarvestDate = endHarvestDate;
		this.maxpeople = maxpeople;
		this.status = status;
		this.potatoType = potatoType;
	}
	public int getCyleId() {
		return cyleId;
	}
	public void setCyleId(int cyleId) {
		this.cyleId = cyleId;
	}
	public String getCycleName() {
		return cycleName;
	}
	public void setCycleName(String cycleName) {
		this.cycleName = cycleName;
	}
	public BigDecimal getPurchasePrice() {
		return purchasePrice;
	}
	public void setPurchasePrice(BigDecimal purchasePrice) {
		this.purchasePrice = purchasePrice;
	}
	public LocalDate getOpenRegDate() {
		return openRegDate;
	}
	public void setOpenRegDate(LocalDate openRegDate) {
		this.openRegDate = openRegDate;
	}
	public LocalDate getEndRegDate() {
		return endRegDate;
	}
	public void setEndRegDate(LocalDate endRegDate) {
		this.endRegDate = endRegDate;
	}
	public LocalDate getPlantDate() {
		return plantDate;
	}
	public void setPlantDate(LocalDate plantDate) {
		this.plantDate = plantDate;
	}
	public LocalDate getHarvestDate() {
		return harvestDate;
	}
	public void setHarvestDate(LocalDate harvestDate) {
		this.harvestDate = harvestDate;
	}
	public LocalDate getEndHarvestDate() {
		return endHarvestDate;
	}
	public void setEndHarvestDate(LocalDate endHarvestDate) {
		this.endHarvestDate = endHarvestDate;
	}
	public int getMaxpeople() {
		return maxpeople;
	}
	public void setMaxpeople(int maxpeople) {
		this.maxpeople = maxpeople;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPotatoType() {
		return potatoType;
	}
	public void setPotatoType(String potatoType) {
		this.potatoType = potatoType;
	}
	
	

}
