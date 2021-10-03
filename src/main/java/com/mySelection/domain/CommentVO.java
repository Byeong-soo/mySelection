package com.mySelection.domain;

import lombok.Data;
import java.sql.Timestamp;

@Data
public class CommentVO {
    private Integer num;
    private String mid;
    private String nickname;
    private String content;
    private Timestamp regDate;
    private String ipaddr;
    private Integer reRef;
    private Integer reLev;
    private Integer reSeq;
    private Integer bno;

}
