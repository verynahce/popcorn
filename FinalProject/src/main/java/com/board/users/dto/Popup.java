package com.board.users.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Popup {

    private Long storeIdx;
    private String title;
    private double latitude;
    private double longitude;
    private int hitCount;
    private String startDate;
    private String endDate;
    private String igdate;
    private String imagePath;

}