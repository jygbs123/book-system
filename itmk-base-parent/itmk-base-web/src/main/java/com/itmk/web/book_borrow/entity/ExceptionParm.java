package com.itmk.web.book_borrow.entity;

import lombok.Data;

@Data
public class ExceptionParm {
    private Long borrowId;
    //图书id
    private Long bookId;
    //判断是异常还是丢失 0：异常 1：丢失
    private String type;
    //异常还书备注
    private String excepionText;

}
