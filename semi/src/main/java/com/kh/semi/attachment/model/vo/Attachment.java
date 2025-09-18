package com.kh.semi.attachment.model.vo;

import lombok.*;

import java.sql.Date;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Attachment {
    private int attNo;
    private String attChangeName;
    private String attOrigin;
    private int refNo;
    private int attCategory;
    private String attFilePath;
    private Date createDate;
}
