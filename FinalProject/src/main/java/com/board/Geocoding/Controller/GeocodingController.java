package com.board.Geocoding.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class GeocodingController {

    private  String clientId = "";  // 네이버 클라이언트ID
    private  String clientSecret = "";  // 네이버 클라이언트Secret 

    
    @RequestMapping("/GetCoordinates")
    public String getCoordinates(@RequestParam("address") List<String> addresses, Model model) {
     
    	System.out.println("받아온 주소 리스트:"); // 선택한 주소 목록 출력 주석처리
        addresses.forEach(System.out::println);    // 선택한 주소 목록 출력 주석처리

        List<Map<String, String>> locations = new ArrayList<>();

        for (String address : addresses) {
            String[] location = getLocation(address); // 각 주소에 대해 위치 정보 조회

            if (location != null) {
                Map<String, String> locationMap = new HashMap<>();
                locationMap.put("address", address);
                locationMap.put("lat", location[0]);
                locationMap.put("lon", location[1]);
                locations.add(locationMap); // 유효한 위치 정보 저장
            } else {
                Map<String, String> errorMap = new HashMap<>();
                errorMap.put("address", address);
                errorMap.put("error", "위치 정보를 찾을 수 없습니다.");
                locations.add(errorMap); // 오류 정보 저장
            }
        }

        // JSP로 위치 정보 전달
        model.addAttribute("locations", locations);

        return "users/usersWallet/getCoordinates"; // 결과를 JSP로 전달
    }

    public String[] getLocation(String address) {
        String apiUrl = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=" + address;

        System.out.println("geocode작동완료:"+apiUrl); // api 작동 확인용 주석처리

        // RestTemplate을 사용하여 API 호출
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.add("X-NCP-APIGW-API-KEY-ID", clientId); // 클라이언트 ID 설정
        headers.add("X-NCP-APIGW-API-KEY", clientSecret); // 클라이언트 Secret 설정

        HttpEntity<String> entity = new HttpEntity<>(headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);
            String responseBody = response.getBody();

            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(responseBody);
            JsonNode addresses = rootNode.path("addresses");

            if (addresses.isArray() && addresses.size() > 0) {
                JsonNode location = addresses.get(0);
                String lat = location.path("y").asText(); // 위도
                String lon = location.path("x").asText(); // 경도

                return new String[]{lat, lon};
            }
        } catch (Exception e) {
            e.printStackTrace(); // 예외 처리
        }

        return null; // 위치 정보가 없을 경우 null 반환
    }
}