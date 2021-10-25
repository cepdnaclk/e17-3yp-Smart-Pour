package com.smartPourdatabase;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data

public class User {
	@Id
	@GeneratedValue
	Integer user_id;
	String email;
	String password;
	
	public User() {
		
	}

	public User(Integer user_id, String email, String password) {
		super();
		this.user_id = user_id;
		this.email = email;
		this.password = password;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
