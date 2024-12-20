package com.board.users.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Review")
public class ReviewController {
	
	// http://localhost:9090
	@RequestMapping("/WriteForm")
	public  String   write() {
		return "users/popup/writeform";
		//return "/WEB-INF/views/home.jsp";
	}
	// http://localhost:9090
	@RequestMapping("/Update")
	public  String   update() {
		return "business/management/request";
		//return "/WEB-INF/views/home.jsp";
	}

	
}
