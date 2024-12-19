package com.board.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import jakarta.servlet.DispatcherType;
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private UserDetailsService userDetailsService;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf().disable()
        	//.cors().disable() // CORS 설정
        	//.and()
	        .authorizeHttpRequests((auth) -> auth
	                .requestMatchers("/**", "/Users/Signup", "/Users/Login", "/Users/LoginForm", "/Users/SignupForm", "/resources/**", "/WEB-INF/view/**").permitAll()
	                .requestMatchers("/css/**","/images/**", "/img/**","/static/**").permitAll()
	                .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
	                .dispatcherTypeMatchers(DispatcherType.INCLUDE).permitAll()
	                .anyRequest().authenticated()
	        )
	        .formLogin(form -> form
        	    .loginPage("/Users/LoginForm") // 로그인 폼 페이지 URL
        	    .loginProcessingUrl("/Users/Login") // 로그인 처리 URL
        	    .usernameParameter("id") // 사용자 ID 필드 이름 설정
        	    .passwordParameter("password") // 비밀번호 필드 이름 설정
        	    .defaultSuccessUrl("/") // 로그인 성공 시 이동할 URL
        	    .failureUrl("/Users/LoginForm?error") // 로그인 실패 시 이동할 URL
        	    .permitAll()
        	)
            .logout(logout -> logout
                .logoutUrl("/Logout")
                .logoutSuccessUrl("/")
                .permitAll()
            );
        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        return http.getSharedObject(AuthenticationManagerBuilder.class)
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder())
                .and()
                .build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
