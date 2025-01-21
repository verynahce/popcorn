package com.board.admin.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.board.business.dto.CategoryDto;
import com.board.business.dto.ImageStoreDTO;
import com.board.business.dto.ResponseDto;
import com.board.business.dto.StoreTagDto;
import com.board.business.dto.StoreUpdateDto;
import com.board.business.service.BusinessService;
import com.board.business.service.PdsService;
import com.board.users.dto.User;
import com.board.users.service.UserService;
import com.board.util.JwtUtil;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;



@Controller
@RequestMapping("/Admin")
public class AdminStoreController {
    
	// 1./Store/View - store_idx 연결   
	
	@Autowired
	private  BusinessService businessService;
    
	@Autowired
	private PdsService pdsService;
	
	@Autowired
	private JwtUtil jwtUtil;
	
	@Autowired
	private UserService userService;
	
    private Optional<User> getJwtTokenFromCookies(HttpServletRequest request, Model model) {
        // 유저 번호 가지고 오기
        Cookie[] cookies = request.getCookies();
           String jwtToken = null;

           if (cookies != null) {
               for (int i = cookies.length - 1; i >= 0; i--) {
                   Cookie cookie = cookies[i];
                   if ("adminjwt".equals(cookie.getName())) {
                       jwtToken = cookie.getValue();
                       System.out.println("토큰1 : " +jwtToken );
                       break; 
                   }
               }
           }
           
           Optional<User> user= null;

           if (jwtToken != null) {
               String username = jwtUtil.extractUsername(jwtToken);
               System.out.println("사용자 정보1: " + username);

                   // 일반 사용자라면 기존 방식으로 사용자 조회
                   user = userService.getUserByUsername(username);  // DB에서 사용자 정보 조회
                   System.out.println("사용자 정보: " + user);
                   model.addAttribute("user", user.orElse(null));  // 사용자가 없을 경우 null 반환
               } else {
               model.addAttribute("error", "JWT 토큰이 없습니다.");
           }
           return user;
     }
	
	@RequestMapping("/Store/View")
	 public ModelAndView StoreView(@RequestParam("store_idx") int store_idx ,Model model,HttpServletRequest request) {		
	
        Optional<User> user=null;
        user = getJwtTokenFromCookies(request, model);
        model.addAttribute("user", user.orElse(null));
        
		StoreUpdateDto suDto = businessService.getStoreUpdateinfo(store_idx);	
	    List<StoreTagDto> stList = businessService.getStoreTag(store_idx);
	    List <CategoryDto> scList = businessService.getStoreCategory(store_idx);
	    List<ImageStoreDTO> isList= pdsService.getImageStorList(store_idx);
	    List<ResponseDto> rqList = businessService.getRequestList(store_idx);
	    
	    for (ImageStoreDTO image : isList) {
	    String imagePath = image.getImage_path().replace("\\", "/");
	    image.setImage_path(imagePath);
		}
	     
	    
	    System.out.println("store 확인"+suDto);
	    
		ModelAndView mv = new ModelAndView();
		mv.addObject("store",suDto);
	    mv.addObject("tagList", stList);	
	    mv.addObject("categoryList", scList);	
	    mv.addObject("imageList", isList);	
	    mv.addObject("requestList", rqList);	
		mv.setViewName("admin/store/view");
	 return mv;
	}
	
	@RequestMapping("/Store/UpdateForm")
	 public ModelAndView StoreUpdate(int store_idx,Model model,HttpServletRequest request) {
		
        Optional<User> user=null;
        user = getJwtTokenFromCookies(request, model);
        model.addAttribute("user", user.orElse(null));
		
		StoreUpdateDto suDto = businessService.getStoreUpdateinfo(store_idx);	
	    List<StoreTagDto> stList = businessService.getStoreTag(store_idx);
	    List <CategoryDto> scList = businessService.getStoreCategory(store_idx);
	    List<ImageStoreDTO> isList= pdsService.getImageStorList(store_idx);
	    List <CategoryDto> cList = businessService.getCategoryList();

		ModelAndView mv = new ModelAndView();
		mv.addObject("store",suDto);
	    mv.addObject("tagList", stList);	
	    mv.addObject("categoryList", scList);	
	    mv.addObject("imageList", isList);
	    mv.addObject("cList", cList);
		mv.setViewName("admin/store/update");
		 return mv;
		 
	}
	
	@RequestMapping("/Store/Update")
	public ModelAndView StoreUpdate(@RequestParam HashMap<String, Object> map,
									            @RequestParam (value="tag_name", 
									            required = false) String[] tag_name,
		                                        @RequestParam (value="category_id", 
				                                required = false) String[] category_id,
									            @RequestParam(value="upfile",required = false) MultipartFile[] uploadfiles) {	
	
	int store_idx = Integer.valueOf(map.get("store_idx").toString());
	ModelAndView mv = new ModelAndView();
	businessService.updateAdminStore(map,tag_name,category_id);
	pdsService.setUpdate(map, uploadfiles);
	
	System.out.println("!!!!map 확인중 "+map);
	System.out.println("!!!!store_idx 확인중 "+store_idx);
	int company_idx = Integer.valueOf(map.get("company_idx").toString());
	 mv.setViewName("redirect:/Admin/Store/View?store_idx="+store_idx);
	return mv;	
		
	}

}
