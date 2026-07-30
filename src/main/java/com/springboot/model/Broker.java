	package com.springboot.model;

import jakarta.persistence.*;
@Entity
@Table(name="broker")
public class Broker {
	    @Id
	    @Column(length = 10)
	    private String brokerId;
	    
	    @Column(length = 50, nullable = false, unique = true)
	    private String userName;

	    @Column(length = 50, nullable = false)
	    private String firstname;

	    @Column(length = 50, nullable = false)
	    private String lastname;

	    @Column(length = 100, nullable = false)
	    private String password;

	    @Column(length = 10, nullable = false)
	    private String phoneNumber;

	    @Column(length = 100, nullable = false)
	    private String email;

	    @Column(length = 255, nullable = false)
	    private String address;


		public Broker() {}
		public Broker(String brokerId, String userName, String firstname, String lastname, String password,
				String phoneNumber, String email, String address) {
			super();
			this.brokerId = brokerId;
			this.userName = userName;
			this.firstname = firstname;
			this.lastname = lastname;
			this.password = password;
			this.phoneNumber = phoneNumber;
			this.email = email;
			this.address = address;
		}
		
		public String getBrokerId() {
			return brokerId;
		}

		public void setBrokerId(String brokerId) {
			this.brokerId = brokerId;
		}

		public String getFirstname() {
			return firstname;
		}

		public void setFirstname(String firstname) {
			this.firstname = firstname;
		}

		public String getLastname() {
			return lastname;
		}

		public void setLastname(String lastname) {
			this.lastname = lastname;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public String getPhoneNumber() {
			return phoneNumber;
		}

		public void setPhoneNumber(String phoneNumber) {
			this.phoneNumber = phoneNumber;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getAddress() {
			return address;
		}

		public void setAddress(String address) {
			this.address = address;
		}
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
		}

	    
		
	    
}
