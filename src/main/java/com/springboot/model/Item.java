package com.springboot.model;

import java.math.BigDecimal;

import jakarta.persistence.*;
@Entity
@Table(name = "item")
public class Item {
		@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    @Column(length = 10)
	    private int itemId;

	    @Column(length = 50 ,nullable = false)
	    private String itemName;

	    @Column(length = 20 ,nullable = false)
	    private String itemType;

	    @Column(length = 50 ,nullable = false)
	    private String unit;

	    @Column(precision = 10, scale = 2, nullable = false)
	    private BigDecimal  unitPrice;

		public int getItemId() {
			return itemId;
		}

		public void setItemId(int itemId) {
			this.itemId = itemId;
		}

		public String getItemName() {
			return itemName;
		}

		public void setItemName(String itemName) {
			this.itemName = itemName;
		}

		public String getItemType() {
			return itemType;
		}

		public void setItemType(String itemType) {
			this.itemType = itemType;
		}

		public String getUnit() {
			return unit;
		}

		public void setUnit(String unit) {
			this.unit = unit;
		}

		public BigDecimal  getUnitPrice() {
			return unitPrice;
		}

		public void setUnitPrice(BigDecimal  unitPrice) {
			this.unitPrice = unitPrice;
		}

		public Item(int itemId, String itemName, String itemType, String unit, BigDecimal  unitPrice) {
			super();
			this.itemId = itemId;
			this.itemName = itemName;
			this.itemType = itemType;
			this.unit = unit;
			this.unitPrice = unitPrice;
		}
	    public Item() {}
	    
	    
}
