package com.board.mobile.contoller;
import org.springframework.beans.factory.annotation.Autowired;   
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.board.users.dto.UsersDto;
import com.board.users.service.MapService;

import java.util.List;

@RestController
public class MobileMapApiController {

    @Autowired
    private MapService  mapService;

    @GetMapping("/getPopupsInBounds")
    public List<UsersDto> getPopupsInBounds(
            @RequestParam double north, 
            @RequestParam double east,
            @RequestParam double south, 
            @RequestParam double west) {
        
        // 경계 값에 맞는 팝업 리스트를 조회
        return mapService.getPopupsInBounds(north, east, south, west);
    }
}
