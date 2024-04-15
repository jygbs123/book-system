package com.itmk.web.sys_category.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("sys_category")
public class SysCategory {
    @TableId(type = IdType.AUTO)
    private Long categoryId;
    private String categoryName;
    private Long orderNum;
}
