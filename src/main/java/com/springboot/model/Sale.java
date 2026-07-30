package com.springboot.model;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.*;

@Entity
@Table(name = "sale")
public class Sale {
	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    @Column(length = 10)
	    private int saleId;

	    @Column(nullable = false)
	    private java.time.LocalDate saleDate;

	    @Column(precision = 10, scale = 2, nullable = false)
	    private BigDecimal  salePrice;

	    @Column(precision = 10, scale = 2, nullable = false)
	    private BigDecimal  qty;

	    @Column(precision = 10, scale = 2, nullable = false)
	    private BigDecimal  revenue;

	    @OneToOne
	    @JoinColumn(name = "cycle_id")
	    private CropCycle cycle;
	    
	    public Sale() {}
		public Sale(int saleId, LocalDate saleDate, BigDecimal  salePrice, BigDecimal  qty, BigDecimal  revenue, CropCycle cycle) {
			super();
			this.saleId = saleId;
			this.saleDate = saleDate;
			this.salePrice = salePrice;
			this.qty = qty;
			this.revenue = revenue;
			this.cycle = cycle;
		}

		public int getSaleId() {
			return saleId;
		}

		public void setSaleId(int saleId) {
			this.saleId = saleId;
		}

		public java.time.LocalDate getSaleDate() {
			return saleDate;
		}

		public void setSaleDate(java.time.LocalDate saleDate) {
			this.saleDate = saleDate;
		}

		public BigDecimal  getSalePrice() {
			return salePrice;
		}

		public void setSalePrice(BigDecimal  salePrice) {
			this.salePrice = salePrice;
		}

		public BigDecimal  getQty() {
			return qty;
		}

		public void setQty(BigDecimal  qty) {
			this.qty = qty;
		}

		public BigDecimal  getRevenue() {
			return revenue;
		}

		public void setRevenue(BigDecimal  revenue) {
			this.revenue = revenue;
		}

		public CropCycle getCycle() {
			return cycle;
		}

		public void setCycle(CropCycle cycle) {
			this.cycle = cycle;
		}
	    
	    
}
