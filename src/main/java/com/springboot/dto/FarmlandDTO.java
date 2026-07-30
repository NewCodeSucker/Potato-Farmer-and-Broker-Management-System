package com.springboot.dto;

import java.math.BigDecimal;

public class FarmlandDTO {
	    private String titleDeedNo;
	    private String location;

	    private BigDecimal rai;
	    private BigDecimal ngan;
	    private BigDecimal squreWah;
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
		public BigDecimal getRai() {
			return rai;
		}
		public void setRai(BigDecimal rai) {
			this.rai = rai;
		}
		public BigDecimal getNgan() {
			return ngan;
		}
		public void setNgan(BigDecimal ngan) {
			this.ngan = ngan;
		}
		public BigDecimal getSqureWah() {
			return squreWah;
		}
		public void setSqureWah(BigDecimal squreWah) {
			this.squreWah = squreWah;
		}
	    
	    
}
