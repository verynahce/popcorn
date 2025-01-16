package com.board.util;

import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.web.DefaultOAuth2AuthorizationRequestResolver;
import org.springframework.security.oauth2.client.web.OAuth2AuthorizationRequestResolver;
import org.springframework.security.oauth2.core.endpoint.OAuth2AuthorizationRequest;

import jakarta.servlet.http.HttpServletRequest;

public class CustomOAuth2AuthorizationRequestResolver implements OAuth2AuthorizationRequestResolver {

    private final DefaultOAuth2AuthorizationRequestResolver defaultResolver;

    public CustomOAuth2AuthorizationRequestResolver(ClientRegistrationRepository clientRegistrationRepository, String authorizationRequestBaseUri) {
        this.defaultResolver = new DefaultOAuth2AuthorizationRequestResolver(clientRegistrationRepository, authorizationRequestBaseUri);
    }

    @Override
    public OAuth2AuthorizationRequest resolve(HttpServletRequest request) {
        OAuth2AuthorizationRequest authorizationRequest = defaultResolver.resolve(request);
        return customizeAuthorizationRequest(request, authorizationRequest);
    }

    @Override
    public OAuth2AuthorizationRequest resolve(HttpServletRequest request, String clientRegistrationId) {
        OAuth2AuthorizationRequest authorizationRequest = defaultResolver.resolve(request, clientRegistrationId);
        return customizeAuthorizationRequest(request, authorizationRequest);
    }

    private OAuth2AuthorizationRequest customizeAuthorizationRequest(HttpServletRequest request, OAuth2AuthorizationRequest authorizationRequest) {
        if (authorizationRequest == null) {
            return null;
        }

        String userAgent = request.getHeader("User-Agent");
        String redirectUri = authorizationRequest.getRedirectUri();
        // 현재 URL 경로 확인
        String path = request.getRequestURI();

        // User-Agent에 따라 리다이렉트 URI 변경
        if (userAgent != null && userAgent.contains("wv")||userAgent.contains("Dart")||userAgent.contains("Mobile")) {
            // URL 경로에 따라 추가적인 리다이렉트 처리
            if (path.contains("kakao")) {
                // 카카오 관련 URI 설정
                redirectUri = "http://192.168.0.209:9090/Mobile/oauth2/callback/kakao";
            } else if (path.contains("naver")) {
                // 네이버 관련 URI 설정
                redirectUri = "http://192.168.0.209:9090/Mobile/oauth2/callback/naver";
            }
        }

        // 디버깅 로그 추가
        System.out.println("User-Agent: " + userAgent);
        System.out.println("Redirect URI: " + redirectUri);

        return OAuth2AuthorizationRequest.from(authorizationRequest)
                .redirectUri(redirectUri)
                .build();
    }
}
