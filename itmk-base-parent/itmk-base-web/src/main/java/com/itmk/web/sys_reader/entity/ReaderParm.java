package com.itmk.web.sys_reader.entity;

import lombok.Data;

@Data
public class ReaderParm {
    private Long currentPage;
    private Long pageSize;
    private String username;
    private String idCard;
    private String phone;
    private String learnNum;
}
