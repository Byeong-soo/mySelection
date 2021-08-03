package com.mySelection.domain;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MemberVO {

    private String id;
    private String passwd;
    private String nickname;
    private String profileimg;
    private String birthday;
    private String age_range;
    private String gender;
    private String email;
    private String recvEmail;
    private Timestamp regDate;
    private String jointype;



}
