package com.mySelection.domain;

import lombok.Data;

@Data
public class ClassificationVO {
    String id;
    String title;
    String type;
    String firstParent;
    String secondParent;

}
