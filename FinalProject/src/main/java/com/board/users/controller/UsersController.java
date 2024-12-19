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
	public ModelAndView main() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("users/usersMain/main");
		return mv;
	}
	
	@RequestMapping("/Rankdetail")
	public ModelAndView rankdetail() {
	  ModelAndView mv = new ModelAndView();
	  mv.setViewName("users/usersMain/rankdetail");
	  return mv;
	}
	@RequestMapping("/Opendetail")
	public ModelAndView opendetail() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("users/usersMain/opendetail");
		return mv;
	}
	@RequestMapping("/Ongoingdetail")
	public ModelAndView ongoingdetail() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("users/usersMain/ongoingdatail");
		return mv;
	}
	
	@RequestMapping("/Mainsearch")
	public ModelAndView mainsearch() {
		ModelAndView mv = new ModelAndView();		
		mv.setViewName("users/usersMain/mainsearch");
		return mv;
	}
	
}