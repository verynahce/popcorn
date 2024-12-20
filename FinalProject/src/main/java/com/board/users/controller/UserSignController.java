package com.board.users.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.board.users.dto.User;
import com.board.users.service.UserService;

@Controller
@RequestMapping("/Users")
public class UserSignController {

    @Autowired
    private UserService userService;
    
	@RequestMapping("/LoginForm")
	public  String   loginform() {
		return "login";
	}

    @GetMapping("/SignupForm")
    public String signupForm() {
        return "signup"; // 회원가입 폼 JSP 페이지로 이동
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, "birthdate", new CustomDateEditor(dateFormat, true));
    }
    @PostMapping("/Signup")
    public String registerUser(@ModelAttribute User user) {
        userService.registerUser(user);
        return "redirect:/Users/LoginForm";
    }

    @GetMapping("/Login/{id}")
    public User getUser(@PathVariable String id) {
        return userService.findByUserId(id)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));
    }
}

