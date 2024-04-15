package com.itmk.web.book_borrow.entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class LookBorrow {
    private Long readerId;
    private Long borrowId;
    private Long bookId;
    private String bookName;
    private String bookPlaceNum;
    private String username;
    private String learnNum;
    private String className;
    private String phone;
    private String borrowStatus;
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    private Date borrowTime;
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    private Date returnTime;
    private String applyStatus;
    private String returnStatus;
    private String excepionText;
    private String applyText;
    private String timeStatus;
}