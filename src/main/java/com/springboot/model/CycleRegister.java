package com.springboot.model;

import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "cycle_register")
public class CycleRegister {
	
	
	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    @Column(length = 10)
	    private int registerId;
	    
	    @Column(nullable = true)
	    private LocalDate approvedDate;

	    @Column(nullable = true)
	    private LocalDate scheduledPlantDate;

	    @Column(nullable = true)
	    private LocalDate scheduledHarvestDate;
	    
	    
	    @Column(nullable =  false)
	    private java.time.LocalDate registerDate;

	    @Column(length = 20, nullable =  false)
	    private String regStatus;

	    @ManyToOne
	    @JoinColumn(name = "cycle_id",nullable = false)
	    private CropCycle cycle;
	    

	    @OneToMany(mappedBy = "cycle")
	    private List<PurchaseOrder> purchases;

	    @ManyToMany(mappedBy = "cycleRegisters")
	    private List<Farmland> farmlands;
	    
	public CycleRegister() {}
	public CycleRegister(int registerId, LocalDate registerDate, String regStatus, CropCycle cycle,
			List<PurchaseOrder> purchases, List<Farmland> farmlands) {
		super();
		this.registerId = registerId;
		this.registerDate = registerDate;
		this.regStatus = regStatus;
		this.cycle = cycle;
		this.purchases = purchases;
		this.farmlands = farmlands;
	}

	public int getRegisterId() {
		return registerId;
	}
	public void setRegisterId(int registerId) {
		this.registerId = registerId;
	}
	public java.time.LocalDate getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(java.time.LocalDate registerDate) {
		this.registerDate = registerDate;
	}
	public String getRegStatus() {
		return regStatus;
	}
	public void setRegStatus(String regStatus) {
		this.regStatus = regStatus;
	}
	public CropCycle getCycle() {
		return cycle;
	}
	public void setCycle(CropCycle cycle) {
		this.cycle = cycle;
	}
	public List<PurchaseOrder> getPurchases() {
		return purchases;
	}
	public void setPurchases(List<PurchaseOrder> purchases) {
		this.purchases = purchases;
	}
	public List<Farmland> getFarmlands() {
		return farmlands;
	}
	public void setFarmlands(List<Farmland> farmlands) {
		this.farmlands = farmlands;
	}
	public LocalDate getApprovedDate() {
		return approvedDate;
	}
	public void setApprovedDate(LocalDate approvedDate) {
		this.approvedDate = approvedDate;
	}
	public LocalDate getScheduledPlantDate() {
		return scheduledPlantDate;
	}
	public void setScheduledPlantDate(LocalDate scheduledPlantDate) {
		this.scheduledPlantDate = scheduledPlantDate;
	}
	public LocalDate getScheduledHarvestDate() {
		return scheduledHarvestDate;
	}
	public void setScheduledHarvestDate(LocalDate scheduledHarvestDate) {
		this.scheduledHarvestDate = scheduledHarvestDate;
	}
	
	
	
	

}
