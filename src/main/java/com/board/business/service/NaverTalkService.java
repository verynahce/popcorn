package com.board.business.service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Service
public class NaverTalkService {

    @Value("${naver.chatbot.api.url}")
    private String chatbotApiUrl;

    @Value("${naver.chatbot.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;

    public NaverTalkService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // 예약 확정 후 알림을 보낼 메서드
    public String sendReservationConfirmation(String userId, String reservationDetails) {
        // API 요청 URL 생성
        String url = UriComponentsBuilder.fromHttpUrl(chatbotApiUrl)
            .path("/send-message")
            .queryParam("userId", userId)
            .queryParam("message", reservationDetails)
            .toUriString();

        // Authorization 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + apiKey);
        headers.set("Content-Type", "application/json");  // API에서 이 헤더가 필요할 경우 추가

        // HTTP 요청 엔티티 생성 (본문과 헤더)
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // Naver TalkTalk API에 HTTP 요청 보내기
        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
            // Naver API에서 받은 응답 반환
            return response.getBody();
        } catch (Exception e) {
            // 오류 로그 출력 및 실패 메시지 반환
            Logger logger = LoggerFactory.getLogger(NaverTalkService.class);
            logger.error("예약 확정 메시지 전송 오류: ", e);
            return "{\"status\":\"failure\", \"message\":\"메시지 전송에 실패했습니다.\"}";
        }
    }
}

