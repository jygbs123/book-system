package com.itmk.web.sys_category.entity;

import lombok.Data;

@Data
public class ListCateParm {
    private Long currentPage;
    private Long pageSize;
    private String categoryName;
}
