package com.board.users.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PopcornVo {
    private int log_Id; // 로그 ID
    private String user_Id; // 사용자 ID
    private String content; // 내용
    private int earned_Points; // 지급 포인트
    private int spent_Points; // 지출 포인트
    private int total_Points; // 총 포인트
    private String content_Info; // 내용
    private String add_Date; // 내용
    
    private String attendance_Status;  // 출석 상태 ('on', 'off')
    private String attendance_Date;  // 출석 날짜
    private int consecutive_Attendance_Days;  // 연속 출석 일수
    private int total_Attendance_Days; 

}

