package com.board.util;

import java.util.Date;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import jakarta.servlet.http.HttpServletResponse;

import io.jsonwebtoken.ExpiredJwtException;
import java.io.IOException;

@Component
public class JwtUtil {

    private final Logger logger = LoggerFactory.getLogger(JwtUtil.class);

    private final String SECRET_KEY = "46930csaefnioweanelbe589eea5b0f43819599a3749d88e26fff284659a26f4baecffc1e7ba574d24d4da5164bf2cf21670ce983d58eb91c";

    private final HttpServletResponse response = null;


    public String generateToken(String username, String userType, boolean is2faAuthenticated) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("userType", userType); // 사용자 유형을 클레임에 추가
        claims.put("is2faAuthenticated", is2faAuthenticated);
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 10)) //10시간
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }

    public String extractUsername(String token) {
        try {
            Claims claims = Jwts.parser()
                    .setSigningKey(SECRET_KEY)
                    .parseClaimsJws(token)
                    .getBody();
            String username = claims.getSubject(); // username은 항상 문자열

            // 중괄호로 시작하고 끝나는지 확인
            if (username.startsWith("{") && username.endsWith("}")) {
                return extractIdFromString(username); // 문자열에서 id 추출
            }

            return username; // 형식이 아닐 경우 username 그대로 반환

        } catch (ExpiredJwtException e) {
            return null;
        } catch (Exception e) {
            return null;
        }
    }

    private String extractIdFromString(String userString) {
        // 정규 표현식 패턴 정의
        Pattern pattern = Pattern.compile("id=([^,}]+)");
        Matcher matcher = pattern.matcher(userString);

        if (matcher.find()) {
            return matcher.group(1); // id 값 반환
        }

        return null; // id가 없을 경우 null 반환
    }

    public String extractUserType(String token) {
        return Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody()
                .get("userType", String.class); // "userType" 클레임을 가져옴
    }

    public boolean validateToken(String token, UserDetails userDetails) {
        final String username = extractUsername(token);
        return username.equals(userDetails.getUsername()) && !isTokenExpired(token);
    }

    public boolean validatableToken(String token) {
        try {
            Jwts.parserBuilder().setSigningKey(SECRET_KEY).build().parseClaimsJws(token);
            return true;
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }

    public boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    private Date extractExpiration(String token) {
        return Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token).getBody().getExpiration();
    }

    public boolean validateToken(String jwt, OAuth2User oauth2User) {
        final String username = extractUsername(jwt);
        return username.equals(oauth2User.getName()) && !isTokenExpired(jwt);
    }

    // JWT 토큰에서 Claims 추출
    public Claims getClaimsFromToken(String jwt) {
        try {
            return Jwts.parser()
                    .setSigningKey(SECRET_KEY)
                    .parseClaimsJws(jwt)
                    .getBody();
        } catch (JwtException e) {
            return null; // 토큰 파싱 실패 시 null 반환
        }
    }

}
