package com.mySelection.domain;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class BoardVO {
    private Integer num;
    private String mid;
    private String subject;
    private String content;
    private Integer readCount;
    private Timestamp regDate;
    private String ipaddr;
    private Integer reRef;
    private Integer reLev;
    private Integer reSeq;
}

