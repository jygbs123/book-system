package com.itmk.web.book_borrow.entity;


import lombok.Data;

@Data
public class ReturnParm {

    private Long borrowId;
    //图书id
    private Long bookId;
}