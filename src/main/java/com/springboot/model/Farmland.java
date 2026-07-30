package com.springboot.model;

import java.math.BigDecimal;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "farmland")
public class Farmland {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(length = 10)
	private int landId; 	
	
	@Column(length = 50,  nullable = false)
	private String titleDeedNo;
	
	@Column(length = 255, nullable = false)
	private String location;
	
	public List<CycleRegister> getCycleRegisters() {
		return cycleRegisters;
	}
	public void setCycleRegisters(List<CycleRegister> cycleRegisters) {
		this.cycleRegisters = cycleRegisters;
	}

	@Column(precision = 6, scale = 2, nullable = false)
	private BigDecimal  rai;
	
	@Column(precision = 4, scale = 2, nullable = false)
	private BigDecimal ngan;
	
	@Column(precision = 6, scale = 2, nullable = false)
	private BigDecimal   squreWah;
	
	@Column(length = 255, nullable = false)
	private String titleDeedImagePath;
	
	@Column(length = 255)
	private String titleDeedBackImagePath;


	@ManyToOne
	@JoinColumn(name = "farmer_id", nullable = false)
    private Farmer farmer;
	
	@ManyToMany
	@JoinTable(
	    name = "farmland_cycle_register",
	    joinColumns = @JoinColumn(name = "land_id"),
	    inverseJoinColumns = @JoinColumn(name = "register_id")
	)
	private List<CycleRegister> cycleRegisters;
	
	public Farmland() {}
	public Farmland(int landId, String titleDeedNo, String location, BigDecimal rai, BigDecimal ngan, BigDecimal squreWah,
			String titleDeedImagePath, Farmer farmer) {
		super();
		this.landId = landId;
		this.titleDeedNo = titleDeedNo;
		this.location = location;
		this.rai = rai;
		this.ngan = ngan;
		this.squreWah = squreWah;
		this.titleDeedImagePath = titleDeedImagePath;
		this.farmer = farmer;
	}

	public int getLandId() {
		return landId;
	}

	public void setLandId(int landId) {
		this.landId = landId;
	}

	public String getTitleDeedNo() {
		return titleDeedNo;
	}

	public void setTitleDeedNo(String titleDeedNo) {
		this.titleDeedNo = titleDeedNo;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public BigDecimal  getRai() {
		return rai;
	}

	public void setRai(BigDecimal  rai) {
		this.rai = rai;
	}

	public BigDecimal getNgan() {
		return ngan;
	}

	public void setNgan(BigDecimal ngan) {
		this.ngan = ngan;
	}

	public BigDecimal  getSqureWah() {
		return squreWah;
	}

	public void setSqureWah(BigDecimal squreWah) {
		this.squreWah = squreWah;
	}

	public String getTitleDeedImagePath() {
		return titleDeedImagePath;
	}

	public void setTitleDeedImagePath(String titleDeedImagePath) {
		this.titleDeedImagePath = titleDeedImagePath;
	}

	public Farmer getFarmer() {
		return farmer;
	}

	public void setFarmer(Farmer farmer) {
		this.farmer = farmer;
	}
	
	public String getTitleDeedBackImagePath() {
	    return titleDeedBackImagePath;
	}

	public void setTitleDeedBackImagePath(String titleDeedBackImagePath) {
	    this.titleDeedBackImagePath = titleDeedBackImagePath;
	}
	
	

}
