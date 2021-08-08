package com.mySelection.domain;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MemberVO {

    private String id;
    private String passwd;
    private String email;
    private String nickname;
    private String profileimg;
    private String birthday;
    private String ageRange;
    private String gender;
    private String recvEmail;
    private Timestamp regDate;
    private String joinType;



}
