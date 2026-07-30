package com.springboot.model;

import java.math.BigDecimal;

import jakarta.persistence.*;

@Entity
@Table(name = "item_requisition_detail")
public class ItemRequisitionDetail {
	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    @Column(length = 10)
	    private int requisitionDetailId;

	    @Column(length = 255, nullable = false)
	    private String cause;

	    @Column(nullable = false)
	    private int qty;

	    @Column(precision = 10, scale = 2, nullable = false)
	    private BigDecimal unitPrice;

	    @ManyToOne
	    @JoinColumn(name = "requisition_id")
	    private ItemRequisition itemRequisition;

	    @ManyToOne
	    @JoinColumn(name = "item_id")
	    private Item item;

		public int getRequisitionDetailId() {
			return requisitionDetailId;
		}

		public void setRequisitionDetailId(int requisitionDetailId) {
			this.requisitionDetailId = requisitionDetailId;
		}

		public String getCause() {
			return cause;
		}

		public void setCause(String cause) {
			this.cause = cause;
		}

		public int getQty() {
			return qty;
		}

		public void setQty(int qty) {
			this.qty = qty;
		}

		public BigDecimal getUnitPrice() {
			return unitPrice;
		}

		public void setUnitPrice(BigDecimal unitPrice) {
			this.unitPrice = unitPrice;
		}

		public ItemRequisition getItemRequisition() {
			return itemRequisition;
		}

		public void setItemRequisition(ItemRequisition itemRequisition) {
			this.itemRequisition = itemRequisition;
		}

		public Item getItem() {
			return item;
		}

		public void setItem(Item item) {
			this.item = item;
		}
		
		public ItemRequisitionDetail() {}
		public ItemRequisitionDetail(int requisitionDetailId, String cause, int qty, BigDecimal unitPrice,
				ItemRequisition itemRequisition, Item item) {
			super();
			this.requisitionDetailId = requisitionDetailId;
			this.cause = cause;
			this.qty = qty;
			this.unitPrice = unitPrice;
			this.itemRequisition = itemRequisition;
			this.item = item;
		}
	    
		@Transient
		public BigDecimal getTotalPrice() {

		    if (unitPrice == null) {
		        return BigDecimal.ZERO;
		    }

		    return unitPrice.multiply(BigDecimal.valueOf(qty));
		}
	    
}
