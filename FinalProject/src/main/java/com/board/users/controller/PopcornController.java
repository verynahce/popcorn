package com.board.users.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.users.mapper.PopcornMapper;
import com.board.users.vo.PopcornVo;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/Wallet")
public class PopcornController {

	@Autowired
	private PopcornMapper popcornMapper;
	
	
	@RequestMapping("/Wallet")
	public String wallet(Model model) {
		
		String userId = "TEST";
		
	    List<PopcornVo> loglist = popcornMapper.getLogByUserId(userId);
	    PopcornVo Popcorn       = popcornMapper.checkWallet(userId);
	    PopcornVo attendinfo    = popcornMapper.getCheckAttend(userId);
	    System.out.println("attendstat:"+attendinfo);
	    
	    
	     // 하루 마다 초기화 
		 LocalDate today = LocalDate.now();
		 if ("ON".equals(attendinfo.getAttendance_Status())) { 
			  String lastAttendDateStr    =  attendinfo.getAttendance_Date(); 
              DateTimeFormatter formatter =  DateTimeFormatter.ofPattern("yyyy-MM-dd"); 
              LocalDate lastAttendDate    =  LocalDate.parse(lastAttendDateStr, formatter);
			  
             //본코드
			  if (lastAttendDate != null && lastAttendDate.equals(today.minusDays(1))) {
			       popcornMapper.updateAttendanceStatus(userId); } }
			 
              
				/*
				  // 테스트용 날짜 하루 늘리기 
				 LocalDate incrementedAttendDate =
				 lastAttendDate.plusDays(1);
				  
				  (incrementedAttendDate.equals(today)) {
				 
				  } else { 
				  popcornMapper.updateAttendanceStatus(userId);
				   }
				 }
				 */
          
	    System.out.println("담긴거:"+loglist);
	    List<Integer> points = Arrays.asList(20, 30, 40, 50, 60, 70, 100);
	    model.addAttribute("points", points); 
	    model.addAttribute("Popcorn", Popcorn); 
	    model.addAttribute("Loglist", loglist);
	    model.addAttribute("attendstat", attendinfo);
	    return "users/usersWallet/wallet"; 
	}
		
	
	   // 출첵
    @PostMapping("/Daily-check")
    @ResponseBody
    public String handleDailyCheck(String userID,
    		                       @RequestParam("earnedPoints") int earnedPoints,
    		                       HttpSession session) {
    	String userId = "TEST";
    	PopcornVo attendinfo = popcornMapper.getCheckAttend(userId);
        String alreadyCheckedIn = attendinfo.getAttendance_Status();
        
        
        if ("ON".equals(alreadyCheckedIn)) {
        	System.out.println("중복출석방지확인");
            return "이미 오늘 출석했습니다."; 
        } else {
            boolean successAttend = popcornMapper.AttendToUser(userId);
            boolean successEarned = popcornMapper.addPointsToUser(userId,earnedPoints);
            boolean successAddLog = popcornMapper.addPopcornLog(userId,earnedPoints);
        
            if (successAttend && successEarned && successAddLog) {
                System.out.println("출첵 되고 포인트주고 로그까지:" + earnedPoints);
                return "출석 체크가 완료되었습니다!";
            } else {
                System.out.println(" 실패 ");
                return "실패임";
            }
        }
    }

}