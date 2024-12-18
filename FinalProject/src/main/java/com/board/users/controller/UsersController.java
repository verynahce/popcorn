package com.board.users.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/Users")
public class UsersController {
	
	// http://localhost:9090
	@RequestMapping("/Wallet")
	public  String  wallet() {
		return "users/usersWallet/wallet";
		//return "/WEB-INF/views/users/Wallet/wallet.jsp";
	}
	
	@RequestMapping("/RouteRecommend")
	public  String   routeRecommend() {
		return "users/usersWallet/routeRecommend";
		//return "/WEB-INF/views/home.jsp";
	}
	
	
	@RequestMapping("/Main")
	public String main() {
		return "users/usersMain/main";
	}
	
	@RequestMapping("/Rankdetail")
	public String rankdetail() {
		return "users/usersMain/rankdetail";
	}
	@RequestMapping("/Opendetail")
	public String opentail() {
		return "users/usersMain/opendetail";
	}
	@RequestMapping("/Ongoing")
	public String ongoing() {
		return "users/usersMain/ongoing";
	}
}