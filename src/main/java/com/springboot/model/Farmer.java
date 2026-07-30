package com.springboot.model;

import jakarta.persistence.*;


@Entity
@Table(name = "farmer")
public class Farmer {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(length = 10)
	private int farmerId;
	
	@Column(length = 50, nullable = false , unique = true)
	private String userName;
	
	@Column(length = 100, nullable = false)
	private String firstname;
	
	@Column(length = 100, nullable = false)
	private String lastname;
	
	@Column(length = 255, nullable = false)
	private String address;
	
	@Column(length = 10, nullable = false)
	private String phoneNumber;
	
	@Column(length = 50, nullable = false)
	private String password;
	
	@Column(length = 255)
	private String profileImagePath;
	
	@Column(nullable = false)
	private boolean onboardingCompleted = false;



	
	public Farmer(){}
	public Farmer( String userName, String firstname, String lastname, String address, String phoneNumber,
			String password) {
		this.userName = userName;
		this.firstname = firstname;
		this.lastname = lastname;
		this.address = address;
		this.phoneNumber = phoneNumber;
		this.password = password;
	}

	public int getFarmerId() {
		return farmerId;
	}

	public void setFarmerId(int farmerId) {
		this.farmerId = farmerId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getProfileImagePath() {
	    return profileImagePath;
	}

	public void setProfileImagePath(String profileImagePath) {
	    this.profileImagePath = profileImagePath;
	}
	
	public boolean isOnboardingCompleted() {
	    return onboardingCompleted;
	}

	public void setOnboardingCompleted(boolean onboardingCompleted) {
	    this.onboardingCompleted = onboardingCompleted;
	}
}
