package com.mySelection.domain;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MemberVO {

    private String id;
    private String passwd;
    private String email;
    private String nickname;
    private String profileImage;
    private String birthday;
    private String ageRange;
    private String gender;
    private String receiveEmail;
    private Timestamp regDate;
    private String joinType;



}
