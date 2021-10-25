package com.smartPourdatabase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

	@Autowired
	private UserRepository userRepository;
	
	@PostMapping ("/signup")
	public User Signup(@RequestBody User user) {
		return userRepository.save(user);
	}
	
	@PostMapping ("/login")
	public User Login (@RequestBody User user) {
		User oldUser=userRepository.findByEmailAndPassword(user.email, user.password);
		return oldUser;
	}
	
}
