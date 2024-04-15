package com.itmk.web.book_borrow.entity;


import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class BorrowParm {
    private Long borrowId;
    //借书人id
    private Long readerId;
    //图书id
    private List<Long> bookIds;
    //还书时间
    private Date returnTime;
}